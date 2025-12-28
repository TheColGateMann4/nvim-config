@echo off
if "%~1"=="" (
	start "" "C:\Program Files\Neovide\neovide.exe" --maximized "%CD%"
) else (
	start "" "C:\Program Files\Neovide\neovide.exe" --maximized "%*"
)
exit /b