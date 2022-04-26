# Cloud NAT Router Component

## Description

Terraform based component to create GCP Clout NAT. It's based on official [Google terraform modules](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules)

## Structure

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

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.cloudNat.name` | Name of Cloud NAT resource | default | x |
| `component.cloudNat.network` | Name or self link of GCP network | default | x |

### Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.cloudNat.routerName` | Name of NAT router

## Dependencies

* [Network](https://github.com/agilestacks/google-components/tree/main/network)

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Cloud NAT](https://cloud.google.com/nat/docs/overview)
