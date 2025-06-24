# Install mkcert if not already installed
if (!(Get-Command mkcert -ErrorAction SilentlyContinue)) {
    echo "mkcert not found. Installing mkcert..."
    # Install using Chocolatey
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        echo "Chocolatey not found. Please install Chocolatey first."
        echo "Visit https://chocolatey.org/install for installation instructions."
        exit 1
    }
    choco install mkcert -y
}

# Create a local CA if not already created
mkcert -install

$domain = "localhost"
mkcert -key-file .\nginx\devcerts\localhost-key.pem -cert-file .\nginx\devcerts\localhost-cert.pem $domain

# Generate certificates for localhost '*.test' domains
$phpProjects = Get-ChildItem -Path .\php-project -Directory
foreach ($folder in $phpProjects) {
    $folderName = $folder.Name
    mkcert -key-file .\nginx\devcerts\$folderName-key.pem -cert-file .\nginx\devcerts\$folderName-cert.pem "$folderName.test"
    echo "Certificates generated: key.pem and cert.pem"
}