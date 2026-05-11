# PROMIXCO - Create Shortcuts + Register App
param([string]$InstallDir)

try {
    $exe     = "$InstallDir\PROMIXCO.exe"
    $ico     = "$InstallDir\icon.ico"

    # 1) Desktop shortcut
    $ws      = New-Object -ComObject WScript.Shell
    $desktop = [Environment]::GetFolderPath('CommonDesktopDirectory')
    $lnk     = $ws.CreateShortcut("$desktop\PROMIXCO.lnk")
    $lnk.TargetPath       = $exe
    $lnk.IconLocation     = "$ico,0"
    $lnk.WorkingDirectory = $InstallDir
    $lnk.Description      = "PROMIXCO Email Marketing Tools"
    $lnk.Save()
    Write-Host "[OK] Desktop shortcut created at $desktop"

    # 2) Start Menu shortcut
    $startAll = [Environment]::GetFolderPath('CommonStartMenu') + "\Programs"
    if (-not (Test-Path $startAll)) { New-Item -ItemType Directory -Path $startAll | Out-Null }
    $lnk2     = $ws.CreateShortcut("$startAll\PROMIXCO.lnk")
    $lnk2.TargetPath       = $exe
    $lnk2.IconLocation     = "$ico,0"
    $lnk2.WorkingDirectory = $InstallDir
    $lnk2.Description      = "PROMIXCO Email Marketing Tools"
    $lnk2.Save()
    Write-Host "[OK] Start Menu shortcut created at $startAll"

    # 3) Register in Windows Add/Remove Programs
    $regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\PROMIXCO"
    New-Item -Path $regPath -Force | Out-Null
    Set-ItemProperty -Path $regPath -Name "DisplayName"      -Value "PROMIXCO Email Marketing Tools"
    Set-ItemProperty -Path $regPath -Name "DisplayVersion"   -Value "1.0.0"
    Set-ItemProperty -Path $regPath -Name "Publisher"        -Value "PROMIXCO"
    Set-ItemProperty -Path $regPath -Name "InstallLocation"  -Value $InstallDir
    Set-ItemProperty -Path $regPath -Name "DisplayIcon"      -Value "$ico,0"
    Set-ItemProperty -Path $regPath -Name "UninstallString"  -Value "$InstallDir\UNINSTALL.bat"
    Set-ItemProperty -Path $regPath -Name "NoModify"         -Value 1 -Type DWord
    Set-ItemProperty -Path $regPath -Name "NoRepair"         -Value 1 -Type DWord
    Write-Host "[OK] Registered in Windows Apps list"

    # 4) Refresh desktop so icon appears immediately
    $code = @"
using System;
using System.Runtime.InteropServices;
public class Shell32 {
    [DllImport("shell32.dll")]
    public static extern void SHChangeNotify(int wEventId, int uFlags, IntPtr dwItem1, IntPtr dwItem2);
}
"@
    Add-Type -TypeDefinition $code
    [Shell32]::SHChangeNotify(0x8000000, 0, [IntPtr]::Zero, [IntPtr]::Zero)
    Write-Host "[OK] Desktop refreshed"

    exit 0
} catch {
    Write-Host "ERROR: $_"
    exit 1
}
