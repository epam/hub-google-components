resource "google_compute_ssl_certificate" "this" {
  name_prefix = local.name_prefix
  description = "Lets encrypt for ${var.common_name}; imported by hub"
  certificate = acme_certificate.this.certificate_pem
  private_key = acme_certificate.this.private_key_pem

  lifecycle {
    create_before_destroy = true
  }
}


resource "time_sleep" "ssl_certificates_wait" {
  depends_on = [google_compute_ssl_certificate.this]

  destroy_duration = "60s"
}

output "google_cert_selflink" {
  value = google_compute_ssl_certificate.this.self_link
}
