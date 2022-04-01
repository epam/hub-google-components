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
