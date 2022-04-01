variable "dataset_name" {
  type = string
}

variable "table_name" {
  type = string
}

variable "description" {
  type = string
}

variable "location" {
  type        = string
  default     = "US"
  description = "The regional location for the dataset only US and EU are allowed in module"
}

variable "delete_contents_on_destroy" {
  type        = bool
  description = "If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present."
  default     = false
}

variable "compute_service_account" {
  type = string
  description = "Default service account role of compute engine where dataflow job will be run"
}
