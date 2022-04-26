# Managed Instance Group Component

## Description

This component create compute engine instance template and managed instance group. Based on official [Google terraform module for VM]

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml  # manifest file of the component with configuration and parameters
├── mig.tf              # terraform implementation of component
├── main.tf             # terraform configuration
├── outputs.tf          # terraform outputs
├── variables.tf        # terraform variable
└── scripts             # directory for vm startup scripts
    ├── apache2.sh.tpl  # terraform template for apache2 installation
    ├── common.sh.tpl   # terraform template for common packages installation
    └── nginx.sh.tpl    # terraform template for nginx installation
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.managedInstanceGroup.name` | Name of manager instance group | default | x |
| `component.managedInstanceGroup.service_account` | Name of service account to create for instance group | vo-m1 | x |
| `component.managedInstanceGroup.disk_type` | Disk type which will be used in instance template | pd-standart | x |
| `component.managedInstanceGroup.machine_type` | Instance type | e2-medium | x |
| `component.managedInstanceGroup.imageProject` | VM Image proejct | superhub | x |
| `component.managedInstanceGroup.image` | VM Image name | superhub-toolbox | x |
| `component.managedInstanceGroup.port` | MIG backend service named port number | 80 | x |
| `component.managedInstanceGroup.target_size` | MIG instance target size | 1 | x |

## Outputs

| Name      | Description |
| :-------- | :--------   |
| `component.managedInstanceGroup.instanceGroup` | Self link to created instance group

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
* [Google terraform module for VM]

[Google terraform module for VM]: https://github.com/terraform-google-modules/terraform-google-vm
