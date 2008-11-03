@echo off

echo Setting local path variables
:: TortoiseSVN and its clever tool SubWCRev
set Tsvnpath=C:\Programme\TortoiseSVN\bin
set SubWCRev=%Tsvnpath%\SubWCRev.exe

set  ahkpath=C:\Programme\AutoHotkey
set  Ahk2Exe=%ahkpath%\Compiler\Ahk2Exe.exe

REM The path to the authohotkey directory in the local svn copy, MUST be "."
set srcdir=.
set Ssrcdir=%srcdir%\Source
set ahkrevtemplate=%Ssrcdir%\_subwcrev.tmpl.ahk
set   ahkrevoutput=%Ssrcdir%\_subwcrev.ahk
set batrevtemplate=%Ssrcdir%\_subwcrev.tmpl.bat
set   batrevoutput=%Ssrcdir%\_subwcrev.bat

REM The path to the directory used for generating a consistent SVN version (revision number)
set svnversiondir=..

:next1
echo Generating Version File
"%SubWCRev%" "%svnversiondir%" "%ahkrevtemplate%" "%ahkrevoutput%" -nm
if errorlevel 1 (
  echo Inconsistent Revision! Aborting
REM  goto :eof
)
"%SubWCRev%" "%svnversiondir%" "%batrevtemplate%" "%batrevoutput%"
call "%batrevoutput%"

set fn=%srcdir%\neo20-r%Revision%

echo Compiling Compose sequences
%Ssrcdir%\makecompose.ahk

rem echo Killing the old (AHK)Driver
rem tskill %fn%

echo removing old version(s) of NEO AHK Exe file
del %srcdir%\neo20-r*.exe %srcdir%\neo20-r*.ahk 2> nul

echo creating all-in-one script
echo ; Gesamtdatei > %fn%.ahk

for %%i in (_subwcrev en_us neocomp neovarscomp keydefinitions shortcuts recycle keyhooks varsfunctions) do (type "%Ssrcdir%\%%i.ahk" >> "%fn%.ahk")

echo Compiling the new Driver using Autohotkey
"%Ahk2Exe%" /in "%fn%.ahk" /out "%fn%.exe" /icon "%srcdir%\neo.ico"

echo Driver Update complete! You can now close this log-window.
pause