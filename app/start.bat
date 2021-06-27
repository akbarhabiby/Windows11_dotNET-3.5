@echo off
Title .NET Framework 3.5 Offline Installer for Windows 11

if not "%1"=="am_admin" (
	echo Asking for administrator permission
	timeout /t 3
	powershell start -verb runas '%0' am_admin & exit /b
)

set pwd=%~dp0
set dotnet=%pwd%\sources\microsoft-windows-netfx3-ondemand-package~31bf3856ad364e35~amd64~~.cab

if exist %dotnet% (
	echo Installing .NET Framework 3.5...
	Dism /online /enable-feature /featurename:NetFX3 /All /Source:%pwd%:\sources /LimitAccess
	if errorlevel 87 (
		echo.
		echo [ERROR] Oopss.. file found but failed install.
		echo [ERROR] Try to move this folder into C:
		echo.
	) else if errorlevel 0 (
		echo.
		echo [SUCCESS] .NET Framework 3.5 should be installed
		echo.	
	)
) else (
	if not errorlevel 87 (
		echo [ERROR] Oopss.. file not found.
		echo [ERROR] Please check sources folder and try again.
		echo.
	)
)

pause
