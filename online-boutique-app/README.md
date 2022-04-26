# Boutique App Component

## Description

Online Boutique is a cloud-native microservices demo application. Online Boutique consists of a 10-tier microservices application. The application is a web-based e-commerce app where users can browse items, add them to the cart, and purchase them.

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml                  # manifest file of the component with configuration and parameters
├── deploy.sh                           # `deploy` action implementation of the component
├── undeploy.sh                         # `undeploy` action implementation of the component
└── resources                           # directory for kubernetes resources
    ├── istio-manifests/                # directory contains istio kubernetes resources
    ├── kubernetes-manifests/           # directory contains application kubernetes resource
    ├── frontend-external.yaml          # application service resource
    └── frontend-ingress.yaml.template  # application ingress resource hub cli template
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.onlineBoutiqueApp.istioRevision` | Instio revision | | |
| `component.onlineBoutiqueApp.host` | | | x |
| `component.onlineBoutiqueApp.ingressGateway` | | | |
| `component.onlineBoutiqueApp.loadgenerator.numberOfReplicas` | Number of replicas for load generator | 3 | |
| `component.onlineBoutiqueApp.loadgenerator.numberOfUsers` | Number of users for load generator | 100 | |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.onlineBoutiqueApp.host` | Host name of application |

## Dependencies


## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Boutique App source code and docs](https://github.com/GoogleCloudPlatform/microservices-demo/)
