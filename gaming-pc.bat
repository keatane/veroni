@echo off
cls
title Veroni - Custom package installer -- GAMING version
echo =========================================================
echo.
echo 		\\     //   ^|^|
echo 		 \\   //    ^|^|
echo 		  \\ //     ^|^|
echo 		   \V/ ^|\ ^| ^|^|
echo 		 [] V  ^| \^| ^|^| [Gaming]
echo.
echo =========================================================
echo Author: keatane
echo =========================================================
echo.
echo Welcome to Veroni, the custom automatic package installer
echo.
echo =========================================================
echo.
echo.
echo ^*^*^*^*^*^*^*^*^*^* Process starting ^*^*^*^*^*^*^*^*^*^*
echo.

cd C:\Program Files

goto :check_administrative
:ok_administrative

goto :update
:ok_update

rem installation of custom programs
echo ^>^>^>^>^>^>^>^>^>^> Installation of custom packages
echo.
echo -- Installation of Brave Browser...
winget install Brave.Brave >nul
echo -V DONE
echo -- Installation of Notepad^+^+ ...
winget install Notepad^+^+.Notepad^+^+ >nul
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
winget upgrade --all --include-unknown >nul
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