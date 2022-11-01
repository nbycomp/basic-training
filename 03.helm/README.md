- To validate and template a helm chart:
`helm template -f override.yaml <folder>`

- To install a helm chart:
`helm install --create-namespace -n <traineeid> -f override.yaml <chart_release_name> .`

- To list charts:
`helm ls -A`

- To get values from a chart:
`helm get values <chart_release_name> -n <traineeid>`

- To get all resources from a chart:
`helm get all <chart_release_name> -n <traineeid>`

- To upgrade a helm chart:
`helm upgrade -n <traineeid> -f override.yaml <chart_release_name> .`

- To uninstall:
`helm uninstall <chart_release_name> -n <traineeid>`


- Complex example:
`https://github.com/bitnami/charts/tree/main/bitnami/nginx`

- and specially:
`https://github.com/bitnami/charts/blob/main/bitnami/nginx/templates/deployment.yaml`
