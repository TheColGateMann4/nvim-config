@echo off
setlocal

if "%~1"=="" (
    for /f "usebackq delims=" %%p in (`wsl wslpath "%CD%"`) do (
        start "" "C:\Program Files\Neovide\neovide.exe" --maximized --wsl -- "%%p"
    )
) else (
    for /f "usebackq delims=" %%p in (`wsl wslpath "%*"` ) do (
        start "" "C:\Program Files\Neovide\neovide.exe" --maximized --wsl -- "%%p"
    )
)

endlocal
exit /b
