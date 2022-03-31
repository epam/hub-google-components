
locals {
  # FIXME: current terraform doesn't have a nice way how to enter a list(str) a default value empty
  alt_names   = [for s in compact(split(" ", var.alternative_names)) : trimspace(s)]
  dns_names   = concat([var.common_name], local.alt_names)
  email       = coalesce(var.email_address, "admin@${var.common_name}")
  output_dir  = "${path.module}/outputs/${var.common_name}"
  name_prefix = lower(replace(substr(var.common_name, 0, 36), ".", "-"))
}

resource "tls_private_key" "registration" {
  algorithm = "RSA"
}

resource "acme_registration" "this" {
  account_key_pem = tls_private_key.registration.private_key_pem
  email_address   = local.email
}

data "google_client_config" "current" {}

# resource "tls_cert_request" "req" {
#   key_algorithm   = "RSA"
#   private_key_pem = tls_private_key.cert_private_key.private_key_pem
#   dns_names       = local.dns_names

#   subject {
#     common_name = var.common_name
#   }
# }

resource "acme_certificate" "this" {
  common_name                   = var.common_name
  subject_alternative_names     = local.alt_names
  account_key_pem               = acme_registration.this.account_key_pem
  revoke_certificate_on_destroy = true
  disable_complete_propagation  = true
  recursive_nameservers         = ["8.8.8.8:53"]
  pre_check_delay               = 30
  # var.pre_check_delay

  dns_challenge {
    provider = "gcloud"
    config = {
      GCE_PROJECT = data.google_client_config.current.project
    }
  }
}

resource "local_sensitive_file" "certificate" {
  content         = acme_certificate.this.certificate_pem
  filename        = "${local.output_dir}/certificate.pem"
  file_permission = "400"
}

output "cert_file" {
  value = "file://${local_sensitive_file.certificate.filename}"
}

resource "local_sensitive_file" "private_key" {
  content         = acme_certificate.this.private_key_pem
  filename        = "${local.output_dir}/certificate-key.pem"
  file_permission = "400"
}

output "key_file" {
  value = "file://${local_sensitive_file.private_key.filename}"
}

resource "local_sensitive_file" "chain" {
  content         = join("", ["${acme_certificate.this.certificate_pem}${acme_certificate.this.issuer_pem}"])
  filename        = "${local.output_dir}/certificate-chain.pem"
  file_permission = "400"
}


output "chain_file" {
  value = "file://${local_sensitive_file.chain.filename}"
}
