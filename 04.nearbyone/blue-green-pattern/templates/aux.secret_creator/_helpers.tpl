{{- define "imagePullSecret" }}
{{- with .Values.deployments.nginx.configuration.chart.auth }}
{{- printf "{\"auths\":{\"https://%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" $.Values.deployments.nginx.variables.images.nginx.repo .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}
