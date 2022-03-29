# Virtual Network Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── deploy.sh                        # `deploy` action implementation of the component
├── undeploy.sh                      # `undeploy` action implementation of the component
└── gcloud-...-create.yaml.template  # template of GKE cluster `create` command argument file                       
```

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | :-------:
| `component.cloudSql.version` |  The MySQL, PostgreSQL or SQL Server version to use: List of supported values can be found [here](https://cloud.google.com/sql/docs/db-versions) | `POSTGRES_12` | x |

> TODO: complete input and out put parameter references

## Dependencies
