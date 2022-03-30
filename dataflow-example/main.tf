data "google_client_config" "current" {}

locals {
  project_id = data.google_client_config.current.project
  bucket     = "gs://${regex("(?://([^/?#]*))", var.composer_bucket)[0]}"
}

module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 5.4"

  dataset_id                 = var.dataset_name
  dataset_name               = var.dataset_name
  description                = var.description
  project_id                 = local.project_id
  location                   = var.location
  delete_contents_on_destroy = var.delete_contents_on_destroy
  tables = [
    {
      table_id           = var.table_name,
      schema             = file("table-schema.json"),
      time_partitioning  = null,
      range_partitioning = null,
      clustering         = [],
      expiration_time    = null,
      labels             = {}
    }
  ]
}

resource "null_resource" "upload_to_storage_bucket" {
  triggers = {
    bucket = local.bucket
  }

  provisioner "local-exec" {
    command = <<-EOC
gsutil cp dataflow_files/inputFile.txt ${self.triggers.bucket}
gsutil cp dataflow_files/transformCSVtoJSON.js ${self.triggers.bucket}
gsutil cp dataflow_files/jsonSchema.json ${self.triggers.bucket}
EOC
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOD
gsutil rm ${self.triggers.bucket}/inputFile.txt
gsutil rm ${self.triggers.bucket}/transformCSVtoJSON.js
gsutil rm ${self.triggers.bucket}/jsonSchema.json
EOD
  }
}

resource "null_resource" "upload_dag" {
  triggers = {
    env_name = var.composer_env_name
    location = data.google_client_config.current.region
  }

  provisioner "local-exec" {
    command = <<-EOC
gcloud composer environments storage dags import \
  --environment ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  --source dag/composer-dataflow-dag.py
EOC
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOD
  gcloud composer environments storage dags delete composer-dataflow-dag.py \
    --environment ${self.triggers.env_name} \
    --location ${self.triggers.location} \
  EOD
  }
}

resource "null_resource" "dataflow_template_operator_configuration" {
  triggers = {
    env_name     = var.composer_env_name
    location     = data.google_client_config.current.region
    project_id   = local.project_id
    gce_zone     = data.google_client_config.current.zone
    bucket       = local.bucket
    output_table = "${local.project_id}:${var.dataset_name}.${var.table_name}"
  }

  provisioner "local-exec" {
    command = <<-EOC
gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --set project_id ${self.triggers.project_id}

gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --set gce_zone ${self.triggers.gce_zone}

gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --set bucket_path ${self.triggers.bucket}

gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --set output_table ${self.triggers.output_table}
EOC
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOD
gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --delete project_id

gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --delete gce_zone

gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --delete bucket_path

gcloud composer environments run ${self.triggers.env_name} \
  --location ${self.triggers.location} \
  variables -- \
  --delete table_id
EOD
  }
}
