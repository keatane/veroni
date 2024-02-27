@echo off
cls
title Veroni - Custom package installer -- DAILY version
echo =========================================================
echo.
echo 		\\     //   ^|^|
echo 		 \\   //    ^|^|
echo 		  \\ //     ^|^|
echo 		   \V/ ^|\ ^| ^|^|
echo 		 [] V  ^| \^| ^|^| [Daily]
echo.
echo =========================================================
echo Author: keatane
echo =========================================================
echo.
echo Welcome to Veroni, the custom automatic package installer
echo.
echo Please, before running the following script, get sure:
echo - to have already launched at least one time the command 'winget update' to accept Terms
echo - to have 'curl' command installed
echo =========================================================
timeout /t 2 >nul
echo.
echo.
echo ^*^*^*^*^*^*^*^*^*^* Process starting ^*^*^*^*^*^*^*^*^*^*
echo.

cd C:\

goto :check_administrative
:ok_administrative

goto :update
:ok_update

rem installation of custom programs
echo ^>^>^>^>^>^>^>^>^>^> Installation of custom packages
echo.
echo -- Installation of Chocolatey package manager ...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
echo -V DONE, please notice that a new terminal must be open to use 'choco' command
echo -- Installation of Python 3.12.0 ...
curl -O https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe
set myString=Start-Process -Wait -FilePath .\python-3.12.0-amd64.exe
powershell -Command "& {param([string]$arg); Write-Host 'Argument received: ' $arg}" "%myString%"
python -m pip install --upgrade pip
echo -- Installation of Python must-have libraries ...
pip install numpy pandas matplotlib seaborn scikit-learn pytest coverage virtualenv >nul
echo -V DONE

cd C:\Program files

echo -- Installation of Microsoft VisualStudioCode ...
winget install Microsoft.VisualStudioCode >nul
echo -V DONE
echo -- Installation of Brave Browser ...
winget install Brave.Brave >nul
echo -V DONE
echo -- Installation of Docker Desktop ...
winget install Docker.DockerDesktop >nul
echo -V DONE
echo -- Installation of Git ...
winget install Git.Git >nul
echo -V DONE
echo -- Installation of Notepad^+^+ ...
winget install Notepad^+^+.Notepad^+^+ >nul
echo -V DONE
echo -- Installation of Bitwarden Password Manager ...
winget install Bitwarden.Bitwarden >nul
echo -V DONE
echo -- Installation of Discord ...
winget install Discord.Discord >nul
echo -V DONE
echo -- Installation of Epic Games Game Launcher ...
winget install EpicGames.EpicGamesLauncher >nul
echo -V DONE
echo -- Installation of Steam Game Launcher ...
winget install Valve.Steam >nul
echo -V DONE
echo -- Installation of Wireguard Tunnel ...
winget install WireGuard.WireGuard >nul
echo -V DONE
echo -- Installation of Microsoft OneDrive...
winget install Microsoft.OneDrive >nul
echo -V DONE
echo.
echo ^>^>^>^>^>^>^>^>^>V DONE
echo.

echo ^>^>^>^>^>^>^>^>^>^> It is suggested to reboot your computer, if so this script will exit here.
echo ^>^>^>^>^>^>^>^>^>^> Do you want to reboot your computer now^? [yes][no]
set /p answer=
if %answer% equ yes (
	echo ^*^*^*^*^*^*^*^*^*^*  Rebooting requested. Rebooting in 10 seconds... ^*^*^*^*^*^*^*^*^*^* 
	timeout /t 10 >nul
	shutdown /r /t 0
) else (
	echo ^>^>^>^>^>^>^>^>^>^> No reboot requested.
)

echo.
echo.
echo ^*^*^*^*^*^*^*^*^*^* Process successfully exiting ^*^*^*^*^*^*^*^*^*^*
timeout /t 2 >nul
exit /b 0



rem auxiliary functions

rem to manage exiting after failure
:error_failing
echo ^>^>^>^>^>^>^>^>^>X FAILED
echo.
echo Exiting batch process in 2 seconds
timeout /t 2 >nul
exit /b 1 rem exit batch script (forced with error code 1)
goto :eof

rem checking for updates to current installed packages and programs
:update
echo ^>^>^>^>^>^>^>^>^>^> Checking and updating installed packages
echo.
winget upgrade --all --include-unknown
if not %errorlevel% equ 0 (
	echo.
    echo -- An error occured during the checking or installation of updates
	echo.
	goto :error_failing
)
echo -- Please note that some applications version can't be determined and can't be automatically installed
echo.
echo ^>^>^>^>^>^>^>^>^>V DONE
echo.
echo.
goto :ok_update

rem checking if process has started with administrative privileges
:check_administrative
echo ^>^>^>^>^>^>^>^>^>^> Checking administrative privileges
>nul 2>&1 net session
if not %errorlevel% equ 0 (
	echo.
    echo -- The process is not running with administrative privileges.
	echo -- Please reload the application with administrative privileges.
	echo.
	goto :error_failing
)
echo ^>^>^>^>^>^>^>^>^>V DONE
echo.
echo.
goto :ok_administrative

:eof