data "google_client_config" "current" {}

module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 5.4"

  dataset_id                 = var.dataset_name
  dataset_name               = var.dataset_name
  description                = var.description
  project_id                 = data.google_client_config.current.project
  location                   = var.location
  delete_contents_on_destroy = var.delete_contents_on_destroy
  tables = [
    {
      table_id           = var.table_name,
      schema             = file("table-schema.json"),
      time_partitioning  = null,
      range_partitioning = null,
      clustering         = [],
      expiration_time    = null,
      labels             = {}
    }
  ]
}

resource "google_bigquery_dataset_iam_member" "data_owner" {
  dataset_id = var.dataset_name
  role       = "roles/bigquery.dataOwner"
  member     = "serviceAccount:${var.compute_service_account}"

  depends_on = [
    module.bigquery
  ]
}

resource "google_bigquery_table_iam_member" "data_owner" {
  dataset_id = var.dataset_name
  table_id   = var.table_name
  role       = "roles/bigquery.dataOwner"
  member     = "serviceAccount:${var.compute_service_account}"

  depends_on = [
    module.bigquery
  ]
}
