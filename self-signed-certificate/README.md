# GCP SSL Certificate Component

## Description

Current implementation create self signed certificate

## Implementation details & Parameters & Outputs

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── deploy.sh           # `deploy` action implementation of the component
├── undeploy.sh         # `undeploy` action implementation of the component
├── certificate.tf      # terraform implementation of component
├── main.tf             # terraform configuration
├── outputs.tf          # terraform outputs
└── variables.tf        # terraform variable

```

### Parameters

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| component.certificate.name | Name of SSL certificate | - | True
| component.certificate.description | Description of SSL certificate | Self signed certificate for web server sandbox | False

### Outputs

| Name      | Description
| --------- | ---------
| component.certificate.sslCertificate | SSL certificate self link

## Dependencies

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
