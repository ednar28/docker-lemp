#!/bin/bash

# Install mkcert if not already installed
if ! command -v mkcert &> /dev/null; then
  echo "mkcert not found. Installing mkcert..."
  if command -v apt &> /dev/null; then
    sudo apt update && sudo apt install -y libnss3-tools
  elif command -v yum &> /dev/null; then
    sudo yum install -y nss-tools
  fi
  curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
  chmod +x mkcert-v*-linux-amd64
  sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
fi

# generate mkcert certificates for PHP and Vue projects
bash "$(dirname "$0")/php-mkcert.sh"
bash "$(dirname "$0")/vue-mkcert.sh"

# Update CA certificates based on the distribution
if command -v update-ca-certificates &> /dev/null; then
  # Debian/Ubuntu based systems
  sudo update-ca-certificates
elif command -v update-ca-trust &> /dev/null; then
  # RHEL/CentOS/Fedora based systems
  sudo update-ca-trust
elif command -v pacman &> /dev/null; then
  # Arch Linux based systems (including Garuda OS)
  sudo pacman -S ca-certificates --noconfirm 2>/dev/null || true
  sudo trust extract-compat
else
  echo "Warning: Could not update CA certificates automatically"
  echo "Please update CA certificates manually for your distribution"
fi