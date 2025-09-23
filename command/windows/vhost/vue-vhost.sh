#!/bin/bash

# Bash script for Vue vhost configuration (Windows compatible)

# Define the www directory
WWW_DIR="vue-project"

# Check if the www directory exists
if [ ! -d "$WWW_DIR" ]; then
  echo "Error: $WWW_DIR does not exist."
  exit 1
fi

# Count the number of folders in the www directory
folder_count=$(find "$WWW_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "Number of folders in $WWW_DIR: $folder_count"

for folder in "$WWW_DIR"/*; do
  if [ -d "$folder" ]; then
    folder_name=$(basename "$folder")
    echo "Processing folder: $folder"

    # Check if the domain is already in hosts file
    # Windows hosts file location
    if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
      # Git Bash on Windows
      hosts_file="/c/Windows/System32/drivers/etc/hosts"
    else
      # WSL or Linux
      hosts_file="/etc/hosts"
    fi
    
    domain="$folder_name.test"
    if [ -f "$hosts_file" ]; then
      if ! grep -qE "^127\.0\.0\.1[[:space:]]+$domain([[:space:]]|$)" "$hosts_file"; then
        echo "127.0.0.1 $domain" >> "$hosts_file" 2>/dev/null || {
          echo "Warning: Could not modify hosts file. Please run as Administrator or manually add: 127.0.0.1 $domain"
        }
        if [ $? -eq 0 ]; then
          echo "Added $domain to hosts file"
        fi
      else
        echo "$domain is already in hosts file"
      fi
    else
      echo "Warning: Hosts file not found at $hosts_file"
    fi
  fi
done