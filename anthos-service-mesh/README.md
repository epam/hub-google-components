# Anthos Service Mesh

## Description

The component deploys Anthos Service mesh to the given GKE cluster

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── deploy.sh                        # `deploy` action implementation of the component
└── undeploy.sh                      # `undeploy` action implementation of the component
```

On `deploy` the component downloads Anthos Service Mesh installation script from well known Google location and calls `install` command

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `projectId` | GCP project ID | | x
| `dns.domain` | Domain name of the stack | | x |
| `component.anthosServiceMesh.clusterName` | GKE cluster name | superhub | x |
| `component.anthosServiceMesh.zone` | GKE cluster zone | us-central1-a | |
| `component.anthosServiceMesh.region` | GKE cluster region | us-central1 | |
| `component.anthosServiceMesh.version` | Anthos Service Mesh version | 1.11 | |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.anthosServiceMesh.revision` | Istio revision |
| `component.anthosServiceMesh.url` | Anthos service URL |

## Dependencies

The component requires:

* [GKE cluster](https://github.com/agilestacks/google-components/tree/main/gke-gcloud)

## References

* [Anthos Service Mesh on GKE](https://cloud.google.com/service-mesh/docs/unified-install/quickstart-asm)
* [hub cli](https://github.com/agilestacks/hub/wiki)
