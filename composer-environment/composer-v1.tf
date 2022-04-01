module "composer_v1" {
  count  = var.composer_version == "v1" ? 1 : 0
  source = "github.com/terraform-google-modules/terraform-google-composer//modules/create_environment_v1?ref=959db7d36dca43fa74866d79a91f1d5d1121fa16"
  #   project = data.google_client_config.current.project
  #   name    = var.composer_env_name
  #   region  = data.google_client_config.current.region

  #   config {
  #     node_count = var.node_count
  #     node_config {
  #       zone         = data.google_client_config.current.zone
  #       machine_type = var.node_machine_type
  #       network      = local.network_name
  #       subnetwork   = data.google_compute_subnetwork.this.name
  #     }
  #   }

  composer_env_name = var.composer_env_name
  project_id        = data.google_client_config.current.project
  region            = data.google_client_config.current.region
  zone              = data.google_client_config.current.zone
  node_count        = var.node_count
  machine_type      = var.node_machine_type
  network           = local.network_name
  subnetwork        = data.google_compute_subnetwork.this.name
  disk_size         = 100
}
