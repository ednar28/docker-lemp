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

# Update CA certificates
sudo update-ca-certificates