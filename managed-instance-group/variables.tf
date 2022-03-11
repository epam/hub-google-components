variable "project" {
  type = string
}

variable "hostname_prefix" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "service_account" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "region" {
  type = string
}

variable "image_project" {
  type = string
}

variable "image" {
  type = string
}

variable "port" {
  type = number
}

variable "target_size" {
  type = string
}

variable "nat_router_name" {
  type = string
}
