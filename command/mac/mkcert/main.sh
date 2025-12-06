#!/bin/bash

# Install mkcert if not already installed (prefer Homebrew on macOS)
if ! command -v mkcert &> /dev/null; then
  echo "mkcert not found. Installing mkcert..."
  if command -v brew &> /dev/null; then
    brew update
    brew install mkcert
    brew install nss || true
  else
    # Fallback: download prebuilt binary for mac (intel by default)
    ARCH=$(uname -m)
    if [ "$ARCH" = "arm64" ]; then
      URL="https://dl.filippo.io/mkcert/latest?for=darwin/arm64"
      BINNAME="mkcert-v*-darwin-arm64"
    else
      URL="https://dl.filippo.io/mkcert/latest?for=darwin/amd64"
      BINNAME="mkcert-v*-darwin-amd64"
    fi
    curl -JLO "$URL"
    chmod +x $BINNAME
    sudo mv $BINNAME /usr/local/bin/mkcert 2>/dev/null || sudo mv $BINNAME /usr/bin/mkcert
  fi
fi

# Ensure sub-scripts are executable, then generate mkcert certificates for PHP and Vue projects
SCRIPT_DIR="$(dirname "$0")"
chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null || true
chmod +x "$SCRIPT_DIR"/php-mkcert.sh "$SCRIPT_DIR"/vue-mkcert.sh 2>/dev/null || true

bash "$SCRIPT_DIR/php-mkcert.sh"
bash "$SCRIPT_DIR/vue-mkcert.sh"

# On macOS mkcert manages the system keychain via `mkcert -install` in the sub-scripts
echo "Done. If mkcert installed successfully, certificates will be created by sub-scripts."