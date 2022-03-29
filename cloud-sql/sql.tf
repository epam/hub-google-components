locals {
  project_id = data.google_client_config.current.project
}

module "private_service_access" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  version = "~> 9.0.0"

  ip_version  = "IPV4"
  project_id  = local.project_id
  vpc_network = var.network
}

module "sql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "~> 9.0.0"

  database_version     = var.database_version
  name                 = var.name
  project_id           = local.project_id
  region               = data.google_client_config.current.region
  zone                 = data.google_client_config.current.zone
  db_name              = var.db_name
  user_name            = var.db_user
  user_password        = var.db_password
  deletion_protection  = false
  random_instance_name = true

  ip_configuration = {
    authorized_networks = var.authorized_networks
    ipv4_enabled        = var.public_ip
    private_network     = data.google_compute_network.current.id
    require_ssl         = false
    allocated_ip_range  = module.private_service_access.google_compute_global_address_name
  }

  // Optional: used to enforce ordering in the creation of resources.
  module_depends_on = [module.private_service_access.peering_completed]
}
