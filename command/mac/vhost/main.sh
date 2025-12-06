#!/bin/bash

SCRIPTS=(
  "php-vhost.sh"
  "vue-vhost.sh"
)

SCRIPT_DIR="$(dirname "$0")"

# Ensure sub-scripts are executable
chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null || true

for script in "${SCRIPTS[@]}"; do
  "${SCRIPT_DIR}/$script"
done
