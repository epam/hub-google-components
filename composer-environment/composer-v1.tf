# for additional parameters
# see: https://github.com/terraform-google-modules/terraform-google-composer/tree/master/modules/create_environment_v1
module "composer_v1" {
  count = var.composer_version == "v1" ? 1 : 0

  source  = "terraform-google-modules/composer/google//modules/create_environment_v1"
  version = "~> 3.0"

  composer_env_name       = var.composer_env_name
  disk_size               = var.node_disk_size
  enable_private_endpoint = var.composer_endpoint == "private"
  image_version           = local.airflow_image_version
  machine_type            = var.node_machine_type
  network                 = basename(data.google_compute_subnetwork.this.network)
  network_project_id      = var.network_project_id
  node_count              = var.node_count
  project_id              = data.google_client_config.current.project
  pypi_packages           = local.pypi_packages
  python_version          = var.python_version
  region                  = data.google_client_config.current.region
  subnetwork              = data.google_compute_subnetwork.this.name
  subnetwork_region       = data.google_compute_subnetwork.this.region
  zone                    = data.google_client_config.current.zone
}
