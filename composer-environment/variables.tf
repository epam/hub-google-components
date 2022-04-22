variable "composer_env_name" {}

variable "node_count" {
  type = number
}

variable "node_machine_type" {}

variable "subnetwork" {}

variable "composer_version" {
  default = "v1"
}

variable "node_disk_size" {
  default = 100
}

variable "python_version" {}

variable "requirements_txt" {}


variable "image_version" {
  default = null
}

variable "composer_endpoint" {
  default = "public"
}
