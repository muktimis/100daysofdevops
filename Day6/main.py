from parser import count_failed_login
from alert import send_alert
import os 

Threshold = 10
LOG_PATH = os.getenv("LOG_PATH","auth.log")

if __name__ == "__main__":
    failed_count = count_failed_login(LOG_PATH)
    print(f"FAILED LOGIN ATTEMPTS: { failed_count }")
    if failed_count > Threshold:
        send_alert(f"High number of failed login: {failed_counts}")
