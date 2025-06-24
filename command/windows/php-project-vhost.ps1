# PowerShell script for creating nginx vhost configurations

# Define the source template and target directory
$TEMPLATE = "nginx/conf/example.conf.template"
$TARGET_DIR = "nginx/conf"
$WWW_DIR = "php-project"

# Check if the www directory exists
if (-not (Test-Path $WWW_DIR)) {
    Write-Error "Error: $WWW_DIR does not exist."
    exit 1
}

# Count the number of folders in the www directory
$folder_count = (Get-ChildItem -Path $WWW_DIR -Directory).Count
Write-Host "Number of folders in $WWW_DIR: $folder_count"

# Iterate over all folders in the www directory
Get-ChildItem -Path $WWW_DIR -Directory | ForEach-Object {
    $folder = $_.FullName
    $folder_name = $_.Name
    Write-Host "Processing folder: $folder"

    $target_file = "$TARGET_DIR/$folder_name.conf"

    # Copy the template and replace placeholders if necessary
    Copy-Item $TEMPLATE $target_file
    $content = Get-Content $target_file
    $content = $content -replace '\{\{FOLDER\}\}', "$folder_name/public"
    $content = $content -replace '\{\{DOMAIN\}\}', "$folder_name.test"
    $content = $content -replace '\{\{CERT\}\}', "$folder_name-cert.pem"
    $content = $content -replace '\{\{KEY\}\}', "$folder_name-key.pem"
    $content | Set-Content $target_file
    Write-Host "Created configuration for $folder_name at $target_file"

    # Check if the domain is already in hosts file
    $hostsPath = "$env:windir\System32\drivers\etc\hosts"
    $hostsContent = Get-Content $hostsPath
    if (-not ($hostsContent -match "127\.0\.0\.1\s+$folder_name\.test")) {
        # Note: This requires running PowerShell as Administrator
        Add-Content -Path $hostsPath -Value "127.0.0.1 $folder_name.test" -Force
        Write-Host "Added $folder_name.test to hosts file"
    } else {
        Write-Host "$folder_name.test is already in hosts file"
    }
}
