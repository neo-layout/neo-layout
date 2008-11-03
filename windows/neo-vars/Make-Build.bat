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
set ahkrevtemplate1=%Ssrcdir%\_subwcrev1.tmpl.ahk
set   ahkrevoutput1=%Ssrcdir%\_subwcrev1.ahk
set batrevtemplate1=%Ssrcdir%\_subwcrev1.tmpl.bat
set   batrevoutput1=%Ssrcdir%\_subwcrev1.bat
set ahkrevtemplate2=%Ssrcdir%\_subwcrev2.tmpl.ahk
set   ahkrevoutput2=%Ssrcdir%\_subwcrev2.ahk

REM The path to the directory used for generating a consistent SVN version (revision number)
set svnversiondir1=.
set svnversiondir2=..\..\Compose

:next1
echo Generating Version File
"%SubWCRev%" "%svnversiondir1%" "%ahkrevtemplate1%" "%ahkrevoutput1%"
"%SubWCRev%" "%svnversiondir1%" "%batrevtemplate1%" "%batrevoutput1%"
"%SubWCRev%" "%svnversiondir2%" "%ahkrevtemplate2%" "%ahkrevoutput2%"
call "%batrevoutput1%"

set fn=%srcdir%\neo20-r%Revision%

echo Compiling Compose sequences
%Ssrcdir%\makecompose.ahk

rem echo Killing the old (AHK)Driver
rem tskill %fn%

echo removing old version(s) of NEO AHK Exe file
del %srcdir%\neo20-r*.exe %srcdir%\neo20-r*.ahk 2> nul

echo creating all-in-one script
echo ; Gesamtdatei > %fn%.ahk

for %%i in (_subwcrev1 _subwcrev2 en_us neocomp neovarscomp keydefinitions shortcuts recycle keyhooks varsfunctions) do (type "%Ssrcdir%\%%i.ahk" >> "%fn%.ahk")

echo Compiling the new Driver using Autohotkey
"%Ahk2Exe%" /in "%fn%.ahk" /out "%fn%.exe" /icon "%srcdir%\neo_enabled.ico"

echo Driver Update complete! You can now close this log-window.
pause