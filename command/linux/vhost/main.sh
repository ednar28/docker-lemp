#!/bin/bash

SCRIPTS=(
  "php-vhost.sh"
  "vue-vhost.sh"
)

SCRIPT_DIR="$(dirname "$0")"

for script in "${SCRIPTS[@]}"; do
  "$SCRIPT_DIR/$script"
done
