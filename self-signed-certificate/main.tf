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

resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "default" {
  private_key_pem = tls_private_key.default.private_key_pem

  # Certificate expires after 12 hours.
  validity_period_hours = 12

  # Generate a new certificate if Terraform is run within three
  # hours of the certificate's expiration time.
  early_renewal_hours = 3

  # Reasonable set of uses for a server SSL certificate.
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = local.dns_names

  subject {
    common_name  = var.common_name
    organization = "EPAM Systems, Inc."
  }
}

resource "google_compute_ssl_certificate" "default" {
  name_prefix = local.name_prefix
  description = "Self signed certificate for ${var.common_name}"
  private_key = tls_private_key.default.private_key_pem
  certificate = tls_self_signed_cert.default.cert_pem
}

output "google_cert_selflink" {
  value = google_compute_ssl_certificate.default.self_link
}
