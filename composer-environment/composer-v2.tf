module "composer_v2" {
  count             = var.composer_version == "v2" ? 1 : 0
  source            = "github.com/terraform-google-modules/terraform-google-composer//modules/create_environment_v2?ref=959db7d36dca43fa74866d79a91f1d5d1121fa16"
  composer_env_name = var.composer_env_name
  project_id        = data.google_client_config.current.project
  region            = data.google_client_config.current.region
  network           = basename(data.google_compute_subnetwork.this.network)
  subnetwork        = data.google_compute_subnetwork.this.name
}
