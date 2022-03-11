# Anthos Service Mesh

## Description

The component deploys Anthos Service mesh to the given GKE cluster

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── deploy.sh                        # `deploy` action implementation of the component                 
└── undeploy.sh                      # `undeploy` action implementation of the component                       
```

On `deploy` the component downloads Anthos Service Mesh installation script from well known Google location and calls `install` command

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| projectId | GCP project ID | (set on stack level)  | Yes
| dns.domain | Domain name of the stack | (set on stack level) | Yes
| component.anthosServiceMesh.clusterName | GKE cluster name | superhub | Yes
| component.anthosServiceMesh.zone | GKE cluster zone | us-central1-a | No
| component.anthosServiceMesh.region | GKE cluster region | us-central1 | No
| component.anthosServiceMesh.version | Anthos Service Mesh version | 1.11 | No

## Dependencies
The component requires:

* GKE cluster

## References

* [Anthos Service Mesh on GKE](https://cloud.google.com/service-mesh/docs/unified-install/quickstart-asm)
* [hub cli](https://github.com/agilestacks/hub/wiki)