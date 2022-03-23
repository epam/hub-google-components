terraform {
  backend "gcs" {}
  required_version = ">= 0.12"
}

provider "google" {}

data "google_client_config" "current" {}

data "google_compute_subnetwork" "this" {
  self_link = var.subnetwork
}

locals {
  network_name  = basename(data.google_compute_subnetwork.this.network)
  image_version = var.composer_version == "v2" ? "composer-2.0.0-preview.3-airflow-2.1.2" : null
}

module "composer" {
  source            = "terraform-google-modules/composer/google//modules/create_environment"
  composer_env_name = var.composer_env_name
  project_id        = data.google_client_config.current.project
  region            = data.google_client_config.current.region
  zone              = data.google_client_config.current.zone
  image_version     = local.image_version
  node_count        = var.node_count
  machine_type      = var.node_machine_type
  network           = local.network_name
  subnetwork        = data.google_compute_subnetwork.this.name
}
