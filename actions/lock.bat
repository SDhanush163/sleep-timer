::==================
:: Locking PC
::==================

cls
mode con: cols=90 lines=10

echo ------------------------
echo %ESC%[1;93mLocking Windows%ESC%[0m
echo ------------------------

rundll32.exe user32.dll,LockWorkStation

if %errorlevel% neq 0 (
    set errorName=Lock Error
    set errMsg=Unable to lock Windows
    call "%baselocation%\functions\exception.bat"
)

echo ------------------------
echo %ESC%[1;92mSystem has been unlocked%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit%ESC%[0m

pause >nul

exit /b