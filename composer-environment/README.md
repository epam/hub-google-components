# Composer Environment

Deploys a new Composer Environment in cloud accout

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml
├── main.tf                     # terraform configuration
├── outputs.tf                  # terraform outputs
├── pre-deploy                  # enables composer api
├── variables.tf                # terraform variable definitions
└── main.tfvars.template        # template to supply terraform variables
```

Pre deployent script will enable: `composer.googleapis.com`

### Parameters

| Name      | Description | Default Value | Required    
| :-------- | :--------   | :-------- | :--:
| `gke.nodeCount` | Number of GKE nodes for compose environment. Must be at least `3` | `3` | x
| `gke.machineType` | Number of GKE nodes for compose environment | `n1-standard-1` | x
| `composer.version` | Version of composer (`v1` or `v2`) when `v2` it will set environment images to `composer-2.0.0-preview.3-airflow-2.1.2` | `v1` | x
| `component.network.subnetwork` | Selfink to the subnetwork for compose environment | | x |


## Dependencies

* Requires enable api: `composer.googleapis.com`
* This component largely relies on terraform module: [terraform-google-modules/composer/google](https://registry.terraform.io/modules/terraform-google-modules/composer/google/latest)

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [hub deployment for Terraform](https://github.com/agilestacks/hub-extensions/blob/gcp-extensions/documentation/hub-component-terraform.md)
* [composer terraform module](https://registry.terraform.io/modules/terraform-google-modules/composer/google/latest)
