param (
    [switch]$InstallService
)

# === Auto-install as Windows Service if requested ===
if ($InstallService) {
    $serviceName = "ChronoLog"
    $scriptPath  = $MyInvocation.MyCommand.Definition
    $serviceExe  = "powershell.exe"
    $serviceArgs = "-ExecutionPolicy Bypass -File `"$scriptPath`""

    if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
        Write-Host "Service '$serviceName' already exists."
    } else {
        New-Service -Name $serviceName `
            -BinaryPathName "$serviceExe $serviceArgs" `
            -DisplayName "ChronoLog OT Log Monitor" `
            -Description "Monitors Sensor_Log.txt from OT component, stores in History Server, and forwards latest to DM Server." `
            -StartupType Automatic
        Write-Host "Service '$serviceName' installed successfully."
    }
    exit
}

# === Config ===
$otFile     = "C:\Users\ChronoLog\Sensor_Log.txt" #chnage the path
$backupPath = "C:\Users\ChronoLog\History_Backup"
$logFile    = "C:\Users\ChronoLog\ChronoLog.log"

# FTP servers
$historyFtp = "ftp://192.168.1.1/incoming" #Replace with Actual IP
$dmFtp      = "ftp://192.168.1.2/incoming"
$ftpUser    = "ftpuser"   #change credenitals
$ftpPass    = "YourPassword"   

# === Ensure directories exist ===
foreach ($dir in @($backupPath, (Split-Path $logFile))) {
    if (!(Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
}

# === Logging Function ===
function Write-Log {
    param([string]$msg, [string]$level = "INFO")
    $time = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Add-Content -Path $logFile -Value "[$time] [$level] $msg"
}

# === Upload Function ===
function Upload-FTP {
    param ($ftpUrl, $localFile, $remoteFile)

    try {
        $webclient = New-Object System.Net.WebClient
        $webclient.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
        $webclient.UploadFile("$ftpUrl/$remoteFile", "STOR", $localFile)
        Write-Log "Uploaded $remoteFile to $ftpUrl" "SUCCESS"
    }
    catch {
        Write-Log "FTP Upload Failed: $_" "ERROR"
    }
}

# === File Watcher Setup ===
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path  = Split-Path $otFile
$watcher.Filter = (Split-Path $otFile -Leaf)
$watcher.NotifyFilter = [System.IO.NotifyFilters]'LastWrite'

# === Event when file updates ===
$onChange = Register-ObjectEvent $watcher Changed -Action {
    try {
        Start-Sleep -Seconds 2  # wait until file write finishes
        if (Test-Path $otFile) {
            $timestamp = (Get-Date).ToString("yyyyMMddHHmmss")
            $backupFile = Join-Path $backupPath "SensorLog_$timestamp.txt"

            # Copy file to History Backup
            Copy-Item -Path $otFile -Destination $backupFile -Force
            Write-Log "Copied Sensor_Log.txt to $backupFile" "INFO"

            # Upload copy to History FTP
            Upload-FTP -ftpUrl $using:historyFtp -localFile $backupFile -remoteFile ("SensorLog_$timestamp.txt")

            # Upload same as latest to DM FTP
            Upload-FTP -ftpUrl $using:dmFtp -localFile $otFile -remoteFile "SensorLog_latest.txt"
        }
    }
    catch {
        Write-Log "Error processing file update: $_" "ERROR"
    }
}

# === Start Monitoring ===
Write-Log "ChronoLog Service started. Watching $otFile" "INFO"
while ($true) {
    Start-Sleep -Seconds 5
}
