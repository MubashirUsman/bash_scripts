from slack_sdk.webhook import WebhookClient
import os
import subprocess
from datetime import datetime
from slack_sdk import WebClient
from slack_sdk.webhook import WebhookClient

def send_slack_message(messasge):
    
    testing_url = os.environ.get("WEBHOOK_URL")
    webhook = WebhookClient(testing_url)
    test_message = messasge

    test_response = webhook.send(text=test_message)

    assert test_response.status_code == 200
    assert test_response.body == "ok"


error_logs_file = "/var/log/mysql/error.log"
def error_log(log_path):
    number_of_lines = 10
    count = 0
    current_time = datetime.now()
    current_time = current_time.strftime("%Y-%m-%dT%H:%M")
    db_logs = subprocess.check_output(f"tail -{number_of_lines} {log_path}", shell=True).decode("utf-8")
    
    with open("replication_error.txt", "w") as myfile:
        myfile.write(db_logs)

    with open("replication_error.txt", "r") as myfile:
        lines = myfile.readlines()
    for line in lines:
        line = line.strip()
        count += 1
        if "replication stopped" in line:
            # trigger slack
            send_slack_message("Hello from Python!!")

error_log(error_logs_file)