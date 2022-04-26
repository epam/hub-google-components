provider "google" {}

data "google_organization" "this" {
  domain = "agilestacks.com"
}

# data "google_billing_account" "this" {
#   open = true
# }

data "google_client_config" "this" {}

data "google_compute_subnetwork" "default" {
  self_link = var.shared_subnetwork
}

resource "google_folder" "this" {
  display_name = var.folder_display_name
  parent       = data.google_organization.this.org_id
}

# module "service_project" {
#   # "terraform-google-modules/project-factory/google"
#   source             = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
#   version            = "12.0.0"
#   name               = var.name
#   random_project_id  = false
#   org_id             = data.google_organization.this.org_id
#   billing_account    = data.google_billing_account.this.id
#   shared_vpc         = data.google_client_config.this.project
#   shared_vpc_subnets = [data.google_compute_subnetwork.default.self_link]

#   activate_apis = [
#     "compute.googleapis.com",
#     "container.googleapis.com",
#     "dataproc.googleapis.com",
#     "dataflow.googleapis.com",
#   ]
# }

resource "google_compute_shared_vpc_service_project" "service1" {
  host_project    = data.google_client_config.this.project
  service_project = data.google_client_config.this.project
}


# module "shared_vpc" {
#   source  = "terraform-google-modules/project-factory/google"
#   version = "12.0.0"

#   organization_id   = data.google_organization.this.org_id
#   billing_account   = data.google_billing_account.this.id
#   host_project_name = data.google_client_config.this.project
#   network_name      = "superhub-shared"
#   folder_id         = google_folder.department1.name
# }
