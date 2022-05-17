# Grafana

Grafana connects to the multiple data sources and provides data visualizaton

## Structure

The component has the following directory structure:

```text
./
├── hub-component.yaml    # manifest file of the component with configuration and parameters
└── values.yaml.template  # template for chart values file
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
`component.grafana.chart.repo` | Helm chart repository URL | https://grafana.github.io/helm-charts | x |
`component.grafana.chart.name` | Helm chart name | `grafana` | x |
`component.grafana.chart.version` | Helm chart version | 6.29.2 | x |
`component.grafana.chart.valuesFile` | Instructs to use a helm chart values file as a base | values.yaml | x |
`component.ingress.host` | Ingress host for grafana | | |

## Implemenatation details

As a `pre-deploy` script it render a `values-intress.yaml` (ingress configuration for helm chart) if environment variable INGRESS_HOST has been provided

Same script will fetch a GKE cluster kubeconfig

## References

* [hub cli](https://github.com/agilestacks/hub/wiki)
