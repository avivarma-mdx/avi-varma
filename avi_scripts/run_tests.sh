#!/bin/bash

# Function to check if a file is executable
is_executable() {
  [ -x "$1" ]  # Check if file has execute permission
}

# Get the folder path from the user
read -p "Enter the folder path: " folder_path

# Check if the folder exists
if [ ! -d "$folder_path" ]; then
  echo "Error: Folder '$folder_path' does not exist."
  exit 1
fi

# Loop through all files in the folder
for file in "$folder_path"/*; do
  # Check if it's a regular file and executable
  if [ -f "$file" ] && is_executable "$file"; then
    echo "Running: $file"
    # Run the file
    "$file"
  fi
done

echo "Finished running all executable files in '$folder_path'."
