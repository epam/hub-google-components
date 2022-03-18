terraform {
  required_version = ">= 1"
  backend "gcs" {}
}

provider "google" {
  project = var.project
}
