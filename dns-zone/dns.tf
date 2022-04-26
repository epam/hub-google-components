data "google_dns_managed_zone" "base" {
  name    = var.base_name
}

resource "google_dns_managed_zone" "stack" {
  name        = var.name
  dns_name    = "${var.name}.${data.google_dns_managed_zone.base.dns_name}"
  description = "DNS Zone for Sandbox Stack"
}

resource "google_dns_record_set" "base_zone" {
  name         = google_dns_managed_zone.stack.dns_name
  type         = "NS"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.base.name

  rrdatas = google_dns_managed_zone.stack.name_servers
}
