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

TARGETS=(
  "$COMMAND_DIR/vhost/main.sh"
  "$COMMAND_DIR/mkcert/main.sh"
)

for TARGET in "${TARGETS[@]}"; do
  if [ -f "$TARGET" ] && [ -x "$TARGET" ]; then
    echo "Running $TARGET"
    bash "$TARGET"
  else
    echo "File $TARGET does not exist or is not executable."
    exit 1
  fi
done
