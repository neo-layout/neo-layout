@echo off

echo Setting default local path variables
set  ahkpath=C:\Programme\AutoHotkey
set  AutoHotKey=%ahkpath%\AutoHotKeyU32.exe

set srcdir=..\src
set bindir=..\bin

REM The path to the directory used for generating a consistent SVN version (revision number)
set gitversiondir=..\..\..\Compose

echo Getting git revision
for /f "tokens=* USEBACKQ" %%R in (`"git rev-parse HEAD"`) do set CompRevision=%%R
set CompRevision=%CompRevision:~0,7%

set fncomp=%srcdir%\compose.generated.ahk
git diff --exit-code > nul
if %ERRORLEVEL% EQU 1 (
  set fncomp=%srcdir%\compose-tainted.generated.ahk
)

echo Deleting old compose sequences
del "%srcdir%\Compose.generated.ahk" "%srcdir%\Compose-tainted.generated.ahk" 2> nul

echo Compiling compose sequences
"%AutoHotkey%" "%srcdir%\makecompose.ahk" "%CompRevision%" "%fncomp%" "%gitversiondir%\src\en_US.UTF-8" "%gitversiondir%\src\base.module" "%gitversiondir%\src\greek.module" "%gitversiondir%\src\math.module" "%gitversiondir%\src\lang.module" "%gitversiondir%\src\weiter_Definitionen.txt"

echo Compose update complete! You can now close this log window.
pause
