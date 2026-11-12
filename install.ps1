$ErrorActionPreference = "Stop"

$AppDir = Join-Path $env:LOCALAPPDATA "SKY-FF-V2"
$AppFile = Join-Path $AppDir "SKY-FF-V2-ULTRA-X.ps1"

New-Item -ItemType Directory -Path $AppDir -Force | Out-Null

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $Url = "https://raw.githubusercontent.com/kronraladub/SKY-FF-V2/main/SKY-FF-V2-ULTRA-X.ps1"

    Invoke-WebRequest -Uri $Url -OutFile $AppFile -UseBasicParsing

    $Content = Get-Content $AppFile -Raw

    if ($Content -notmatch 'XamlReader\]::Load' -or
        $Content -notmatch 'functions/v1/sky-api') {
        throw "ไฟล์โปรแกรมไม่ถูกต้อง"
    }

    Write-Host "SKY FF V2 installed successfully!" -ForegroundColor Green

    Start-Process -FilePath "powershell.exe" -ArgumentList @(
        "-NoProfile",
        "-STA",
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        "`"$AppFile`""
    )

} catch {
    Write-Host "INSTALL ERROR: $($_.Exception.Message)" -ForegroundColor Red
}
