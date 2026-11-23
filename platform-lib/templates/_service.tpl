{{- define "platform.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "platform.fullname" . }}
  labels:
    {{- include "platform.labels" . | nindent 4 }}
spec:
  selector:
    {{- include "platform.selectorLabels" . | nindent 4 }}
  ports:
    - port: {{ required "port is required (renamed from service.port in 0.3.0)" .Values.port }}
      targetPort: http
{{- end }}
