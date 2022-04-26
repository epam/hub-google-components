# Google Kubernetes Engine Component

## Description

The component provisions GKE cluster in the given GCP project using `gcloud` CLI

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml                              # manifest file of the component with configuration and parameters
├── deploy.sh                                       # `deploy` action implementation of the component
├── undeploy.sh                                     # `undeploy` action implementation of the component
└── gcloud-container-clusters-create.yaml.template  # template of GKE cluster `create` command argument file
```

On `deploy` the component calls `gcloud` CLI `container clusters create` command. It reads cluster configuration from argument file template: [gcloud-container-clusters-create.yaml.template](gcloud-container-clusters-create.yaml.template).

The template contains the most common (default) configuration parameters of GKE cluster (see below). Users are welcomed to add more advanced cluster configuration settings directly to the template.

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `projectId` | GCP project ID | | x
| `dns.domain` | Domain name of the stack | | x |
| `component.gke.name` | GKE cluster name | superhub | x |
| `component.gke.version` | GKE cluster version | 1.21 | x |
| `component.gke.zone` | GKE cluster zone | us-central1-a | |
| `component.gke.region` | GKE cluster region | us-central1 | |
| `component.gke.machineType` | GKE cluster node type | e2-standard-4 | x |
| `component.gke.nodeCount` | Number of nodes in GKE cluster | 1 | x |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.gke.url` | GCP Console URL to GKE |

## References

* [gcloud create cluster command](https://cloud.google.com/sdk/gcloud/reference/container/clusters/create)
* [hub cli](https://github.com/agilestacks/hub/wiki)
