
variable "name" {
  type = string
}


variable "network" {
  type = string
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
  default = "MYSQL_5_7"
}
