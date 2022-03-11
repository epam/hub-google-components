# Google Kubernetes Engine Component

## Description

The component provisions GKE cluster in the given GCP project using `gcloud` CLI

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── deploy.sh                        # `deploy` action implementation of the component
├── undeploy.sh                      # `undeploy` action implementation of the component
└── gcloud-...-create.yaml.template  # template of GKE cluster `create` command argument file                       
```

On `deploy` the component calls `gcloud` CLI `container clusters create` command. It reads cluster configuration from argument file template: [gcloud-container-clusters-create.yaml.template](gcloud-container-clusters-create.yaml.template). 

The template contains the most common (default) configuration parameters of GKE cluster (see below). Users are welcomed to add more advanced cluster configuration settings directly to the template.

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| projectId | GCP project ID | (set on stack level)  | Yes
| dns.domain | Domain name of the stack | (set on stack level) | Yes
| component.gke.name | GKE cluster name | superhub | Yes
| component.gke.version | GKE cluster version | 1.21 | Yes
| component.gke.zone | GKE cluster zone | us-central1-a | No
| component.gke.region | GKE cluster region | us-central1 | No
| component.gke.machineType | GKE cluster node type | e2-standard-4 | Yes
| component.gke.nodeCount | Number of nodes in GKE cluster | 1 | Yes

## Dependencies

This component does not have any dependancies

## References

* [gcloud create cluster command](https://cloud.google.com/sdk/gcloud/reference/container/clusters/create)
* [hub cli](https://github.com/agilestacks/hub/wiki)
