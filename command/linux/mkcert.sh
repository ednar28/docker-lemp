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

domain="localhost"
mkcert -key-file nginx/devcerts/localhost-key.pem -cert-file nginx/devcerts/localhost-cert.pem $domain

# Generate certificates for localhost '*.test' domains
for folder in php-project/*; do
  if [ -d "$folder" ]; then
    folder_name=$(basename "$folder")
    mkcert -key-file nginx/devcerts/$folder_name-key.pem -cert-file nginx/devcerts/$folder_name-cert.pem "$folder_name.test"
    echo "Certificates generated: key.pem and cert.pem"
  fi
done

# Update CA certificates
sudo update-ca-certificates