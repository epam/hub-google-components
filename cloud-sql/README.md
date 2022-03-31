# Virtual Network Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── post-deploy                      # to exports generated password
└── gcloud-...-create.yaml.template  # template of GKE cluster `create` command argument file                       
```

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | :-------:
| `component.cloudSql.version` |  The MySQL, PostgreSQL or SQL Server version to use: List of supported values can be found [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version) | `MYSQL_5_7` | x |

> TODO: complete input and out put parameter references

## Dependencies
