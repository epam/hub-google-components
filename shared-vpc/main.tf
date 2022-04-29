provider "google" {}

provider "google-beta" {}

data "google_project" "host_project" {
  project_id = var.host_project_id
}

data "google_project" "service_project" {
  project_id = data.google_project.service_project.number
}

locals {
  activate_apis = [
    "container.googleapis.com",
    "dataproc.googleapis.com",
    "dataflow.googleapis.com",
    "composer.googleapis.com",
    "vpcaccess.googleapis.com",
  ]
}

resource "google_resource_manager_lien" "lien" {
  parent       = "projects/${data.google_project.host_project.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "shared-vpc"
  reason       = "Shared VPC host project lien"
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 13.0"

  project_id    = data.google_project.service_project.number
  activate_apis = local.activate_apis
}

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

module "shared_vpc_access" {
  source  = "terraform-google-modules/project-factory/google//modules/shared_vpc_access"
  version = "~> 13.0"

  host_project_id                   = data.google_project.host_project.number
  service_project_id                = data.google_project.service_project.number
  enable_shared_vpc_service_project = true
  active_apis                       = local.activate_apis
  shared_vpc_subnets = [
    var.shared_subnetwork
  ]
}
