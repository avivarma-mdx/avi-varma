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
if [[ "$processes" == "" ]]; then
  echo "No processes found matching 'java|redis|mongo|picache|rq|p4d|svnserve|buildic'."
  exit 0
fi

# Print matching processes for confirmation
echo "Matching processes:"
echo "$processes"

# Ask for confirmation before killing PiCache
echo "Before proceeding, please confirm you want to kill all 'PiCache' processes (y/n):"
read answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
  # Kill all PiCache processes
  sudo pkill -f "PiCache"
  echo "Killed all 'PiCache' processes."
else
  echo "Canceled PiCache process termination."
fi
