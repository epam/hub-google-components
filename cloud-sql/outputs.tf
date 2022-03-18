output "db_password_raw" {
  value     = var.db_password == "" ? module.sql.generated_user_password : var.db_password
  sensitive = true
}

output "private_ip" {
  value = module.sql.private_ip_address
}

output "public_ip" {
  value = module.sql.public_ip_address
}
