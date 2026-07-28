@echo off

::=============================================================
:: Parsing the timer input and converting it into total seconds
::=============================================================
set "parserError=false"
set /a totalSeconds=0

::=============================================================
:: Normalizing timer units to support inputs such as:
:: "1 h", "1 hour", "1 hr", "1hours", etc.
::=============================================================
set "timerInput=%timerInput: hours=hours%"
set "timerInput=%timerInput: hour=hour%"
set "timerInput=%timerInput: hrs=hrs%"
set "timerInput=%timerInput: hr=hr%"

set "timerInput=%timerInput: minutes=minutes%"
set "timerInput=%timerInput: minute=minute%"
set "timerInput=%timerInput: mins=mins%"
set "timerInput=%timerInput: min=min%"
set "timerInput=%timerInput: m=m%"

set "timerInput=%timerInput: seconds=seconds%"
set "timerInput=%timerInput: second=second%"
set "timerInput=%timerInput: secs=secs%"
set "timerInput=%timerInput: sec=sec%"
set "timerInput=%timerInput: s=s%"


:: Splitting the timer input into individual tokens and parsing
:: each value independently
for %%A in (%timerInput%) do (
    call :parseToken "%%A"

    if "%parserError%"=="true" (
        exit /b
    )
)

exit /b

::=============================================================
:: Parsing an individual timer token to determine its unit and
:: numeric value
::=============================================================
:parseToken

set "timer=%~1"
set "unit="
set "value="

:: Checking whether the token represents a value in seconds
call :tryUnit seconds s
call :tryUnit second  s
call :tryUnit secs    s
call :tryUnit sec     s
call :tryUnit s       s

:: Checking whether the token represents a value in minutes
call :tryUnit minutes m
call :tryUnit minute  m
call :tryUnit mins    m
call :tryUnit min     m
call :tryUnit m       m

:: Checking whether the token represents a value in hours
call :tryUnit hours h
call :tryUnit hour    h
call :tryUnit hrs     h
call :tryUnit hr      h
call :tryUnit h       h

:: Treating values without a unit as seconds after validating
:: that they contain only numeric characters
if not defined unit (
    echo %timer% | findstr /R "[^0-9]" >nul

    if errorlevel 1 (
        set "unit=s"
        set "value=%timer%"
    ) else (
        set parserError=true
        exit /b
    )
)

:: Ensuring that the timer value is present before processing
if "%value%"=="" (
    set parserError=true
    exit /b
)

:: Validating that the extracted value contains only digits
echo %value% | findstr /R "[^0-9]" >nul

if errorlevel 1 (
    set parserError=true
    exit /b
)

:: Ensuring that the timer value is greater than zero
if %value% LEQ 0 (
    set parserError=true
    exit /b
)

::=============================================================
:: Converting the parsed value into seconds and adding it to
:: the running total
::=============================================================
if "%unit%"=="s" set /a totalSeconds+=%value%
if "%unit%"=="m" set /a totalSeconds+=%value%*60
if "%unit%"=="h" set /a totalSeconds+=%value%*3600

exit /b

::=============================================================
:: Checking whether the timer token contains a supported unit
:: and extracting its numeric value
::
:: %1 = Unit suffix to search for
:: %2 = Canonical unit identifier (s, m or h)
::=============================================================
:tryUnit

if defined unit exit /b

set "suffix=%~1"

call set "tmp=%%timer:%suffix%=%%"

if not "%tmp%"=="%timer%" (
    set "unit=%~2"
    set "value=%tmp%"
)

exit /b