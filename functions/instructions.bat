set actionColour=92

if /I "%action%"=="shutdown" set actionColour=91
if /I "%action%"=="restart" set actionColour=93
if /I "%action%"=="sleep" set actionColour=96
if /I "%action%"=="hibernate" set actionColour=95
if /I "%action%"=="lock" set actionColour=94
if /I "%action%"=="logoff" set actionColour=31

echo -----------------------------------------------------------
echo %ESC%[1;92m                    Windows Power Timer %ESC%[0m
echo            An easy way to turn off the computer
echo -----------------------------------------------------------
echo %ESC%[1mSelected Action : %ESC%[1;%actionColour%m%action%%ESC%[0m
echo -----------------------------------------------------------
echo.
echo Enter in any of the following formats
echo.
echo %ESC%[1;93mAccepted Units%ESC%[0m
echo   • Seconds : sec, second, seconds
echo   • Minutes : min, minute, minutes
echo   • Hours   : hr, hour, hours
echo.
echo %ESC%[1;93mExamples%ESC%[0m
echo   • 30 sec • 5 min • 1 hour • 2 hours
echo.
echo Tip
echo   • Spaces are optional (e.g. 10min and 10 min).
echo   • Use whole numbers only.
echo.
echo -----------------------------------------------------------