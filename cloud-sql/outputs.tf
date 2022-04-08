locals {
  generated_user_password_mssql      = length(module.mssql) > 0 ? module.mssql[0].generated_user_password : ""
  generated_user_password_mysql      = length(module.mysql) > 0 ? module.mysql[0].generated_user_password : ""
  generated_user_password_postgresql = length(module.postgresql) > 0 ? module.postgresql[0].generated_user_password : ""

  private_ip_mssql      = length(module.mssql) > 0 ? module.mssql[0].private_address : ""
  private_ip_mysql      = length(module.mysql) > 0 ? module.mysql[0].private_ip_address : ""
  private_ip_postgresql = length(module.postgresql) > 0 ? module.postgresql[0].private_ip_address : ""

  public_ip_mssql      = length(module.mssql) > 0 ? module.mssql[0].instance_first_ip_address : ""
  public_ip_mysql      = length(module.mysql) > 0 ? module.mysql[0].public_ip_address : ""
  public_ip_postgresql = length(module.postgresql) > 0 ? module.postgresql[0].public_ip_address : ""
}

output "password" {
  value     = coalesce(var.db_password, local.generated_user_password_mssql, local.generated_user_password_mysql, local.generated_user_password_postgresql)
  sensitive = true
}

output "private_ip" {
  value = coalesce(local.private_ip_mssql, local.private_ip_mysql, local.private_ip_postgresql, "-")
}

output "public_ip" {
  value = coalesce(local.public_ip_mssql, local.public_ip_mysql, local.public_ip_postgresql, "-")
}
