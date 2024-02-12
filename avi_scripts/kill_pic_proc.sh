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

# echo "Are you sure you want to proceed? (y/n)"
# read answer

# if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
#   echo "Canceled process termination."
#   exit 0
# fi

# Terminate processes
for process in "${running_processes[@]}"; do
  pkill -f "$process"
  echo "Killed process: $process"
done

rm -fr liscense_* PiTest_avi_* tmp* mdx-editor-* .tutorial.* .drinks.* .food.*

echo "Done!"
