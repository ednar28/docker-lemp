#!/bin/bash

# Install mkcert if not already installed
if ! command -v mkcert &> /dev/null; then
  echo "mkcert not found. Installing mkcert..."
  # Download mkcert for Windows
  curl -JLO "https://dl.filippo.io/mkcert/latest?for=windows/amd64"
  chmod +x mkcert-v*-windows-amd64.exe
  mv mkcert-v*-windows-amd64.exe /usr/local/bin/mkcert
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