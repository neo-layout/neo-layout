@echo off

echo Setting local path variables
:: TortoiseSVN and its clever tool SubWCRev
set Tsvnpath=C:\Programme\TortoiseSVN\bin
set SubWCRev=%Tsvnpath%\SubWCRev.exe

set  ahkpath=C:\Programme\AutoHotkey
set  AutoHotKey=%ahkpath%\AutoHotKeyU32.exe

REM The path to the authohotkey directory in the local svn copy, MUST be "."
set srcdir=..\src
set bindir=..\bin
set batrevtemplate2=%srcdir%\_subwcrev2.tmpl.bat
set   batrevoutput2=%srcdir%\_subwcrev2.bat

REM The path to the directory used for generating a consistent SVN version (revision number)
set gitversiondir=..\..\..\Compose

echo Generating Version File
"%SubWCRev%" "%gitversiondir%" "%batrevtemplate2%" "%batrevoutput2%"
call "%batrevoutput2%"

set fncomp=%srcdir%\compose.generated.ahk
"%SubWCRev%" "%gitversiondir%" -nm
if errorlevel 1 (
  set fncomp=%srcdir%\compose-tainted.generated.ahk
)

echo Deleting old Compose sequences
del "%srcdir%\Compose.generated.ahk" "%srcdir%\Compose-tainted.generated.ahk" 2> nul
SET CompRevision=0815

echo Compiling Compose sequences
"%AutoHotkey%" "%srcdir%\makecompose.ahk" "%CompRevision%" "%fncomp%" "%gitversiondir%\src\en_US.UTF-8" "%gitversiondir%\src\base.module" "%gitversiondir%\src\greek.module" "%gitversiondir%\src\math.module" "%gitversiondir%\src\lang.module" "%gitversiondir%\src\weiter_Definitionen.txt"

echo Compose Update complete! You can now close this log-window.
pause
