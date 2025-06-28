#!/bin/bash

# Create a local CA if not already created
mkcert -install

domain="localhost"
mkcert -key-file nginx/devcerts/php/localhost-key.pem -cert-file nginx/devcerts/php/localhost-cert.pem $domain

# Generate certificates for localhost '*.test' domains
for folder in php-project/*; do
  if [ -d "$folder" ]; then
    folder_name=$(basename "$folder")
    mkcert -key-file nginx/devcerts/php/$folder_name-key.pem -cert-file nginx/devcerts/php/$folder_name-cert.pem "$folder_name.test"
    echo "Certificates generated: key.pem and cert.pem"
  fi
done