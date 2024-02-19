#!/bin/bash

# Check if p4d process is running
ps_output=$(ps -efww | grep p4d)
if [[ -z "$ps_output" ]]; then
  echo "p4d process not found. Skipping restart."
  exit 0
fi

# Extract the restart command from ps output
restart_command=$(echo "$ps_output" | awk '{print $8}')

# Kill the p4d process
pkill -f p4d

# Start the p4d process on port 1666 with -d flag
new_command="${restart_command//\"/ } -p 1666 -d"
nohup $new_command &

echo "Restarted p4d process on port 1666 with -d flag."

