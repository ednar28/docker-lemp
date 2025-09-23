#!/bin/bash

# Bash script for Windows vhost setup (Git Bash/WSL compatible)

SCRIPTS=(
  "php-vhost.sh"
  "vue-vhost.sh"
)

SCRIPT_DIR="$(dirname "$0")"

echo "Starting vhost configuration..."

for script in "${SCRIPTS[@]}"; do
  script_path="$SCRIPT_DIR/$script"
  if [ -f "$script_path" ]; then
    echo "Running $script..."
    bash "$script_path"
  else
    echo "Warning: $script not found at $script_path"
  fi
done

echo "Vhost configuration completed!"