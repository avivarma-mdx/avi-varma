#!/bin/bash

# Function to check for sudo permissions
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "This script requires sudo permissions. Attempting to run with sudo..."
        exec sudo "$0" "$@"
    fi
}

# Function to find and kill the process on port 5000
kill_process_on_port_5000() {
    echo "Checking for processes listening on port 5000..."

    # Find the PID of the process listening on port 5000
    pid=$(lsof -t -i :5000)

    # Check if a PID was found
    if [ -n "$pid" ]; then
        echo "Nutanix GuestTools process found with PID: $pid"
        echo "Killing the process..."
        kill -9 $pid
        echo "Process on port 5000 has been terminated."
    else
        echo "No process found listening on port 5000."
    fi
}

# Run the sudo check
check_sudo

# Run the function to kill the process
kill_process_on_port_5000

