{{- define "platform.networkpolicy" -}}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ include "platform.fullname" . }}
  labels:
    {{- include "platform.labels" . | nindent 4 }}
spec:
  podSelector:
    matchLabels:
      {{- include "platform.selectorLabels" . | nindent 6 }}
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector: {}
{{- end }}
