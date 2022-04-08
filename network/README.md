# Virtual Network Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── deploy.sh           # `deploy` action implementation of the component
├── undeploy.sh         # `undeploy` action implementation of the component
├── network.tf          # terraform implementation of component
├── main.tf             # terraform configuration
├── outputs.tf          # terraform outputs
└── variables.tf        # terraform variable
```

### Parameters

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| component.network.name | Name of VPC | default | True
| component.network.autocreateSubnets | Flag to auto create subnetworks | true | False
| component.network.subnetwork.cidr | Subnetwork CIDR in case if `autocreateSubnets` is False | - | False

### Outputs

| Name      | Description
| --------- | ---------
| component.network.subnetwork | Self link to created subnetwork
| component.network.allocatedPrivateIpRangeName | The name of the allocated ip range for the private ip CloudSQL instance

## Dependencies
