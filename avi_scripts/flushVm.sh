#!/bin/bash

# Find the PID of the process listening on port 5000
pid=$(sudo lsof -t -i :5000)

# Check if a PID was found
if [ -n "$pid" ]; then
  echo "Nutanix GuestTools process found with PID: $pid"
  echo "Killing the process..."
  sudo kill -9 $pid
  echo "Process on port 5000 has been terminated."
else
  echo "No process found listening on port 5000."
fi

