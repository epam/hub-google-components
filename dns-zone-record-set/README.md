# DNS Zone Record Set

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
| component.dnsZoneRecordSet.name | Name prefix for record set | - | True
| component.dnsZoneRecordSet.type | Type of record set | - | True
| component.dnsZoneRecordSet.ttl | TTL of record set | 300 | True
| component.dnsZoneRecordSet.value | Value of rrdatas of record set | - | True

## Dependencies

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
