@echo off

echo Setting local path variables
:: TortoiseSVN and its clever tool SubWCRev
set Tsvnpath=C:\Programme\TortoiseSVN\bin
set SubWCRev=%Tsvnpath%\SubWCRev.exe

set  ahkpath=C:\Programme\AutoHotkey
set  AutoHotKey=%ahkpath%\AutoHotKey.exe

REM The path to the authohotkey directory in the local svn copy, MUST be "."
set srcdir=.
set outdir=..\out
set Ssrcdir=%srcdir%\source
set batrevtemplate2=%Ssrcdir%\_subwcrev2.tmpl.bat
set   batrevoutput2=%Ssrcdir%\_subwcrev2.bat

REM The path to the directory used for generating a consistent SVN version (revision number)
set svnversiondir2=..\..\..\Compose

echo Generating Version File
"%SubWCRev%" "%svnversiondir2%" "%batrevtemplate2%" "%batrevoutput2%"
call "%batrevoutput2%"

set fncomp=%Ssrcdir%\compose.generated.ahk
"%SubWCRev%" "%svnversiondir2%" -nm
if errorlevel 1 (
  set fncomp=%Ssrcdir%\compose-tainted.generated.ahk
)

echo Deleting old Compose sequences
del "%Ssrcdir%\Compose.generated.ahk" "%Ssrcdir%\Compose-tainted.generated.ahk" 2> nul

echo Compiling Compose sequences
"%AutoHotkey%" "%Ssrcdir%\makecompose.ahk" "%CompRevision%" "%fncomp%" "%svnversiondir2%\src\en_US.UTF-8" "%svnversiondir2%\src\base.module" "%svnversiondir2%\src\greek.module" "%svnversiondir2%\src\math.module" "%svnversiondir2%\src\lang.module"

echo Compose Update complete! You can now close this log-window.
pause
