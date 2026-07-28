@echo off

::=========================================
:: Validate Supported Windows Power States
::=========================================

set sleepSupported=false
set availableSection=false

for /f "delims=" %%A in ('powercfg /a') do (

    if "%%A"=="The following sleep states are available on this system:" (
        set availableSection=true
    )

    if "%%A"=="The following sleep states are not available on this system:" (
        set availableSection=false
    )

    if /I "!availableSection!"=="true" (
        echo %%A | findstr /C:"Standby (S3)" >nul
        if !errorlevel!==0 (
            set sleepSupported=true
        )
    )
)

exit /b