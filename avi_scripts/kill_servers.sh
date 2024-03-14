#!/bin/bash

# Find the process ID (PID) of redis-server
pid=$(pgrep redis-server)

# Check if redis-server is running
if [[ -z "$pid" ]]; then
  echo "Redis server not found. Continuing..."
else
  echo "Terminating redis-server (PID: $pid)..."
  kill -9 "$pid"
  echo "Redis server terminated."
fi

# Find the process ID (PID) of mongod
pid=$(pgrep mongod)

# Check if mongod is running
if [[ -z "$pid" ]]; then
  echo "Mongod server not found. Continuing..."
else
  echo "Terminating mongod (PID: $pid)..."
  kill -9 "$pid"
  echo "mongod terminated."
fi
