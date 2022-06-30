# Nginx

The NGINX Ingress Controller an implementation of a Kubernetes Ingress Controller for NGINX and NGINX Plus.

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml    # manifest file of the component with configuration and parameters
└── values.yaml.template  # template for chart values file
```

## Parameters

| Name      | Description | Default Value | Required |
| :-------- | :--------   | :--------     | :--:     |
| `component.ingress.namespace` | The name of kubernetes namespace where to install helm chart. | ingress | x |
| `component.ingress.class` | The name of kubernetes ingress class. | nginx | x |
| `component.nginx.isDefaultIngress` | New Ingresses without an "ingressClassName" field specified will be assigned the class specified in controller.ingressClass. | false | x |
| `component.nginx.replicaCount` | The number of replicas of the Ingress Controller deployment. | 1 | x |
| `component.nginx.serviceType` | The type of service to create for the Ingress Controller. | LoadBalancer | x |
| `component.nginx.image` | The image repository of the Ingress Controller. | nginx/nginx-ingress | x |
| `component.nginx.imageTag` | The tag of the Ingress Controller image. | 2.2.2 | x |
| `component.nginx.helm.chart` | The name of helm chart. | nginx-ingress | x |
| `component.nginx.helm.repo` | The helm repository URL. | `https://helm.nginx.com/stable` | x |
| `component.nginx.helm.version` | The version of helm chart. | 0.13.2 | x |

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [NGINX Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/)
* [NGINX Ingress Controller Helm Chart](https://github.com/nginxinc/kubernetes-ingress/tree/main/deployments/helm-chart)
