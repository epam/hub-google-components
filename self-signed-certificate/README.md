# GCP SSL Certificate Component

## Description

Current implementation create self signed certificate and add it to GCP ssl service

## Implementation details & Parameters & Outputs

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
└── main.tf             # terraform variable
```

## Parameters

| Name      | Description | Default Value | Required |
| :-------- | :--------   | :-------- | :--: |
| `certificate.commonName` | The certificate's common name, the primary domain that the certificate will be recognized for | | x |
| `certificate.alternativeNames` | The alternative domain names that the certificate will be recognized for | | |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `certificate.google.selfLink` | GCP ssl sertificate self link |

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [hub deployment for Terraform](https://github.com/agilestacks/hub-extensions/blob/gcp-extensions/documentation/hub-component-terraform.md)
