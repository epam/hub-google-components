terraform {
  backend "gcs" {}
  required_version = ">= 0.12"
}

# In case of deploying into Shared VPC you need to specify service project
provider "google" {
  project = var.project_id
}

data "google_client_config" "current" {}

data "google_compute_subnetwork" "this" {
  self_link = var.subnetwork
  project = var.network_project_id
}

data "local_file" "requirements_txt" {
  filename = var.requirements_txt
}

locals {
  airflow_image_version = var.image_version != "" ? var.image_version : null
  COMMENT_LINE          = "^\\s*#"
  SPLIT_BY_VERSION      = "(^\\w+)(.*)"
  requirements_lines = [
    for line in split("\n", data.local_file.requirements_txt.content) : line if trimspace(line) != ""
  ]
  requirement_pairs = [
    for line in compact(local.requirements_lines) : flatten(regexall(local.SPLIT_BY_VERSION, line)) if regexall(local.COMMENT_LINE, line) != []
  ]

  # This will look like the following structure:
  #
  # pypi_packages = {
  #   numpy = ""
  #   scipy = "==1.1.0"
  # }
  pypi_packages = {
    for pair in local.requirement_pairs : pair[0] => trimspace(pair[1])
  }
}
