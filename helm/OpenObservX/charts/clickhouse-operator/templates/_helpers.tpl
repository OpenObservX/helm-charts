{{/* vim: set filetype=go-template: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "clickhouse-operator.name" -}}
clickhouse-operator
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clickhouse-operator.fullname" -}}
clickhouse-operator
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "clickhouse-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "clickhouse-operator.labels" -}}
helm.sh/chart: {{ include "clickhouse-operator.chart" . }}
{{ include "clickhouse-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: clickhouse-operator
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "clickhouse-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clickhouse-operator.name" . }}
app.kubernetes.io/instance: clickhouse-operator
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "clickhouse-operator.serviceAccountName" -}}
    {{ default (include "clickhouse-operator.fullname" .) .Values.serviceAccount.name }}
{{- end -}}

{{/*
Create the tag for the docker image to use
*/}}
{{- define "clickhouse-operator.operator.tag" -}}
{{- .Values.operator.image.tag | default .Chart.AppVersion -}}
{{- end -}}

{{/*
Create the tag for the docker image to use
*/}}
{{- define "clickhouse-operator.metrics.tag" -}}
{{- .Values.metrics.image.tag | default .Chart.AppVersion -}}
{{- end -}}

{{/*
clickhouse-operator.rawResource will create a resource template that can be
merged with each item in `.Values.additionalResources`.
*/}}
{{- define "clickhouse-operator.rawResource" -}}
metadata:
  labels:
    {{- include "clickhouse-operator.labels" . | nindent 4 }}
{{- end }}
