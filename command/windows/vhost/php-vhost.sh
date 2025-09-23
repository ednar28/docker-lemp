#!/bin/bash

# Bash script for PHP vhost configuration (Windows compatible)

# Define the source template and target directory
TEMPLATE="nginx/conf/example.conf.template"
TARGET_DIR="nginx/conf"
WWW_DIR="php-project"

# Check if the www directory exists
if [ ! -d "$WWW_DIR" ]; then
  echo "Error: $WWW_DIR does not exist."
  exit 1
fi

# Count the number of folders in the www directory
folder_count=$(find "$WWW_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "Number of folders in $WWW_DIR: $folder_count"

# Iterate over all folders in the www directory
for folder in "$WWW_DIR"/*; do
  if [ -d "$folder" ]; then
    echo "Processing folder: $folder"

    folder_name=$(basename "$folder")
    target_file="$TARGET_DIR/$folder_name.conf"

    # Copy the template and replace placeholders if necessary
    if [ -f "$TEMPLATE" ]; then
      cp "$TEMPLATE" "$target_file"
      sed -i "s|{{FOLDER}}|$folder_name/public|g" "$target_file"
      sed -i "s|{{DOMAIN}}|$folder_name.test|g" "$target_file"
      sed -i "s|{{CERT}}|$folder_name-cert.pem|g" "$target_file"
      sed -i "s|{{KEY}}|$folder_name-key.pem|g" "$target_file"
      echo "Created configuration for $folder_name at $target_file"
    else
      echo "Error: Template file $TEMPLATE not found."
      continue
    fi

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