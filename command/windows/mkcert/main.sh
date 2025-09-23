#!/bin/bash

# Bash script for Windows mkcert setup (for Git Bash/WSL)

# Function to install mkcert for Windows
install_mkcert_windows() {
  echo "Installing mkcert for Windows..."
  
  # Create a temporary directory
  temp_dir=$(mktemp -d)
  cd "$temp_dir"
  
  # Download mkcert for Windows
  echo "Downloading mkcert..."
  curl -L -o mkcert.exe "https://dl.filippo.io/mkcert/latest?for=windows/amd64"
  
  if [ $? -eq 0 ] && [ -f "mkcert.exe" ]; then
    # Create a local bin directory if it doesn't exist
    mkdir -p "$HOME/bin"
    
    # Move mkcert to local bin
    mv mkcert.exe "$HOME/bin/mkcert.exe"
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
      echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
      export PATH="$HOME/bin:$PATH"
    fi
    
    echo "mkcert installed successfully to $HOME/bin/mkcert.exe"
    echo "Please restart your terminal or run: source ~/.bashrc"
    
    # Clean up
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    return 0
  else
    echo "Failed to download mkcert"
    cd - > /dev/null
    rm -rf "$temp_dir"
    return 1
  fi
}

# Check if mkcert is installed
if ! command -v mkcert &> /dev/null && ! command -v mkcert.exe &> /dev/null; then
  echo "mkcert not found. Installing mkcert..."
  
  # Check if we're in WSL
  if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "Detected WSL environment"
    # Install for WSL
    curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
    chmod +x mkcert-v*-linux-amd64
    sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
  else
    # For Git Bash on Windows - try automatic installation
    if ! install_mkcert_windows; then
      echo "Automatic installation failed."
      echo "Please install mkcert manually from: https://github.com/FiloSottile/mkcert/releases"
      echo "Download the Windows version and add it to your PATH"
      exit 1
    fi
  fi
fi

# Use mkcert or mkcert.exe depending on what's available
MKCERT_CMD="mkcert"
if command -v mkcert.exe &> /dev/null; then
  MKCERT_CMD="mkcert.exe"
fi

# Get the directory where this script is located
SCRIPT_DIR="$(dirname "$0")"

# Generate mkcert certificates for PHP and Vue projects
echo "Generating certificates for PHP projects..."
bash "$SCRIPT_DIR/php-mkcert.sh"

echo "Generating certificates for Vue projects..."
bash "$SCRIPT_DIR/vue-mkcert.sh"

echo "Certificate generation completed!"