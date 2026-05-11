@echo off
title PROMIXCO - Build EXE
color 0A

echo.
echo  ============================================
echo   PROMIXCO Email Marketing Tools
echo   EXE Builder
echo  ============================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Python not found!
    echo  Install from https://python.org  then re-run this script.
    pause & exit /b
)
echo  [OK] Python found.

:: Install dependencies
echo  Installing required packages...
pip install pyinstaller dnspython pillow --quiet
echo  [OK] Packages ready.

:: Create data folder if missing
if not exist "data" mkdir data
if not exist "assets" mkdir assets

:: Build EXE
echo.
echo  Building EXE (this may take 1-3 minutes)...
echo.

pyinstaller ^
  --onefile ^
  --windowed ^
  --name "PROMIXCO Email Marketing Tools" ^
  --add-data "app;app" ^
  --add-data "assets;assets" ^
  --add-data "data;data" ^
  --hidden-import "dns" ^
  --hidden-import "dns.resolver" ^
  --hidden-import "dns.rdatatype" ^
  --hidden-import "dns.rdataclass" ^
  --hidden-import "PIL" ^
  --hidden-import "tkinter" ^
  --hidden-import "tkinter.ttk" ^
  --hidden-import "tkinter.scrolledtext" ^
  --hidden-import "tkinter.colorchooser" ^
  --hidden-import "tkinter.simpledialog" ^
  --hidden-import "smtplib" ^
  --hidden-import "email" ^
  --clean ^
  main.py

if errorlevel 1 (
    echo.
    echo  [ERROR] Build failed. Check output above for errors.
    pause & exit /b
)

echo.
echo  ============================================
echo   SUCCESS! EXE built in the dist\ folder:
echo   dist\PROMIXCO Email Marketing Tools.exe
echo  ============================================
echo.
echo  Copy the EXE to any Windows PC and run it.
echo  NOTE: First launch may take 5-10 seconds.
echo.
pause
