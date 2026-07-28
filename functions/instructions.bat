set actionColour=92

if /I "%action%"=="shutdown" set actionColour=91
if /I "%action%"=="restart" set actionColour=93
if /I "%action%"=="sleep" set actionColour=96
if /I "%action%"=="hibernate" set actionColour=95
if /I "%action%"=="lock" set actionColour=94
if /I "%action%"=="logoff" set actionColour=31

echo -----------------------------------------------------------
echo Selected Action - %ESC%[1;%actionColour%m%action%%ESC%[0m
echo -----------------------------------------------------------
echo %ESC%[1;92mSleep Timer%ESC%[0m  : An easy way to turn off the computer after
echo                a specifed time has elapsed
echo.
echo Enter in any of the following formats
echo       Seconds = x sec / x second(s) (Case sensitive)
echo       Minutes = x min / x minute(s) (Case sensitive)
echo       Hours   = x hr  / x hour(s)   (Case sensitive)
echo.
echo -----------------------------------------------------------