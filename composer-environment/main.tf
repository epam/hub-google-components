terraform {
  backend "gcs" {}
  required_version = ">= 0.12"
}

provider "google" {}

data "google_client_config" "current" {}

module "composer" {
  source  = "terraform-google-modules/composer/google"
  version = "~> 2.0"

  composer_env_name = var.common_name
  project_id        = data.google_client_config.current.project
  region            = data.google_client_config.current.region
  zone              = data.google_client_config.current.zone
  network           = var.common_name
  subnetwork        = var.common_name
}
