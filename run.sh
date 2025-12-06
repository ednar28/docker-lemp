#!/bin/bash

# Path to the command folder
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  COMMAND_DIR="./command/linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  COMMAND_DIR="./command/mac"
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
  # If the target file exists, ensure it's executable and run it
  if [ -f "$TARGET" ]; then
    if [ ! -x "$TARGET" ]; then
      echo "Note: $TARGET is not executable; attempting to make it executable."
      chmod +x "$TARGET" 2>/dev/null || true
    fi
    echo "Running $TARGET"
    bash "$TARGET"
    continue
  fi

  # If target missing, try to copy counterpart from the linux commands folder (if available)
  LINUX_DIR="./command/linux"
  COUNTERPART="${TARGET/$COMMAND_DIR/$LINUX_DIR}"
  if [ -f "$COUNTERPART" ]; then
    echo "Target $TARGET missing — copying counterpart from $COUNTERPART"
    mkdir -p "$(dirname "$TARGET")"
    cp "$COUNTERPART" "$TARGET"
    chmod +x "$TARGET" 2>/dev/null || true
    echo "Running $TARGET"
    bash "$TARGET"
    continue
  fi

  echo "File $TARGET does not exist. Tried counterpart: $COUNTERPART"
  exit 1
done
