# ACME Certificate

Creates a new TLS certificate. Tested with LetsEncrypt provider

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml              # hubfile 
├── main.tf                         # 
├── providers.tf                    #     
├── variables.tf                    #
└── outputs                         # directory for outputs with generated certificates
    └── <domain-name>               
        ├── certificate.pem         # certificate body
        ├── certificate-key.pem     # certificate private key
        └── certificate-chain.pem   # certificate chain (includes intermediate cert)
```

### Parameters

| Name      | Description | Default Value | Required    
| :-------- | :--------   | :-------- | :--:
| `certificate.commonName` | Common name for certificate. This will be used as cert primary name | | x
| `certificate.alternativeNames` | Whitespace or comma  | `n1-standard-1` | x
| `composer.version` | Version of composer (`v1` or `v2`) when `v2` it will set environment images to `composer-2.0.0-preview.3-airflow-2.1.2` | `v1` | x
| `component.network.subnetwork` | Selfink to the subnetwork for compose environment | | x |
| `component.acme.endpoint` | Selfink to the subnetwork for compose environment | `https://acme-v02.api.letsencrypt.org/directory` | x |

__LetsEncrypt endpoints__

Let's Encrypt has [two endpoints](https://letsencrypt.org/docs/acme-protocol-updates/#acme-v2-rfc-8555)

1. production: https://acme-v02.api.letsencrypt.org/directory
2. staging:    https://acme-staging-v02.api.letsencrypt.org/directory

## Dependencies

* Requires enable api: `composer.googleapis.com`
* This component largely relies on terraform module: [terraform-google-modules/composer/google](https://registry.terraform.io/modules/terraform-google-modules/composer/google/latest)

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [hub deployment for Terraform](https://github.com/agilestacks/hub-extensions/blob/gcp-extensions/documentation/hub-component-terraform.md)
* [composer terraform module](https://registry.terraform.io/modules/terraform-google-modules/composer/google/latest)
* [Lets Encrypts endpoints](https://letsencrypt.org/docs/acme-protocol-updates/#acme-v2-rfc-8555)

