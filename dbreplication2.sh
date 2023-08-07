#!/bin/bash

SLACK_WEBHOOK_URL=$WEBHOOK_URL
SLACK_CHANNEL=$SLACK_CHANNEL

FILE_PATH="/tmp/newfile.txt"

# Function to send a Slack message with the error
send_slack_alert() {
    message="Hello from Bash!!"
    payload="payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"AlertBot\", \"text\": \"${message}\", \"color\": \"danger\"}"
    curl -X POST --data-urlencode "${payload}" "${SLACK_WEBHOOK_URL}"
}

while true; do

    error_lines=$(tail -n 1 "${FILE_PATH}" | grep "bat")

    if [ -n "$error_lines" ]; then
        error_message="Error: Found 'replication' keyword in the last 200 lines of the file:\n$error_lines"
        send_slack_alert "$error_message"
    else
        printf "Didn't found the error!! \n"
    fi

    # Adjust the delay interval as needed (e.g., 5 seconds in this example)
    sleep 5
done