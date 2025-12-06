#!/bin/bash

# Make every shell script in command/mac executable (recursive)
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Making all .sh files under $BASE_DIR executable..."
find "$BASE_DIR" -type f -name "*.sh" -exec chmod +x {} +
echo "Done."
