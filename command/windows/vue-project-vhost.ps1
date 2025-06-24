# Define the source template and target directory
$WWW_DIR = "vue-project"

# Count the number of folders in the www directory
$folder_count = (Get-ChildItem -Path $WWW_DIR -Directory).Count
Write-Host "Number of folders in $WWW_DIR: $folder_count"

# Get all subdirectories
$folders = Get-ChildItem -Path $WWW_DIR -Directory

foreach ($folder in $folders) {
    Write-Host "Processing folder: $folder"
    $folder_name = $folder.Name

    # Check if the domain is already in hosts file
    $hostsPath = "$env:windir\System32\drivers\etc\hosts"
    $hostsContent = Get-Content $hostsPath

    if (-not ($hostsContent -match "127\.0\.0\.1\s+$folder_name\.test")) {
        # Add new entry to hosts file (requires admin privileges)
        Add-Content -Path $hostsPath -Value "127.0.0.1 $folder_name.test" -Force
        Write-Host "Added $folder_name.test to hosts file"
    } else {
        Write-Host "$folder_name.test is already in hosts file"
    }
}