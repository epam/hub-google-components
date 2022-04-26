# DNS Zone Component

## Description

Terraform based component. This component creates Google Cloud DNS zone and add NS record to base Cloud DNS zone.

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
| `component.dnsZone.name` | Name of zone | | x |
| `component.dnsZone.baseZoneName` | Name of base zone | epam | x |

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Cloud DNS Zones](https://cloud.google.com/dns/docs/zones/zones-overview)
