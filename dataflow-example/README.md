# Dataflow Example

Deploys a new BigQuery in cloud accout and run Dataflow Job from Composer.
This component is based on [`GCP tutorial`](https://cloud.google.com/composer/docs/how-to/using/using-dataflow-template-operato#task-status)

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml
├── dag/composer-dataflow-dag.py         # Airflow DAG file
├── dataflow_files/inputFile.txt         # Input data in CSV format
├── dataflow_files/jsonSchema.json       # JSON-formatted BigQuery schema for output table
├── dataflow_files/transformCSVtoJSON.js # JS script to transform CSV input data to JSON
├── table-schema.json                    # Big query table schema
├── main.tf                              # terraform configuration
├── outputs.tf                           # terraform outputs
├── pre-deploy                           # enables big query and dataflow api
├── post-deploy                          # upload dataflow files to GCS bucket, set DAG variables and DAG file
├── post-undeploy                        # remove dataflow files from GCS bucket, delete DAG variables and DAG file
└── variables.tf                         # terraform variable definitions
```

Pre deployent script will enable: `bigquery.googleapis.com`, `bigquerymigration.googleapis.com`, `bigquerystorage.googleapis.com`, `dataflow.googleapis.com`

### Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :-------- | :--:
| `dataflow-example.bigquery.datasetName` | BigQuery dataset name | | x
| `dataflow-example.bigquery.tableName` | BigQuery table name | | x
| `dataflow-example.bigquery.description` | BigQuery description | |
| `dataflow-example.bigquery.location` | BigQuery location. Could be US or EU | US |
| `dataflow-example.bigquery.deleteContentsOnDestroy` | If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present.| false |
| `dataflow-example.composer.envName` | Composer environment name | | x
| `dataflow-example.composer.bucket` | GCS bucket create by Composer component | | x

## Dependencies

* Requires enable api: `bigquery.googleapis.com`, `bigquerymigration.googleapis.com`, `bigquerystorage.googleapis.com`, `dataflow.googleapis.com`
* This component largely relies on terraform module: [terraform-google-modules/bigquery/google](https://registry.terraform.io/modules/terraform-google-modules/bigquery/google/latest)

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [hub deployment for Terraform](https://github.com/agilestacks/hub-extensions/blob/gcp-extensions/documentation/hub-component-terraform.md)
* [bigquery terraform module](https://registry.terraform.io/modules/terraform-google-modules/bigquery/google/latest)
