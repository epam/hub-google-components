variable "composer_env_name" {}

variable "node_count" {
  type = number
}

variable "node_machine_type" {}

variable "subnetwork" {}

variable "composer_version" {
  default = "v1"
}
