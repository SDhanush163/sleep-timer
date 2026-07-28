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
set baselocation=%~dp0
call "%baselocation%\functions\ui.bat"

if /I %action%==exit (
    exit 0
)

cls
mode con: cols=70 lines=20

call "%baselocation%\functions\instructions.bat"
set /p input_time=Enter time : 

for /F "tokens=1,2 delims= " %%a in ("%input_time%") do (
  set /a time=%%a
  set format=%%b
)

if %errorlevel% neq 0 ( 
  set errorName=Input Error
  set errMsg=Time entered is not in the correct format. Please try again
  call "%baselocation%\functions\exception.bat" 
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
  call "%baselocation%\functions\exception.bat" 
)


::=============================
:: Starting the timeout counter
::=============================
:timer
call "%baselocation%\functions\countdown.bat"
call "%baselocation%\actions\%action%.bat"
