# Composer Environment

Deploys a new Composer Environment in cloud accout

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml
├── main.tf                     # terraform configuration
├── outputs.tf                  # terraform outputs
├── pre-deploy                  # enables composer api
├── post-deploy                 # to export a kubecontext
├── variables.tf                # terraform variable definitions
└── variables.tvars.template    # template file to supply terraform variables
```

* Pre deployent script will enable: `composer.googleapis.com`
* Post deployment script exports a GKE cluster configuration as in `kubeconfig` so other components would use possibly use it for their deployments

Terraform module has been inspired by [Create Composer Environment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/composer_environment) guide

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `gke.node.node` | Number of GKE nodes for compose environment. Must be at least `3` | `3` | x |
| `gke.node.machineType` | Number of GKE nodes for compose environment | `n1-standard-1` | x |
| `gke.node.diskSize` | GKE node disk size (in GB) | 100 | x |
| `composer.envName` | Name of Composer Environment | `{stackName}-{componentName}` | x |
| `composer.version` | Version of composer (`v1` or `v2`). It will activate corresponding module `create_environment_v1` or `create_environment_v2` | `v1` | x |
| `composer.python.version` | Version of python (`2` or `3`) | `3` | x |
| `composer.python.requirementsFile` | Path to the user's requirements txt (relative to component diretory) | `requirements.txt` | |
| `component.network.subnetwork` | Selfink to the subnetwork for compose environment | | x |

> Note: Cloud Composer V2 supports today limited amount of parameters. We expect situation will change as soon as Terraform and Google API will become stable. In this case we will feed module from official terraform registry rather from the vendor github repo

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `composer.airflow.url` | Airflow URL |
| `composer.gcs.bucket` | GCS bucket url |

## Dependencies

* Requires enable api: `composer.googleapis.com`
* This component largely relies on terraform module: [create_environment_v1]
* This component largely relies on terraform module: [create_environment_v2]

Please check terraform module documentation (links above) to learn about up-to-date configuration options details

## Troubleshootinh

Environment creation troubleshooting [guide](https://cloud.google.com/composer/docs/troubleshooting-environment-creation)
Python package installation troubleshooting [guide](https://cloud.google.com/composer/docs/troubleshooting-package-installation)
Environment update troubleshooting [guide](https://cloud.google.com/composer/docs/troubleshooting-updates-upgrades)

## See also

* [Composer Access Control](https://cloud.google.com/composer/docs/how-to/access-control)
* [hub cli](https://github.com/agilestacks/hub/wiki)
* [hub deployment for Terraform](https://github.com/agilestacks/hub-extensions/blob/gcp-extensions/documentation/hub-component-terraform.md)
* terraform module [create_environment_v1]
* terraform module [create_environment_v2]
* [Apache Airflow](http://airflow.apache.org/)

[create_environment_v1]: https://github.com/terraform-google-modules/terraform-google-composer/tree/master/modules/create_environment_v1
[create_environment_v2]: https://github.com/terraform-google-modules/terraform-google-composer/tree/master/modules/create_environment_v2
