@echo off

echo Setting local path variables
:: TortoiseSVN and its clever tool SubWCRev
set Tsvnpath=C:\Programme\TortoiseSVN\bin
set SubWCRev=%Tsvnpath%\SubWCRev.exe

set  ahkpath=C:\Programme\AutoHotkey
set  Ahk2Exe=%ahkpath%\Compiler\Ahk2Exe.exe

REM The path to the authohotkey directory in the local svn copy, MUST be "."
set srcdir=.
set outdir=..\out
set Ssrcdir=%srcdir%\source
set ahkrevtemplate1=%Ssrcdir%\_subwcrev1.tmpl.ahk
set   ahkrevoutput1=%Ssrcdir%\_subwcrev1.generated.ahk
set batrevtemplate1=%Ssrcdir%\_subwcrev1.tmpl.bat
set   batrevoutput1=%Ssrcdir%\_subwcrev1.bat

set     NEO2AppData=%APPDATA%\NEO2
set       customahk=%NEO2AppData%\custom.ahk
set  customahkbuild=%customahk%.buildtmp

REM The path to the directory used for generating a consistent SVN version (revision number)
set svnversiondir1=.

echo Generating Version File
"%SubWCRev%" "%svnversiondir1%" "%ahkrevtemplate1%" "%ahkrevoutput1%"
"%SubWCRev%" "%svnversiondir1%" "%batrevtemplate1%" "%batrevoutput1%"
call "%batrevoutput1%"

set fnexe=%outdir%\neo20-custom.exe

set fnahk=%srcdir%\neo20-all.ahk

echo Compiling the new Driver using Autohotkey
"%Ahk2Exe%" /in "%fnahk%" /out "%fnexe%" /icon "%srcdir%\neo_enabled.ico"

echo Driver Update complete! You can now close this log-window.
pause
