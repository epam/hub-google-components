terraform {
  required_version = ">= 1"
  backend "gcs" {}
}

provider "google" {}

data "google_client_config" "current" {}

data "google_compute_network" "current" {
  name = var.network
}
