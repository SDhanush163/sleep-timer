::===============
:: Going to sleep
::===============

cls
mode con: cols=90 lines=10

echo ------------------------
echo %ESC%[1;93mGoing to standby%ESC%[0m
echo ------------------------

:: Termporarily disabling hibernate
powercfg -hibernate off
if %errorlevel% neq 0 (
  set errorName=Admin Privilages Error
  set errMsg=Cannot disable Hibernate. Batch file should be run with Admin privilages
  call "%baselocation%\functions\exception.bat"
)

:: Replace with "shutdown /s" to Shutdown
:: Replace with "shutdown /r" to Restart
:: Replace with "shutdown /l" to Log off
rundll32.exe powrprof.dll,SetSuspendState Standby

:: Enabling hibernate
powercfg -hibernate on
if %errorlevel% neq 0 (
  set errorName=Admin Privilages Error
  set errMsg=Cannot enable Hibernate. Batch file should be run with Admin privilages
  call "%baselocation%\functions\exception.bat"
)

echo ------------------------
echo %ESC%[1;92mSystem is in standby%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit

pause >nul