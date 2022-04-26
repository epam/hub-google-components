# GCP Load Balancer Component

## Description

Terraform based component which creates GCP Load Balancer. Based on official [Google terraform module for Load Balancer]

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml          # manifest file of the component with configuration and parameters
├── load-balancer.tf            # terraform implementation of component
├── main.tf                     # terraform configuration
├── outputs.tf                  # terraform outputs
├── variables.tf                # terraform variable
└── variables.tfvars.template   # mapping of parameters to terraform variables

```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.network.name` | Name of GCP network | | x |
| `component.loadBalancer.name` | Name of Load Balancer | load-balancer | x |
| `component.loadBalancer.instanceGroup` | Self-link to VM Instance Group | | x |
| `component.loadBalancer.sslCertificate` | Self-link to SSL certificate | | |
| `component.loadBalancer.backendPort` | Backend port number | 80 | x |
| `component.loadBalancer.backendProtocol` | Backend protocol | HTTP | x |
| `component.loadBalancer.backendHealthPath` | Backend health check path | / | x |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.loadBalancer.externalIp` | External IP of created Load Balancer |

## Dependencies

* [Network](https://github.com/agilestacks/google-components/tree/main/network)

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [GCP Load Balancing](https://cloud.google.com/load-balancing/docs/load-balancing-overview)
* [Google terraform module for Load Balancer]

[Google terraform module for Load Balancer]: https://github.com/terraform-google-modules/terraform-google-lb-http
