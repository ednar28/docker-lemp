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

# Create a local CA if not already created
mkcert -install

# Generate certificates for localhost '*.test' domains
domains="localhost"
for folder in www/*; do
  if [ -d "$folder" ]; then
    folder_name=$(basename "$folder")
    domains="$domains $folder_name.test"
  fi
done

mkcert -key-file nginx/devcerts/key.pem -cert-file nginx/devcerts/cert.pem $domains

echo "Certificates generated: key.pem and cert.pem"

# Update CA certificates
sudo update-ca-certificates