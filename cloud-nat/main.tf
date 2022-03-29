terraform {
  required_version = ">= 1"
  backend "gcs" {}
}

provider "google" {}

data "google_client_config" "current" {}

module "cloud_nat" {
  source            = "terraform-google-modules/cloud-nat/google"
  version           = "~> 2.1.0"
  network           = var.network
  create_router     = true
  router            = "${var.name}-router"
  project_id        = data.google_client_config.current.project
  region            = data.google_client_config.current.region
  name              = var.name
  log_config_enable = true
}
