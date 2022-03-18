resource "google_compute_managed_ssl_certificate" "default" {
  name = var.name

  managed {
    domains = [var.domain]
  }
}
