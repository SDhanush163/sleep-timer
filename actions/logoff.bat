::==================
:: Logging Off User
::==================

cls
mode con: cols=90 lines=10

echo ------------------------
echo %ESC%[1;93mLogging off Windows%ESC%[0m
echo ------------------------

shutdown /l

if %errorlevel% neq 0 (
    set errorName=Log Off Error
    set errMsg=Unable to log off Windows
    call "%baselocation%\functions\exception.bat"
)

exit /b