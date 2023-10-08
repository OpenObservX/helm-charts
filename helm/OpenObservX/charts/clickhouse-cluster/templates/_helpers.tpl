{{/* vim: set filetype=go-template: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "clickhouse-cluster.name" -}}
clickhouse-cluster
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clickhouse-cluster.fullname" -}}
clickhouse-cluster
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "clickhouse-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "clickhouse-cluster.labels" -}}
helm.sh/chart: {{ include "clickhouse-cluster.chart" . }}
{{ include "clickhouse-cluster.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: clickhouse-cluster
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "clickhouse-cluster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clickhouse-cluster.name" . }}
app.kubernetes.io/instance: clickhouse-cluster
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "clickhouse-cluster.serviceAccountName" -}}
    {{ default (include "clickhouse-cluster.fullname" .) .Values.serviceAccount.name }}
{{- end -}}

{{/*
Create the tag for the docker image to use
*/}}
{{- define "clickhouse-cluster.operator.tag" -}}
{{- .Values.operator.image.tag | default .Chart.AppVersion -}}
{{- end -}}

{{/*
Create the tag for the docker image to use
*/}}
{{- define "clickhouse-cluster.metrics.tag" -}}
{{- .Values.metrics.image.tag | default .Chart.AppVersion -}}
{{- end -}}

{{/*
clickhouse-cluster.rawResource will create a resource template that can be
merged with each item in `.Values.additionalResources`.
*/}}
{{- define "clickhouse-cluster.rawResource" -}}
metadata:
  labels:
    {{- include "clickhouse-cluster.labels" . | nindent 4 }}
{{- end }}
