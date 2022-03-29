variable "email_address" {
  default = ""
}

variable "acme_endpoint" {
  default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
  description = "ACME endpoint to be used (defaults to letsencrypt staging)"
}

variable "common_name" {}

variable "s3_bucket" {
  default = ""
}

variable "gs_bucket" {
  default = ""
}

variable "alternative_names" {
  default = ""
}

