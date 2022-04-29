# for additional parameters
# see: https://github.com/terraform-google-modules/terraform-google-composer/tree/master/modules/create_environment_v1
module "composer_v2" {
  count = var.composer_version == "v2" ? 1 : 0

  source  = "terraform-google-modules/composer/google//modules/create_environment_v2"
  version = "~> 3.0"

  composer_env_name       = var.composer_env_name
  enable_private_endpoint = var.composer_endpoint == "private"
  image_version           = local.airflow_image_version
  network                 = basename(data.google_compute_subnetwork.this.network)
  network_project_id      = var.network_project_id
  project_id              = data.google_client_config.current.project
  pypi_packages           = local.pypi_packages
  region                  = data.google_client_config.current.region
  subnetwork              = data.google_compute_subnetwork.this.name
  subnetwork_region       = data.google_compute_subnetwork.this.region
}
