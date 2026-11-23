{{- define "platform.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "platform.fullname" . }}
  labels:
    {{- include "platform.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount | default 2 }}
  selector:
    matchLabels:
      {{- include "platform.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "platform.selectorLabels" . | nindent 8 }}
    spec:
      automountServiceAccountToken: false
      securityContext:
        runAsNonRoot: true
        runAsUser: 10001
        seccompProfile:
          type: RuntimeDefault
      containers:
        - name: app
          image: "{{ required "image.repository is required" .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          {{- with .Values.args }}
          args:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          ports:
            - name: http
              containerPort: {{ .Values.containerPort | default 8080 }}
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop: ["ALL"]
          resources:
            {{- if .Values.resources }}
            {{- toYaml .Values.resources | nindent 12 }}
            {{- else }}
            requests:
              cpu: 50m
              memory: 64Mi
            limits:
              memory: 256Mi
            {{- end }}
{{- end }}
