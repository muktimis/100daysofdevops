import os

def send_alert(message):
    webhook_url = os.getenv("SLACK_WEBHOOK_URL")
    if webhook_url:
        try:
            import requests
        except ImportError:
            print("[ALERT]", message)
            print("Note: requests library is not installed, cannot send Slack alert.")
            return
        ...
    else:
        print("[ALERT]", message)
