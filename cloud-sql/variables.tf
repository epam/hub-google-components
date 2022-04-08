variable "name" {
  type = string
}

variable "network" {
  type = string
  default = "default"
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "public_ip" {
  type = bool
  default = false
}

variable "authorized_networks" {
  default = [
    {
      "name"  = "all",
      "value" = "0.0.0.0/0"
    }
  ]
}

variable "database_version" {
  type    = string
  default = "MYSQL_5_7"
}

variable "availability_type" {
  type    = string
  default = "ZONAL"
}

variable "allocated_ip_range_name" {
  type    = string
  default = null
}
