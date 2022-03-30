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
  network_name = basename(data.google_compute_subnetwork.this.network)
}

# TODO: Implement composer v2 when issue #36 (see below) will be published to terraform registry
# https://github.com/terraform-google-modules/terraform-google-composer/pull/36 
# Follow publishing process can here: https://github.com/terraform-google-modules/terraform-google-composer/pull/40 
module "composer" {
  source            = "terraform-google-modules/composer/google//modules/create_environment"
  version           = ">= 2.4.0"
  composer_env_name = var.composer_env_name
  project_id        = data.google_client_config.current.project
  region            = data.google_client_config.current.region
  zone              = data.google_client_config.current.zone
  node_count        = var.node_count
  machine_type      = var.node_machine_type
  network           = local.network_name
  subnetwork        = data.google_compute_subnetwork.this.name
}
