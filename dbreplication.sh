#!/bin/bash

SLACK_WEBHOOK_URL=$WEBHOOK_URL
SLACK_CHANNEL=$SLACK_CHANEEL

FILE_PATH="/tmp/newfile.txt"

send_slack_alert() {
    message="Hello bash"
    curl -X POST -H 'Content-type: application/json' --data "{\"channel\":\"${SLACK_CHANNEL}\",\"text\":\"${message}\",\"color\":\"danger\"}" "${SLACK_WEBHOOK_URL}"
}

error_lines=$(tail -n 200 "${FILE_PATH}" | grep "terraformmount")

if [ -n "$error_lines" ]; then
    error_message="Error: Found 'replication' keyword in the last 200 lines of the file:\n$error_lines"
    send_slack_alert "$error_message"
else
    echo "Didn't found the error!!"
fi