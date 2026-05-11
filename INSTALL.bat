@echo off
title PROMIXCO Installer
color 0A
cd /d "%~dp0"

echo.
echo  ============================================
echo   PROMIXCO Email Marketing Tools
echo   Installer
echo  ============================================
echo.

:: ── Check Python ──────────────────────────────────────────────────────────
python --version >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Python not found.
    echo  Please install from https://python.org then re-run.
    pause & exit /b 1
)
echo  [OK] Python found.

:: ── Install packages ──────────────────────────────────────────────────────
echo  Installing required packages...
pip install pyinstaller dnspython pillow --quiet --no-warn-script-location
echo  [OK] Packages installed.

:: ── Create needed folders ─────────────────────────────────────────────────
if not exist "data"   mkdir "data"
if not exist "assets" mkdir "assets"

:: ── Build EXE ─────────────────────────────────────────────────────────────
echo.
echo  [1/3] Building EXE — please wait 2-3 minutes...
echo.

pyinstaller --onefile --windowed --name "PROMIXCO" --icon "assets\icon.ico" --add-data "app;app" --add-data "assets;assets" --hidden-import dns --hidden-import dns.resolver --hidden-import dns.rdatatype --hidden-import dns.rdataclass --hidden-import tkinter --hidden-import tkinter.ttk --hidden-import tkinter.scrolledtext --hidden-import tkinter.colorchooser --hidden-import tkinter.simpledialog --hidden-import smtplib --hidden-import email --clean main.py

if errorlevel 1 (
    echo.
    echo  [ERROR] EXE build failed. See output above.
    pause & exit /b 1
)
echo  [OK] EXE built successfully.

:: ── Copy to Program Files ─────────────────────────────────────────────────
echo.
echo  [2/3] Installing to Program Files...

set "INSTALL_DIR=%ProgramFiles%\PROMIXCO"
if not exist "%INSTALL_DIR%"       mkdir "%INSTALL_DIR%"
if not exist "%INSTALL_DIR%\data"  mkdir "%INSTALL_DIR%\data"

copy /Y "dist\PROMIXCO.exe"  "%INSTALL_DIR%\PROMIXCO.exe"  >nul
copy /Y "assets\icon.ico"    "%INSTALL_DIR%\icon.ico"       >nul

echo  [OK] Copied to: %INSTALL_DIR%

:: ── Create shortcuts via dedicated PS1 ───────────────────────────────────
echo.
echo  [3/3] Creating Desktop and Start Menu shortcuts...

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create_shortcuts.ps1" -InstallDir "%INSTALL_DIR%"

if errorlevel 1 (
    echo  [WARN] Shortcut script failed. Try running INSTALL.bat as Administrator.
) else (
    echo  [OK] Desktop shortcut created.
    echo  [OK] Start Menu shortcut created.
)

:: ── Done ──────────────────────────────────────────────────────────────────
echo.
echo  ============================================
echo   DONE! PROMIXCO is installed.
echo  ============================================
echo.
echo   Double-click the PROMIXCO icon on your Desktop to open.
echo.
echo   To pin to Taskbar:
echo   Right-click the Desktop icon - "Pin to taskbar"
echo.
echo   To pin to Start Menu:
echo   Click Start - search PROMIXCO - right-click - "Pin to Start"
echo.
echo   Your data is saved in:
echo   %INSTALL_DIR%\data\
echo.
pause
