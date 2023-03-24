@echo off
:: This script is used to upgrade Windows 11 from a remote source

:: Set the variable for the upgrade directory
set UPGRADE_DIR=C:\Upgrade

:: Map a network drive Z:(This can be something else) to the Windows 11 share on the remote computer
:: IP address of the remote computer: IP
:: Share name: Share_Name
:: User credentials: User / Password
net use Z: \\IP\Share_Name /user:User Password

:: Create a new directory to store the Windows 11 upgrade files. This can be any dir.
mkdir %UPGRADE_DIR%

:: Copy the contents of the Z: drive (remote Windows 11 share) to the upgrade directory
:: /y: Suppress the confirmation prompt when overwriting existing files
:: /s: Copy directories and subdirectories, excluding empty ones
:: /e: Copy directories and subdirectories, including empty ones
:: /h: Copy hidden and system files as well
xcopy Z: %UPGRADE_DIR% /y /s /e /h

:: Disconnect the mapped network drive Z:
net use Z: /delete

:: Start the Windows 11 upgrade process
:: /auto Upgrade: Perform an automatic upgrade to Windows 11
:: /EULA accept: Accept the End User License Agreement
start "" %UPGRADE_DIR%\setup /auto Upgrade /EULA accept