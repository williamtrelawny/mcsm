#!/bin/bash

# Issue kill screen session command:
/usr/bin/screen -Rd hawkins-bedrock -X stuff "stop \r" > /dev/null 2>&1

# If no screen sessions found, notify user and exit gracefully.
# Else, continue shutting down screen.
if [ $? -ne 0 ]; then echo "No running servers found! Exiting..." & exit; fi

echo "Shutting down server..."

# Wait until screen session is destroyed, then exit.
until [ -z $(screen -ls | grep hawkins-bedrock | awk '{print $1}') ]; do
  echo "..."
  sleep 1
done

echo "Server shut down completed."
