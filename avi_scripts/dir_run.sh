#!/bin/bash

# Directory containing the Python scripts
SCRIPT_DIR=$1

# Check if the directory is provided
if [ -z "$SCRIPT_DIR" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Check if the directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
  echo "Directory $SCRIPT_DIR does not exist."
  exit 1
fi

# Create a location to save all the logs.
mkdir $SCRIPT_DIR/logs

# Iterate over all Python scripts in the directory
for script in "$SCRIPT_DIR"/*.py; 
do
  # Get the base name of the script (without extension)
  base_name=$(basename "$script" .py)
  
  # Execute the script and save the output to a log file
  python "$script" > "$SCRIPT_DIR/logs/$base_name.log" 2>&1
done

echo "Execution completed. Logs are saved in $SCRIPT_DIR/logs."