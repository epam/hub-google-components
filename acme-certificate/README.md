# ACME Certificate

Creates a new TLS certificate. Tested with LetsEncrypt provider

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml            # hubfile
├── main.tf                       # terraform configuration
├── google.tf                     # terraform configuration
├── variables.tf                  # terraform variables
└── outputs                       # directory for outputs with generated certificates
    └── <domain-name>
        ├── certificate.pem       # certificate body
        ├── certificate-key.pem   # certificate private key
        └── certificate-chain.pem # certificate chain (includes intermediate cert)
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `certificate.commonName` | The certificate's common name, the primary domain that the certificate will be recognized for | | x |
| `certificate.alternativeNames` | The alternative domain names that the certificate will be recognized for | | |
| `certificate.acme.email` | Contact email | | |
| `certificate.acme.endpoint` | Let's Encrypt endpoint | `https://acme-v02.api.letsencrypt.org/directory` | x |

### LetsEncrypt endpoints

Let's Encrypt has [two endpoints](https://letsencrypt.org/docs/acme-protocol-updates/#acme-v2-rfc-8555)

1. production: <https://acme-v02.api.letsencrypt.org/directory>
2. staging:    <https://acme-staging-v02.api.letsencrypt.org/directory>

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `certificate.cert` | Certificate file |
| `certificate.key` | Private key file |
| `certificate.chain.cert` | Certificate chain file |
| `certificate.google.selfLink` | GCP ssl sertificate self link |

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [hub deployment for Terraform](https://github.com/agilestacks/hub-extensions/blob/gcp-extensions/documentation/hub-component-terraform.md)
* [Lets Encrypts endpoints](https://letsencrypt.org/docs/acme-protocol-updates/#acme-v2-rfc-8555)
