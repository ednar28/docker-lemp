#!/bin/bash

# Bash script for PHP mkcert certificate generation (Windows compatible)

# Use mkcert or mkcert.exe depending on what's available
MKCERT_CMD="mkcert"
if command -v mkcert.exe &> /dev/null; then
  MKCERT_CMD="mkcert.exe"
fi

# Create a local CA if not already created
echo "Installing mkcert CA..."
$MKCERT_CMD -install

# Generate certificate for localhost
domain="localhost"
echo "Generating certificate for $domain..."

# Create directories if they don't exist (Windows path compatible)
php_cert_dir="nginx/devcerts/php"
mkdir -p "$php_cert_dir"

$MKCERT_CMD -key-file "$php_cert_dir/localhost-key.pem" -cert-file "$php_cert_dir/localhost-cert.pem" $domain

# Generate certificates for '*.test' domains based on php-project folders
php_project_dir="php-project"
if [ -d "$php_project_dir" ]; then
    for folder in "$php_project_dir"/*; do
        if [ -d "$folder" ]; then
            folder_name=$(basename "$folder")
            test_domain="$folder_name.test"
            
            echo "Generating certificate for $test_domain..."
            $MKCERT_CMD -key-file "$php_cert_dir/$folder_name-key.pem" -cert-file "$php_cert_dir/$folder_name-cert.pem" "$test_domain"
            echo "Certificates generated: $folder_name-key.pem and $folder_name-cert.pem"
        fi
    done
else
    echo "php-project directory not found, skipping project-specific certificates"
fi