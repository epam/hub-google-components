# Managed Instance Group Component

## Description

## Implementation details & Parameters

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── deploy.sh           # `deploy` action implementation of the component
├── undeploy.sh         # `undeploy` action implementation of the component
├── mig.tf              # terraform implementation of component
├── main.tf             # terraform configuration
├── outputs.tf          # terraform outputs
└── variables.tf        # terraform variable
```

### Parameters

| Name      | Description | Default Value | Mandatory?
| --------- | ---------   | --------- | ---------
| component.managedInstanceGroup.name | Name of manager instance group | default | True
| component.managedInstanceGroup.service_account | Name of service account to create for instance group | vo-m1 | True
| component.managedInstanceGroup.disk_type | Disk type which will be used in instance template | pd-standart | True
| component.managedInstanceGroup.machine_type | Instance type | e2-medium | True
| component.managedInstanceGroup.imageProject | VM Image proejct | superhub | True
| component.managedInstanceGroup.image | VM Image name | superhub-toolbox | True
| component.managedInstanceGroup.port | MIG backend service named port number | 80 | True
| component.managedInstanceGroup.target_size | MIG instance target size | 1 | True

### Outputs

| Name      | Description
| --------- | ---------
| component.managedInstanceGroup.instanceGroup | Self link to created instance group

## Dependencies

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
