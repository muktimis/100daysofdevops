
# 🔧 Log Analyzer & Alert System

A lightweight Python automation tool to monitor system logs (e.g., failed SSH logins) and send alerts to Slack or console.

## ✅ Features
- Parse log files and filter by pattern
- Alert if failures exceed threshold
- Dockerized
- Kubernetes CronJob ready

## 🚀 Run Locally (Console-only Alerts)
You do **not** need a Slack webhook to run this tool. By default, if `SLACK_WEBHOOK_URL` is **not** provided, alerts will print to the console.

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
2. Run directly:
   ```bash
   python main.py
   ```
3. (Optional) If you want to point at a custom log file:
   ```bash
   LOG_PATH=/path/to/your/logfile.log python main.py
   ```

## 📬 Integrate with Slack (Optional)
If you want alerts forwarded to Slack, you can configure a Slack Incoming Webhook.

1. Create a Slack Incoming Webhook and copy the URL.
2. Run the tool with the environment variable set:
   ```bash
   SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXX/YYY/ZZZ" python main.py
   ```

## 🐳 Run with Docker
Build the image:
```bash
docker build -t log-analyzer .
```

### Console-only (no Slack)
```bash
docker run log-analyzer
```
Alerts—if any—will print to the container’s stdout.

### With Slack (Optional)
```bash
# Ensure requests is installed when building, or add SLACK before building
# If missing requests, alerts will fallback to console

docker run -e SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXX/YYY/ZZZ" log-analyzer
```

### Custom Log Path (Example)
```bash
docker run \
  -e LOG_PATH=/mnt/test_auth.log \
  -v /tmp/test_auth.log:/mnt/test_auth.log:ro \
  log-analyzer
```

## ☸️ Kubernetes CronJob
Use the provided `k8s/deployment.yaml` to schedule runs every 5 minutes in a Kubernetes cluster.

1. (Optional) If using Slack in K8s, create a secret:
   ```bash
   kubectl create secret generic slack-secret --from-literal=webhook=<your_webhook_url>
   ```
2. Apply the manifest:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   ```

This CronJob mounts `/var/log` from the host into the container at `/mnt/logs`, so ensure the cluster node has the logs you want to monitor.

---

*By default, the tool prints alerts to the console when no Slack webhook is specified.*
