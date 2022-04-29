variable "composer_env_name" {}

variable "node_count" {
  default = 3
}

variable "node_machine_type" {}

variable "subnetwork" {}

variable "composer_version" {
  default = "v1"
}

variable "node_disk_size" {
  default = 100
}

variable "python_version" {
  default = 3
}

variable "requirements_txt" {}

variable "image_version" {
  default = null
}

variable "composer_endpoint" {
  default = "public"
}

variable "project_id" {}

variable "network_project_id" {}
