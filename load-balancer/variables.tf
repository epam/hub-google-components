
variable "name" {}

variable "network" {}

variable "instance_group" {}

variable "domain_name" {}

variable "ssl_certificate" {}

variable "backend_port" {
  type    = number
  default = 80
}

variable "backend_protocol" {
  default = "HTTP"
}

variable "backend_healthcheck_path" {
  default = "/"
}
