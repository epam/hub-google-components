provider "google" {}

provider "google-beta" {}

data "google_project" "host_project" {
  project_id = var.host_project_id
}

data "google_project" "service_project" {
  project_id = var.service_project_id
}

locals {
  activate_apis = [
    "container.googleapis.com",
    "dataproc.googleapis.com",
    "dataflow.googleapis.com",
    "composer.googleapis.com",
    "vpcaccess.googleapis.com",
  ]

  s_account_fmt = format(
    "serviceAccount:%s",
    google_service_account.default_service_account.email,
  )
  api_s_account = format(
    "%s@cloudservices.gserviceaccount.com",
    data.google_project.host_project.project_id,
  )
  api_s_account_fmt   = format("serviceAccount:%s", local.api_s_account)

  shared_vpc_users = compact(
    [
      local.s_account_fmt,
      local.api_s_account_fmt,
    ],
  )
  shared_vpc_users_length = 2
}

# Host project lien
resource "google_resource_manager_lien" "lien" {
  parent       = "projects/${data.google_project.host_project.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "shared-vpc"
  reason       = "Shared VPC host project lien"
}

# APIs configuration
module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 13.0"

  project_id    = data.google_project.service_project.number
  activate_apis = local.activate_apis
}

# Shared VPC configuration
#
# If Shared VPC Admin role is set at the folder level, use the google-beta provider.
# The google provider only supports this permission at project or organizational level currently.
resource "google_compute_shared_vpc_service_project" "shared_vpc_attachment" {
  provider = google-beta

  host_project    = data.google_project.host_project.number
  service_project = data.google_project.service_project.number
  depends_on      = [module.project_services]
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  provider = google-beta

  project    = data.google_project.host_project.number
  depends_on = [module.project_services]
}

resource "google_project_default_service_accounts" "default_service_accounts" {
  action         = "DISABLE"
  project        = data.google_project.host_project.project_id
  restore_policy = "REVERT_AND_IGNORE_FAILURE"
  depends_on     = [module.project_services]
}

# Default Service Account configuration
resource "google_service_account" "default_service_account" {
  account_id   = "project-service-account"
  display_name = "${data.google_project.host_project.project_id} Project Service Account"
  project      = data.google_project.host_project.project_id
}

# compute.networkUser role granted to APIs Service account, and Project Service Account
resource "google_project_iam_member" "controlling_group_vpc_membership" {
  count = local.shared_vpc_users_length

  project = data.google_project.host_project.project_id
  role    = "roles/compute.networkUser"
  member  = element(local.shared_vpc_users, count.index)

  depends_on = [
    module.project_services,
  ]
}

# compute.networkUser role granted to Project Service Account on vpc subnets
resource "google_compute_subnetwork_iam_member" "service_account_role_to_vpc_subnets" {
  provider = google-beta

  subnetwork = element(
    split("/", var.shared_subnetwork),
    index(split("/", var.shared_subnetwork), "subnetworks") + 1,
  )
  role = "roles/compute.networkUser"
  region = element(
    split("/", var.shared_subnetwork),
    index(split("/", var.shared_subnetwork), "regions") + 1,
  )
  project = data.google_project.host_project.project_id
  member  = local.s_account_fmt
}

# compute.networkUser role granted to APIs Service Account on vpc subnets
resource "google_compute_subnetwork_iam_member" "apis_service_account_role_to_vpc_subnets" {
  provider = google-beta

  subnetwork = element(
    split("/", var.shared_subnetwork),
    index(split("/", var.shared_subnetwork), "subnetworks") + 1,
  )
  role = "roles/compute.networkUser"
  region = element(
    split("/", var.shared_subnetwork),
    index(split("/", var.shared_subnetwork), "regions") + 1,
  )
  project = data.google_project.host_project.project_id
  member  = local.api_s_account_fmt

  depends_on = [
    module.project_services,
  ]
}

# module "shared_vpc_access" {
#   source  = "terraform-google-modules/project-factory/google//modules/shared_vpc_access"
#   version = "~> 13.0"

#   host_project_id                   = data.google_project.host_project.project_id
#   service_project_id                = data.google_project.service_project.project_id
#   service_project_number            = data.google_project.service_project.number
#   lookup_project_numbers            = false
#   enable_shared_vpc_service_project = true
#   active_apis                       = local.activate_apis
#   shared_vpc_subnets = [
#     var.shared_subnetwork
#   ]
# }
