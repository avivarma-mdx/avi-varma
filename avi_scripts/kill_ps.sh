#!/bin/bash

# Check if the effective user ID (EUID) is 0 (root)
if [[ $EUID -eq 0 ]]; then
  echo "Script is running with sudo privileges."
else
  echo "Script is not running with sudo privileges."
  exit 1
fi

# Filter processes and exclude grep/ksoftirqd
processes=$(ps aux | egrep -i "java|redis|mongo|picache|rq|p4d|svnserve|buildic" | egrep -v "grep|ksoftirqd")

# Check if any processes found
if [[ -z "$processes" ]]; then
  echo "No processes found matching 'java|redis|mongo|picache|rq|p4d|svnserve|buildic'."
  exit 0
fi

# Print matching processes for confirmation
echo "Matching processes:"
echo "$processes"

# Extract PIDs from the filtered list
pids=$(echo "$processes" | awk '{print $2}')

# Ask for confirmation before killing all listed processes
echo "Before proceeding, please confirm you want to kill ALL listed processes (y/n):"
read answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
  # Kill all listed processes by PID
  echo "$pids" | xargs kill -9
  echo "Killed processes with PIDs: $pids"
else
  echo "Canceled process termination."
fi