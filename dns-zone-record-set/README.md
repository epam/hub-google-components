# DNS Zone Record Set

## Description

Terraform based component. This component creates Google Cloud DNS zone record set in target Cloud DNS zone.

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── dns.tf              # terraform implementation of component
├── main.tf             # terraform configuration
└── variables.tf        # terraform variable
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.dnsZoneRecordSet.name` | Name prefix for record set | - | x |
| `component.dnsZoneRecordSet.type` | Type of record set | - | x |
| `component.dnsZoneRecordSet.ttl` | TTL of record set | 300 | x |
| `component.dnsZoneRecordSet.value` | Value of rrdatas of record set | - | x |

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Cloud DNS Records](https://cloud.google.com/dns/docs/records-overview)
