{{/* 
    defind jvm heap size 
*/}}
{{- define "common.zk.utils.jvm.heap" -}}

{{- $jvmMemRatio := 70 }}
{{- $minHeap := 1024 }}
{{- $maxHeap := 1024 }}
{{- $XMNHeap := 1024 }}

{{- $res := .Values.zookeeper.resources.resource }}
{{- $requestMem := $res.requests.memory }}
{{- $limitsMem := $res.limits.memory }}

{{- /*
request mem
*/}}
{{- if contains "G" $requestMem }}
{{- $jvmXms := regexReplaceAll "G|i" $requestMem "" | trim }}
  {{- $minHeap = mul $jvmMemRatio (mul $jvmXms 1024) }}
{{- else }}
{{- $jvmXms := regexReplaceAll "M|m|i" $requestMem "" | trim }}
  {{- $minHeap = mul $jvmMemRatio $jvmXms }}
{{- end }}

{{- if contains "G" $limitsMem }}
{{- $jvmXmx := regexReplaceAll "G|i" $limitsMem "" | trim }}
  {{- $maxHeap = mul $jvmMemRatio (mul $jvmXmx 1024) }}
{{- else }}
{{- $jvmXmx := regexReplaceAll "M|m|i" $limitsMem "" | trim }}
  {{- $maxHeap = mul $jvmMemRatio $jvmXmx }}
{{- end }}

{{- if contains "G" $limitsMem }}
{{- $jvmXmx := regexReplaceAll "G|i" $limitsMem "" | trim }}
  {{- $XMNHeap = mul 50 (mul $jvmXmx 1024) }}
{{- else }}
{{- $jvmXmx := regexReplaceAll "M|m|i" $limitsMem "" | trim }}
  {{- $XMNHeap = mul 50 $jvmXmx }}
{{- end }}

- name: HO_MIN_HEAP_SIZE
  value: {{ printf "%vM" (div $minHeap 100) }}
- name: HO_HEAP_SIZE
  value: {{ printf "%vM" (div $maxHeap 100) }}
- name: JAVA_XMS
  value: {{ printf "%vM" (div $minHeap 100) }}
- name: JAVA_XMX
  value: {{ printf "%vM" (div $maxHeap 100) }}
- name: JVM_XMN
  value: {{ printf "%vM" (div $XMNHeap 100) }}
{{- end }}

