::==================
:: Restarting PC
::==================

cls
mode con: cols=90 lines=10

echo ------------------------
echo %ESC%[1;93mRestarting Windows%ESC%[0m
echo ------------------------

shutdown /r /t 0

if %errorlevel% neq 0 (
    set errorName=Restart Error
    set errMsg=Unable to restart Windows
    call "%baselocation%\functions\exception.bat"
)

exit /b