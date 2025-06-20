@echo off

::=============================================================
:: Setting the Escape sequence character to the variable "ESC"
::=============================================================
setlocal
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do ( 
  set ESC=%%b
)
cls

::==================================================================
:: Taking user input and separating it to time and format specifiers
::==================================================================
mode con: cols=60 lines=15

:: Replace [LOCATION] with the complete path of the project
set baselocation=[LOCATION]

call "%baselocation%\instructions.bat"
set /p input_time=Enter time : 

for /F "tokens=1,2 delims= " %%a in ("%input_time%") do (
  set /a time=%%a
  set format=%%b
)

if %errorlevel% neq 0 ( 
  set errorName=Input Error
  set errMsg=Time entered is not in the correct format. Please try again
  call "%baselocation%\exception.bat" 
)

::========================================================
:: Setting counter value based on provided format and time
::========================================================
if %format%==sec      ( set /a count=%time% & goto timer )
if %format%==second   ( set /a count=%time% & goto timer )
if %format%==seconds  ( set /a count=%time% & goto timer )

if %format%==min      ( set /a count=%time% * 60 & goto timer )
if %format%==minute   ( set /a count=%time% * 60 & goto timer )
if %format%==minutes  ( set /a count=%time% * 60 & goto timer )

if %format%==hr       ( set /a count=%time% * 3600 & goto timer )
if %format%==hour     ( set /a count=%time% * 3600 & goto timer )
if %format%==hours    ( set /a count=%time% * 3600 & goto timer ) else ( 
  set errorName=Time Format Error
  set errMsg=Format did not match. Please try again
  call "%baselocation%\exception.bat" 
)


::=============================
:: Starting the timeout counter
::=============================
:timer
call "%baselocation%\timer.bat"

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
  call "%baselocation%\exception.bat" 
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
  call "%baselocation%\exception.bat"
)

echo ------------------------
echo %ESC%[1;92mSystem is in standby%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit

pause >nul