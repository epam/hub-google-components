# DNS Zone Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── deploy.sh           # `deploy` action implementation of the component
├── undeploy.sh         # `undeploy` action implementation of the component
├── dns.tf              # terraform implementation of component
├── main.tf             # terraform configuration
└── variables.tf        # terraform variable
```

### Parameters

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| component.dnsZone.baseZoneName | Name of base zone | epam | True

## Dependencies

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
