# Anthos Ingress Gateway

## Description

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml                  # manifest file of the component with configuration and parameters
├── deploy.sh                           # `deploy` action implementation of the component
├── undeploy.sh                         # `undeploy` action implementation of the component
└── resources                           # directory for hub cli resources templates
    ├── deployment.yaml.template        # kubernetes deployment template
    ├── role.yaml.template              # kubernetes role template
    ├── service.yaml.template           # kubernetes service template
    └── serviceaccount.yaml.template    # kubernetes service account template
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `projectId` | GCP project ID | | x
| `dns.domain` | Domain name of the stack | | x
| `component.gke.name` | GKE cluster name | | x
| `component.gke.zone` | GKE cluster location zone | |
| `component.anthosServiceMesh.revision` | | | x
| `component.anthosIngressGateway.name` | Kubernetes resource name | default-gateway |
| `component.anthosIngressGateway.namespace` | Kubernetes namespace | istio-ingress |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.anthosIngressGateway.ip` | IP of the Ingress Gateway load balancer |

## Dependencies

The component requires:

* GKE cluster

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Anthos Service Mesh](https://cloud.google.com/service-mesh/docs/gateways)
