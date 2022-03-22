output "airflow_uri" {
  value = module.composer.airflow_uri
}

output "gcs_bucket" {
  value = module.composer.gcs_bucket
}

output "gke_cluster" {
  value = module.composer.gke_cluster
}
