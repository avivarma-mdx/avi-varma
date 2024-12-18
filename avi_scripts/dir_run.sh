#!/bin/bash

# Directory containing Python scripts
SCRIPTS_DIR=$1

# Directory to store log files
LOGS_DIR="logs"

# Create logs directory if it doesn't exist
mkdir -p $LOGS_DIR

# Iterate over all Python scripts in the given directory
for script in $SCRIPTS_DIR/*.py; do
  # Get the base name of the script (without directory and extension)
  script_name=$(basename "$script" .py)
  
  # Run the script and log the output
  python3 "$script" > "$LOGS_DIR/$script_name.log" 2>&1
done

echo "All scripts have been executed and logs are stored in the '$LOGS_DIR' directory."

