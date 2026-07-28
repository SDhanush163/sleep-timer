::==================
:: Shutting down PC
::==================

cls
mode con: cols=90 lines=10

echo ------------------------
echo %ESC%[1;93mShutting down Windows%ESC%[0m
echo ------------------------

shutdown /s /t 0

if %errorlevel% neq 0 (
    set errorName=Shutdown Error
    set errMsg=Unable to shutdown Windows
    call "%baselocation%\functions\exception.bat"
)

exit /b