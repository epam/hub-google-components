terraform {
  required_version = ">= 1"
  backend "gcs" {}
}

provider "google" {}

variable "common_name" {
  type = string
}

variable "alternative_names" {
  type    = string
  default = ""
}

locals {
  # FIXME: current terraform doesn't have a nice way how to enter a list(str) a default value empty
  alt_names   = [for s in compact(split(" ", var.alternative_names)) : trimspace(s)]
  dns_names   = concat([var.common_name], local.alt_names)
  name_prefix = lower(replace(substr(var.common_name, 0, 36), ".", "-"))
}

resource "google_compute_managed_ssl_certificate" "default" {
  name        = local.name_prefix
  description = "GCP managed certificate for ${var.common_name}"

  managed {
    domains = local.dns_names
  }
}

output "google_cert_selflink" {
  value = google_compute_managed_ssl_certificate.default.self_link
}
