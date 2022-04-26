# Google Kubernetes Engine Node Pool

## Description

The component provisions GKE cluster Node Pool in the given GCP project using `gcloud` CLI

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml                                # manifest file of the component with configuration and parameters
├── deploy.sh                                         # `deploy` action implementation of the component
├── undeploy.sh                                       # `undeploy` action implementation of the component
└── gcloud-container-node-pools-create.yaml.template  # template of GKE cluster `create` command argument file
```

On `deploy` the component calls `gcloud` CLI `container node-pools create` command. It reads cluster configuration from argument file template: (gcloud-container-node-pools-create.yaml.template).

The template contains the most common (default) configuration parameters of GKE cluster (see below). Users are welcomed to add more advanced cluster configuration settings directly to the template.

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `projectId` | GCP project ID | | x
| `dns.domain` | Domain name of the stack | | x |
| `component.gkeNodePool.name` | GKE cluster Node Pool name | | x |
| `component.gkeNodePool.clusterName` | GKE cluster name | x |
| `component.gkeNodePool.zone` | GKE cluster zone | | |
| `component.gkeNodePool.region` | GKE clsuter region | | |
| `component.gkeNodePool.machineType` | GKE cluster Node Pool node type | x |
| `component.gkeNodePool.nodeCount` | Number of nodes in pool | x |

## References

* [gcloud create node-poools command](https://cloud.google.com/sdk/gcloud/reference/container/node-pools/create)
* [hub cli](https://github.com/agilestacks/hub/wiki)
