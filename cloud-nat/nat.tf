module "cloud_nat" {
  source            = "terraform-google-modules/cloud-nat/google"
  version           = "~> 2.1.0"
  network           = var.network
  create_router     = true
  router            = "${var.name}-router"
  project_id        = var.project
  region            = var.region
  name              = var.name
  log_config_enable = true
}
