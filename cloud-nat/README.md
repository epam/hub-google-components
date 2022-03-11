# Cloud NAT Router Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── deploy.sh           # `deploy` action implementation of the component
├── undeploy.sh         # `undeploy` action implementation of the component
├── nat.tf              # terraform implementation of component
├── main.tf             # terraform configuration
├── outputs.tf          # terraform outputs
└── variables.tf        # terraform variable
```

### Parameters

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| component.cloudNat.name | Name of Cloud NAT resource | default | True
| component.cloudNat.network | Name or self link of GCP network | default | True

### Outputs

| Name      | Description
| --------- | ---------
| component.cloudNat.routerName | Name of NAT router

## Dependencies

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
