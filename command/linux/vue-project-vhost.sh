#!/bin/bash

# Define the source template and target directory
WWW_DIR="vue-project"

# Count the number of folders in the www directory
folder_count=$(find "$WWW_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "Number of folders in $WWW_DIR: $folder_count"

for folder in "$WWW_DIR"/*; do
  if [ -d "$folder" ]; then
    echo "Processing folder: $folder"

    # Check if the domain is already in /etc/hosts
    if ! grep -q "127.0.0.1 $folder_name.test" /etc/hosts; then
      echo "127.0.0.1 $folder_name.test" | sudo tee -a /etc/hosts > /dev/null
      echo "Added $folder_name.test to /etc/hosts"
    else
      echo "$folder_name.test is already in /etc/hosts"
    fi
  fi
done