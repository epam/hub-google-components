# Cloud SQL

## Description

This component can create GCP Cloud SQL instance. It's based on official [Google terraform modules](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules)

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml # manifest file of the component with configuration and parameters
├── main.tf            # terraform configuration
├── mssql.tf           # terraform configuration of Cloud SQL module for MSSQL database
├── mysql.tf           # terraform configuration of Cloud SQL module for MySQL database
├── postgresql.tf      # terraform configuration of Cloud SQL module for Postgresql database
├── ouputs.tf          # terraform outputs
└── variables.tf       # terraform variables
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.cloudSql.name` | Name of Cloud SQl instance | | x |
| `component.cloudSql.version` | The MySQL, PostgreSQL or MSSQL Server version to use: List of supported values can be found [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version) | `MYSQL_5_7` | x |
| `component.cloudSql.network` | VPC network name in case if Cloud SQL instance need to have private ip | default | |
| `component.cloudSql.dbName` | Database name | default | |
| `component.cloudSql.dbUser` | Database username | default | |
| `component.cloudSql.password` | User password. If empty will autogenerate | | |
| `component.cloudSql.publicIP` | Whether this Cloud SQL instance should be assigned a public IPV4 address | true | |
| `component.cloudSql.availabilityType` | The availability type for the master instance.This is only used to set up high availability for the instance. Can be either ZONAL or REGIONAL | ZONAL | |
| `component.cloudSql.allocatedIpRangeName` | The name of the allocated ip range for the private ip CloudSQL instance. | | |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.cloudSql.dbName` | Database name |
| `component.cloudSql.dbUser` | Database username |
| `component.cloudSql.password` | User password |
| `component.cloudSql.privateIp` | Instance private IP |
| `component.cloudSql.publicIp` | Instance public IP |

## Dependencies

* [Network](https://github.com/agilestacks/google-components/tree/main/network)
* This component depends on Terraform module for CloudSQL: [GoogleCloudPlatform/sql-db/google](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest)

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Cloud SQL](https://cloud.google.com/sql/docs/introduction)
