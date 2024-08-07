#!/bin/bash

# Check if the effective user ID (EUID) is 0 (root)
if [[ $EUID -eq 0 ]]; then
  echo "Script is running with sudo privileges."
else
  echo "Script is not running with sudo privileges."
  exit 1
fi

# Process names to terminate
processes=(
  "PiCache"
  "rq"
  "redis-server"
  "mongod"
  "buildic"
  "java"
  "p4d"
  "svnserve"
)

# Check if any processes are already running
running_processes=()
for process in "${processes[@]}"; do
  if [[ $(pgrep -f "$process") ]]; then
    running_processes+=("$process")
  fi
done

# If no processes found, exit
if [[ "${#running_processes[@]}" -eq 0 ]]; then
  echo "No matching processes found."
  exit 0
fi

# Print warning and ask for confirmation
echo "WARNING: This script will terminate the following processes:"
echo "${running_processes[@]}"

# Terminate processes
for process in "${running_processes[@]}"; do
  pkill -f "$process"
  echo "Killed process: $process"
done

# Find the process ID (PID) of redis-server
pid=$(pgrep redis-server)

# Check if redis-server is running
if [[ -n "$pid" ]]; then
  # Terminate redis-server with SIGKILL
  echo "Terminating redis-server (PID: $pid)..."
  kill -9 "$pid"
else
  echo "Redis server not found."
fi

echo "Cleaning /tmp dir..."

cd /tmp
rm -rf license* PiTest* tmp* mdx-editor-* .tutorial.* .drinks.* .food.* PiCache* *picache-test-* jetty* 
echo "Done!"

