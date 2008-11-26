if (A_IsCompiled) {
; Revisionsinformation bereits verfügbar
} else {
; Revisionsinformation nicht verfügbar oder nicht zuverlässig, neu generieren
  if (FileExist(".svn")<>False) {
    ; .svn existiert, scheint also ausgecheckt worden zu sein
    RegRead,TSVNPath,HKLM,SOFTWARE\TortoiseSVN,Directory
    RegRead,SVNPath,HKLM,SOFTWARE\CollabNet\Subversion\1.5.4\Client,Install Location
    if (TSVNPath<>"") {
      ; fein, TSVN ist installiert!
      RunWait, "%TSVNPath%bin\SubWCRev.exe" "." "Source\_subwcrev1.tmpl.ahk" "Source\_subwcrev1.generated.ahk",,Hide
      FileRead,TSVNRevFull,Source\_subwcrev1.generated.ahk
      RegExMatch(TSVNRevFull,"""(.*)""",SubPat)
      Revision := SubPat1
    } else if (SVNPath<>"") {
      ; fein, CollabNet-SVN-Client ist installiert!
      RunWait, %comspec% /c ""%SVNPath%\svnversion.exe" "." >"Source\_svnversion.generated.txt"",,Hide
      FileRead,SVNRevFull,Source\_svnversion.generated.txt
      RegExMatch(SVNRevFull,"(.*)$",SubPat)
      Revision := SubPat1
    } else {
      ; nichts installiert. Was jetzt?
      Revision := "<unknown>"
    }
  } else {
    ; kein .svn-Verzeichnis. Was jetzt?
    Revision := "<unknown>"
  }
}

name=Neo 2.0 r%Revision%-r%CompRevision% (%A_ScriptName%)
enable=Aktiviere %name%
disable=Deaktiviere %name%
#LTrim ; Quelltext kann eingerückt werden

SetCapsLockState Off
SetNumLockState Off
SetScrollLockState Off
KeyboardLED(2,"off") ; deaktivieren, falls sie doch brennt

EnvGet, WindowsEnvAppDataFolder, APPDATA
ApplicationFolder = %WindowsEnvAppDataFolder%\NEO2
FileCreateDir, %ApplicationFolder%
ini = %ApplicationFolder%\NEO2.ini

IniRead,zeigeLockBox,%ini%,Global,zeigeLockBox,1
IniRead,zeigeModusBox,%ini%,Global,zeigeModusBox,1
IniRead,UseMod4Light,%ini%,Global,UseMod4Light,1
IniRead,striktesMod2Lock,%ini%,Global,striktesMod2Lock,0

regread,inputlocale,HKEY_CURRENT_USER,Keyboard Layout\Preload,1
regread,inputlocalealias,HKEY_CURRENT_USER,Keyboard Layout\Substitutes,%inputlocale%
if (inputlocalealias<>inputlocale=%inputlocalealias% and inputlocale<>00000407) {
  suspend   
  regread,inputlocale,HKEY_LOCAL_MACHINE,SYSTEM\CurrentControlSet\Control\Keyboard Layouts\%inputlocale%,Layout Text
  msgbox, 48, Warnung!,
    (
    Nicht kompatibles Tastaturlayout:   
    `t%inputlocale%   
    `nDas deutsche QWERTZ muss als Standardlayout eingestellt  
    sein, damit %name% wie erwartet funktioniert.   
    `nÄndern Sie die Tastatureinstellung unter 
    `tSystemsteuerung   
    `t-> Regions- und Sprachoptionen   
    `t-> Sprachen 
    `t-> Details...   `n
    )
  exitapp
}

wasNonShiftKeyPressed := 0
isShiftRPressed := 0
isShiftLPressed := 0
isShiftPressed := 0
isMod2Locked := 0
IsMod3RPressed := 0
IsMod3LPressed := 0
IsMod3Pressed := 0
IsMod4RPressed := 0
IsMod4LPressed := 0
IsMod4Pressed := 0
IsMod4Locked := 0
EbeneAktualisieren()

