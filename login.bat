@echo off
setlocal enabledelayedexpansion

set "username=admin"
set "password=1234"

:login
cls
echo ==========================
echo Welcome to the Login System
echo ==========================
set /p user="Enter username: "
set /p pass="Enter password: "

if "%user%"=="%username%" if "%pass%"=="%password%" (
    echo Login successful!
    goto :menu
) else (
    echo Invalid username or password. Please try again.
    pause
    goto :login
)

:menu
cls
echo ==========================
echo Main Menu
echo ==========================
echo 1. Option 1
echo 2. Option 2
echo 3. Exit
set /p choice="Enter your choice: "

if "%choice%"=="1" (
    echo You selected Option 1
    pause
    goto :menu
) else if "%choice%"=="2" (
    echo You selected Option 2
    pause
    goto :menu
) else if "%choice%"=="3" (
    echo Exiting...
    exit
) else (
    echo Invalid choice. Please try again.
    pause
    goto :menu
)