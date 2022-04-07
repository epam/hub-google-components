data "google_client_config" "current" {}

locals {
  # https://cloud.google.com/bigquery/docs/locations#regions
  us_locations = ["us-central1", "us-west4", "us-west2", "northamerica-northeast1", "us-east4", "us-west1", "us-west3", "southamerica-east1", "southamerica-west1", "us-east1", "northamerica-northeast2"]

  dataset_name = replace(var.dataset_name, "/[[:punct:]]/", "_")
  location     = contains(local.us_locations, var.location) ? "US" : "EU"
}

module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 5.4"

  dataset_id                 = local.dataset_name
  dataset_name               = local.dataset_name
  description                = var.description
  project_id                 = data.google_client_config.current.project
  location                   = local.location
  delete_contents_on_destroy = var.delete_contents_on_destroy
  tables = [
    {
      table_id           = var.table_name
      schema             = file("table-schema.json")
      time_partitioning  = null
      range_partitioning = null
      clustering         = []
      expiration_time    = null
      labels             = {}
    }
  ]
}

resource "google_bigquery_dataset_iam_member" "data_owner" {
  dataset_id = local.dataset_name
  role       = "roles/bigquery.dataOwner"
  member     = "serviceAccount:${var.compute_service_account}"

  depends_on = [
    module.bigquery
  ]
}

resource "google_bigquery_table_iam_member" "data_owner" {
  dataset_id = local.dataset_name
  table_id   = var.table_name
  role       = "roles/bigquery.dataOwner"
  member     = "serviceAccount:${var.compute_service_account}"

  depends_on = [
    module.bigquery
  ]
}
