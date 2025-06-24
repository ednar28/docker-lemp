#!/bin/bash

# Define the source template and target directory
TEMPLATE="nginx/conf/example.conf.template"
TARGET_DIR="nginx/conf"
WWW_DIR="php-project"
HOSTS_FILE="/c/Windows/System32/drivers/etc/hosts"

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
    cp "$TEMPLATE" "$target_file"
    # Using sed with Windows paths
    sed -i "s|{{FOLDER}}|$folder_name/public|g" "$target_file"
    sed -i "s|{{DOMAIN}}|$folder_name.test|g" "$target_file"
    sed -i "s|{{CERT}}|$folder_name-cert.pem|g" "$target_file"
    sed -i "s|{{KEY}}|$folder_name-key.pem|g" "$target_file"
    echo "Created configuration for $folder_name at $target_file"

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
