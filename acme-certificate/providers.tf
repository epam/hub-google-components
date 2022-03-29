terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
  }
}

provider "google" {}

provider "acme" {
  server_url = var.acme_endpoint
}
