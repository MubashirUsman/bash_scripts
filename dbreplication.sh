#!/bin/bash

# Replace these variables with your Slack webhook URL and channel name
SLACK_WEBHOOK_URL=$WEBHOOK_URL
SLACK_CHANNEL=$SLACK_CHANEEL

# Path to the file you want to check
FILE_PATH="/tmp/newfile.txt"

# Function to send a Slack message with the error
send_slack_alert() {
    message="Hello bash"
    curl -X POST -H 'Content-type: application/json' --data "{\"channel\":\"${SLACK_CHANNEL}\",\"text\":\"${message}\",\"color\":\"danger\"}" "${SLACK_WEBHOOK_URL}"
}

# Read the last 200 lines of the file and check for the keyword "replication"
error_lines=$(tail -n 200 "${FILE_PATH}" | grep "terraformmount")

if [ -n "$error_lines" ]; then
    error_message="Error: Found 'replication' keyword in the last 200 lines of the file:\n$error_lines"
    send_slack_alert "$error_message"
else
    echo "Didn't found the error!!"
fi