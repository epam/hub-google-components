locals {
  mysql_database_versions = ["MYSQL_5_6", "MYSQL_5_7", "MYSQL_8_0"]
}

module "mysql" {
  count = contains(local.mysql_database_versions, var.database_version) ? 1 : 0

  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "~> 10.0"

  database_version     = var.database_version
  name                 = var.name
  project_id           = data.google_client_config.current.project
  region               = data.google_client_config.current.region
  zone                 = data.google_client_config.current.zone
  db_name              = var.db_name
  user_name            = var.db_user
  user_password        = var.db_password
  deletion_protection  = false
  random_instance_name = true
  availability_type    = var.availability_type

  ip_configuration = {
    authorized_networks = var.authorized_networks
    ipv4_enabled        = var.public_ip
    private_network     = local.private_network
    require_ssl         = false
    allocated_ip_range  = local.allocated_ip_range
  }
}
