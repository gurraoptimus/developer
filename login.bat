@echo off
setlocal enabledelayedexpansion

REM File to store user data
set "user_db=C:\Users\user\developer\user_db.txt"

REM Read user data from file
if exist "%user_db%" (
    for /f "tokens=1,2 delims=," %%a in (%user_db%) do (
        set "users=%%a"
        set "passwords=%%b"
    )
) else (
    set "users=admin"
    set "passwords=1234"
)

:login
cls
echo ==========================
echo Welcome to the Login System
echo ==========================
set /p user="Enter username: "
set /p pass="Enter password: "

set "valid_login=false"
for /f "tokens=1* delims=," %%a in ("%users%") do (
    for /f "tokens=1* delims=," %%b in ("%passwords%") do (
        if "%%a"=="%user%" if "%%b"=="%pass%" (
            set "valid_login=true"
            goto :connect_to_server
        )
    )
)

if "%valid_login%"=="false" (
    echo Invalid username or password. Please try again.
    pause
    goto :login
)

:connect_to_server
cls
echo ==========================
echo Connecting to the server...
echo ==========================
REM Simulate server connection logic here
REM For example, you could use `ping` to check server availability
ping -n 3 127.0.0.1 >nul
echo Connected to the server successfully!
pause
goto :menu

:menu
cls
echo ==========================
echo Main Menu
echo ==========================
echo 1. Option 1
echo 2. Option 2
echo 3. Settings
echo 4. User Management
echo 5. Logout
echo 6. Exit
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
    goto :settings
) else if "%choice%"=="4" (
    goto :user_management
) else if "%choice%"=="5" (
    goto :logout
) else if "%choice%"=="6" (
    echo Exiting...
    exit
) else (
    echo Invalid choice. Please try again.
    pause
    goto :menu
)

:settings
cls
echo ==========================
echo Settings Menu
echo ==========================
echo 1. Change Username
echo 2. Change Password
echo 3. Back to Main Menu
set /p settings_choice="Enter your choice: "

if "%settings_choice%"=="1" (
    set /p new_username="Enter new username: "
    set "admin_username=%new_username%"
    echo Username changed successfully!
    pause
    goto :settings
) else if "%settings_choice%"=="2" (
    set /p new_password="Enter new password: "
    set "admin_password=%new_password%"
    echo Password changed successfully!
    pause
    goto :settings
) else if "%settings_choice%"=="3" (
    goto :menu
) else (
    echo Invalid choice. Please try again.
    pause
    goto :settings
)

:user_management
cls
echo ==========================
echo User Management Menu
echo ==========================
echo 1. Create User
echo 2. Remove User
echo 3. Delete All Users
echo 4. Back to Main Menu
set /p user_management_choice="Enter your choice: "

if "%user_management_choice%"=="1" (
    set /p new_user="Enter new username: "
    set /p new_user_password="Enter new password: "
    set "users=%users%,%new_user%"
    set "passwords=%passwords%,%new_user_password%"
    call :save_user_db
    echo User created successfully!
    pause
    goto :user_management
) else if "%user_management_choice%"=="2" (
    set /p remove_user="Enter username to remove: "
    call :remove_user %remove_user%
    call :save_user_db
    echo User removed successfully!
    pause
    goto :user_management
) else if "%user_management_choice%"=="3" (
    call :delete_all_users
    echo All users deleted successfully!
    pause
    goto :user_management
) else if "%user_management_choice%"=="4" (
    goto :menu
) else (
    echo Invalid choice. Please try again.
    pause
    goto :user_management
)

:remove_user
setlocal enabledelayedexpansion
set "new_users="
set "new_passwords="
for /f "tokens=1* delims=," %%a in ("%users%") do (
    if "%%a" neq "%1" (
        set "new_users=!new_users!,%%a"
    )
)
for /f "tokens=1* delims=," %%b in ("%passwords%") do (
    if "%%b" neq "%1" (
        set "new_passwords=!new_passwords!,%%b"
    )
)
endlocal & set "users=%new_users%" & set "passwords=%new_passwords%"
goto :eof

:delete_all_users
set "users="
set "passwords="
call :save_user_db
goto :eof

:save_user_db
(
    echo %users%,%passwords%
) > "%user_db%"
goto :eof

:logout
cls
echo ==========================
echo You have been logged out.
echo ==========================
pause
goto :login