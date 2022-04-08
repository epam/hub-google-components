terraform {
  required_version = ">= 1"
  backend "gcs" {}
}

provider "google" {}

data "google_client_config" "current" {}

data "google_compute_network" "current" {
  name = var.network
}

locals {
  private_network    = var.allocated_ip_range_name == "" ? null : data.google_compute_network.current.id
  allocated_ip_range = var.allocated_ip_range_name == "" ? null : var.allocated_ip_range_name
}
