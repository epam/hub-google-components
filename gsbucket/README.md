# GS Bucket

This component deployms a new gsbucket using Terraform. It will return a HMAK keys for further `s3` like access.

At present this is a minimum viable gsbucket, possibly component will be extended in the future

## Implementation Details

The component has the following directory structure:

```text
./
├── hub-component.yaml       # Parameters definitions
└── main.tf                  # Terraform script
```

## Parameters

The following component level parameters has been defined `hub-component.yaml`

| Name | Description | Default Value |
| :--- | :---        | :---          |
| `bucket.name` | Name of the bucket, defaults to name of the component | `${hub.componentName}` |
| `bucket.region` | Bucket region, to be passed as location | region form gcloud config |
| `gcp.serviceAccount` | If not empty then HMAK keys will be generated for this service account email | |


> Note: bucket location has been detected from current in the gcloud client

> Note: parameters has been passed to terraform as `TF_VAR_*` environment variables


## Outputs

The following component level parameters has been defined `hub-component.yaml`

Outputs will be generated if and only if `gcloud.serviceAccount` has been set

| Name | Description | Default Value |
| :--- | :---        | :---          |
| `bucket.accessKey` | Generated HMAK key (sensitive parameter) | |
| `bucket.secretKey` | Generated HMAK secret (sensitive parameter) | |
