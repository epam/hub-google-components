
data "google_dns_managed_zone" "zone" {
  name    = var.zone_name
  project = var.project
}

resource "google_dns_record_set" "record" {
  name         = join(".", compact([var.name, data.google_dns_managed_zone.zone.dns_name]))
  type         = var.record_type
  ttl          = var.record_ttl
  managed_zone = data.google_dns_managed_zone.zone.name
  project      = var.project

  rrdatas = [var.record_value]
}
