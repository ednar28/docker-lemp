#!/bin/bash

# Path to the command folder
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  COMMAND_DIR="./command/linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  COMMAND_DIR="./command/macos"
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
  COMMAND_DIR="./command/windows"
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

# Check if the directory exists
if [ ! -d "$COMMAND_DIR" ]; then
  echo "Directory $COMMAND_DIR does not exist."
  exit 1
fi

# Iterate over all .sh files in the command directory
for file in "$COMMAND_DIR"/*.sh; do
  # Check if the file exists and is executable
  if [ -f "$file" ] && [ -x "$file" ]; then
    echo "Running $file..."
    "$file"
  else
    echo "Skipping $file (not executable or not a regular file)."
  fi
done