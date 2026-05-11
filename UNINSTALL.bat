@echo off
title PROMIXCO Uninstaller
color 0C
cd /d "%~dp0"

echo.
echo  Uninstalling PROMIXCO Email Marketing Tools...
echo.

set "INSTALL_DIR=%ProgramFiles%\PROMIXCO"

:: Remove registry entry
powershell -NoProfile -ExecutionPolicy Bypass -Command "Remove-Item -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\PROMIXCO' -Force -ErrorAction SilentlyContinue"

:: Remove shortcuts
del /f /q "%PUBLIC%\Desktop\PROMIXCO.lnk" >nul 2>&1
del /f /q "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\PROMIXCO.lnk" >nul 2>&1

:: Remove install folder
if exist "%INSTALL_DIR%" rmdir /s /q "%INSTALL_DIR%"

echo  [OK] PROMIXCO has been uninstalled.
echo.
pause
