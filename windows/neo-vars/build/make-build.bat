@echo off

echo Setting default local path variables
set  ahkpath=C:\Program Files (x86)\AutoHotkey
if not exist "%ahkpath%" set ahkpath=C:\Program Files\AutoHotkey
set  Ahk2Exe=%ahkpath%\Compiler\Ahk2Exe.exe

set srcdir=..\src
set bindir=..\bin
set   ahkrevoutput1=%srcdir%\_gitwcrev.generated.ahk

set     NEO2AppData=%APPDATA%\Neo2
set       customahk=%NEO2AppData%\custom.ahk
set  customahkbuild=%customahk%.buildtmp

echo Generating version file
for /f "tokens=* USEBACKQ" %%R in (`"git rev-parse HEAD"`) do set Revision=%%R
set Revision=%Revision:~0,7%

echo Revision:="%Revision%" > "%ahkrevoutput1%"

if NOT EXIST %bindir% mkdir %bindir%
set fnexe=%bindir%\neo20.exe
git diff --exit-code > nul
if %ERRORLEVEL% EQU 1 (
  set fnexe=%bindir%\neo20-r%Revision%.exe
)
REM Overwrite binary output name if given as parameter
if "%1:" NEQ ":" (
  set fnexe=%1
)

echo Removing old version(s) of Neo AHK Exe file
del "%bindir%\neo20-r*.exe" 2> nul

set fnahk=%srcdir%\neo20-all.ahk

if exist "%customahk%" (
  move "%customahk%" "%customahkbuild%"
)

echo Compiling the new driver using AutoHotkey
"%Ahk2Exe%" /in "%fnahk%" /out "%fnexe%" /icon "%srcdir%\neo_enabled.ico" /bin "%ahkpath%\Compiler\Unicode 32-bit.bin"

if exist "%customahkbuild%" (
  move "%customahkbuild%" "%customahk%"
)

echo Driver update complete! You can now close this log window.
pause
