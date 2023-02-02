variable "name" {
  type = string
}

variable "service_account" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

terraform {
  required_version = ">= 1"
  backend "gcs" {}
}

provider "google" {}

locals {
  location = coalesce(
    var.region,
    data.google_client_config.current.region,
    "US",
  )

  access_key_id = length(google_storage_hmac_key._) > 0 ? google_storage_hmac_key._[0].access_id : ""
  secret_key_id = length(google_storage_hmac_key._) > 0 ? google_storage_hmac_key._[0].secret : ""
}

data "google_client_config" "current" {}

resource "google_storage_bucket" "_" {
  name          = var.name
  location      = local.location
  force_destroy = true
}

resource "google_storage_hmac_key" "_" {
  count                 = var.service_account == "" ? 0 : 1
  service_account_email = var.service_account
}

output "access_key_id" {
  value     = local.access_key_id
  sensitive = true
}

output "secret_access_key" {
  value     = local.secret_key_id
  sensitive = true
}

output "location" {
  value = lower(google_storage_bucket._.location)
}
