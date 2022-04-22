locals {
  airflow_uri_composer_v1 = length(module.composer_v1) > 0 ? module.composer_v1[0].airflow_uri : ""
  airflow_uri_composer_v2 = length(module.composer_v2) > 0 ? module.composer_v2[0].airflow_uri : ""
  gcs_bucket_composer_v1  = length(module.composer_v1) > 0 ? module.composer_v1[0].gcs_bucket : ""
  gcs_bucket_composer_v2  = length(module.composer_v2) > 0 ? module.composer_v2[0].gcs_bucket : ""
  gke_cluster_composer_v1 = length(module.composer_v1) > 0 ? module.composer_v1[0].gke_cluster : ""
  gke_cluster_composer_v2 = length(module.composer_v2) > 0 ? module.composer_v2[0].gke_cluster : ""
  env_id_composer_v1      = length(module.composer_v1) > 0 ? module.composer_v1[0].composer_env_id : ""
  env_id_composer_v2      = length(module.composer_v2) > 0 ? module.composer_v2[0].composer_env_id : ""
}

output "airflow_uri" {
  value = coalesce(local.airflow_uri_composer_v1, local.airflow_uri_composer_v2)
}

output "gcs_bucket" {
  value = coalesce(local.gcs_bucket_composer_v1, local.gcs_bucket_composer_v2)
}

output "gke_cluster" {
  value = coalesce(local.gke_cluster_composer_v1, local.gke_cluster_composer_v2)
}

output "env_id" {
  value = coalesce(local.env_id_composer_v1, local.env_id_composer_v2)
}
