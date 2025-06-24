#!/bin/bash

# Define the source template and target directory
WWW_DIR="vue-project"
HOSTS_FILE="/c/Windows/System32/drivers/etc/hosts"

# Count the number of folders in the www directory
folder_count=$(find "$WWW_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "Number of folders in $WWW_DIR: $folder_count"

for folder in "$WWW_DIR"/*; do
  if [ -d "$folder" ]; then
    echo "Processing folder: $folder"
    folder_name=$(basename "$folder")

    # Check if the domain is already in hosts file
    if ! grep -q "127.0.0.1 $folder_name.test" "$HOSTS_FILE"; then
      # Note: This requires running Git Bash as Administrator
      echo "127.0.0.1 $folder_name.test" >> "$HOSTS_FILE"
      echo "Added $folder_name.test to hosts file"
    else
      echo "$folder_name.test is already in hosts file"
    fi
  fi
done