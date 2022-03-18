module "private_service_access" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  version = "~> 9.0.0"

  ip_version  = "IPV4"
  project_id  = var.project
  vpc_network = var.network
}

module "sql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "~> 9.0.0"

  database_version     = "MYSQL_5_7"
  name                 = var.name
  project_id           = var.project
  region               = var.region
  zone                 = var.zone
  db_name              = var.db_name
  user_name            = var.db_user
  user_password        = var.db_password
  deletion_protection  = false
  random_instance_name = true

  ip_configuration = {
    authorized_networks = []
    ipv4_enabled        = var.public_ip
    private_network     = "projects/${var.project}/global/networks/${var.network}"
    require_ssl         = false
    allocated_ip_range  = module.private_service_access.google_compute_global_address_name
  }

  // Optional: used to enforce ordering in the creation of resources.
  module_depends_on = [module.private_service_access.peering_completed]
}
