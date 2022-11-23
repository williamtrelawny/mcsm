#!/bin/bash

# Init vars:
SERVER_PATH=/home/mithos/mcsm/servers/hawkins-bedrock

# Remove previous latest.log symlink:
rm logs/latest.log

# Start server within a new screen session:
/usr/bin/screen -dmS hawkins-bedrock -L -Logfile logs/survival.$(date +%Y%m%d_%H-%M-%S).log /bin/bash -c "LD_LIBRARY_PATH=$SERVER_PATH ${SERVER_PATH}/bedrock_server"
/usr/bin/screen -rD hawkins-bedrock -X multiuser on
/usr/bin/screen -rD hawkins-bedrock -X acladd mithos

# Wait until screen session is available, then exit:
until [ -n $(screen -ls | grep hawkins-bedrock | awk '{print $1}') ]; do
  echo "..."
  sleep 1
done

echo "Server started successfully."

# Create logfile symlink:
LASTLOG=$(ls -t -c1 logs/*.log | head -n1)
ln -s -r $LASTLOG logs/latest.log
