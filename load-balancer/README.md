# GCP Load Balancer Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── deploy.sh           # `deploy` action implementation of the component
├── undeploy.sh         # `undeploy` action implementation of the component
├── load-balancer.tf    # terraform implementation of component
├── main.tf             # terraform configuration
├── outputs.tf          # terraform outputs
└── variables.tf        # terraform variable
```

### Parameters

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| component.loadBalancer.name | Name of load balancer | default | True
| component.loadBalancer.network | Name of network for load balancer | default | True

## Dependencies

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
