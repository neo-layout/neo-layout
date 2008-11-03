/******************
* Initialisierung *
*******************
*/

#MaxThreadsPerHotKey 4

EbeneAktualisieren()
SetBatchLines -1
SetCapsLockState Off
SetNumLockState Off
SetScrollLockState Off

name=Neo 2.0 (%A_ScriptName%) (r%Revision%-r%CompRevision%)
enable=Aktiviere %name%
disable=Deaktiviere %name%
#usehook on
#singleinstance force
#LTrim ; Quelltext kann eingerückt werden, 
Process,Priority,,High
Sendmode Input
#MaxHotkeysPerInterval 2000

/****************
* Verzeichnisse *
*****************
*/
; Setzt den Pfad zu einem temporären Verzeichnis
EnvGet, WindowsEnvTempFolder, TEMP
ResourceFolder = %WindowsEnvTempFolder%\NEO2
FileCreateDir, %ResourceFolder%

; Setzt den Pfad zu den NEO-Anwendungsdateien
EnvGet, WindowsEnvAppDataFolder, APPDATA
ApplicationFolder = %WindowsEnvAppDataFolder%\NEO2
FileCreateDir, %ApplicationFolder%
ini = %ApplicationFolder%\NEO2.ini

/*******************
* Globale Schalter *
********************
*/
; Im folgenden gilt (soweit nicht anders angegeben) Ja = 1, Nein = 0:

; Sollen die Bilder für die Bildschirmtastatur in die compilierte EXE-Datei miteingebunden werden? (Nachteil: grössere Dateigrösse, Vorteil: Referenz für Anfänger stets einfach verfügbar)
bildschirmTastaturEinbinden := 1

; Syntaxhinweis: IniRead, Variable, InputFilename, Section, Key [, DefaultValue]

; Soll der Treiber im Einhandmodus betrieben werden?
IniRead,einHandNeo,%ini%,Global,einHandNeo,0

; Soll der Lernmodus aktiviert werden?
IniRead,lernModus,%ini%,Global,lernModus,0

; Soll mit einer MsgBox explizit auf das Ein- und Ausschalten des Mod4-Locks hingewiesen werden?
IniRead,zeigeLockBox,%ini%,Global,zeigeLockBox,1

; Soll aktivierter Mod4-Lock über die Rollen-LED des Keybord angezeigt werden (analog zu CapsLock)?
IniRead,UseMod4Light,%ini%,Global,UseMod4Light,1

; Soll Lang-s auf s, s auf ß und ß auf Lang-s gelegt (bzw. vertauscht) werden?
IniRead,LangSTastatur,%ini%,Global,LangSTastatur,0
If LangSTastatur
  CharProc("LnS1")
else
  KeyboardLED(2,"off") ; deaktivieren, falls sie doch brennt

IniRead,isVM,%ini%,Global,isVM,0
if (isVM)
  CharProc("_VM1")

;Soll der Mod2Lock auch auf die Akzente, die Ziffernreihe und das Numpad angewandt werden?
; Wird striktesMod2Lock auf 1 gesetzt, wirkt CapsLock wie ShiftLock
IniRead,striktesMod2Lock,%ini%,Global,striktesMod2Lock,0


/***********************
* Resourcen-Verwaltung *
************************
*/
if(FileExist("ResourceFolder")<>false){
  ; Versuche, alle möglicherweise in die EXE eingebundenen Dateien zu extrahieren 
  FileInstall,neo_enabled.ico,%ResourceFolder%\neo_enabled.ico,1
  FileInstall,neo_disabled.ico,%ResourceFolder%\neo_disabled.ico,1
  iconBenutzen=1
  if (bildschirmTastaturEinbinden=1){
    FileInstall,ebene1.png,%ResourceFolder%\ebene1.png,1
    FileInstall,ebene2.png,%ResourceFolder%\ebene2.png,1
    FileInstall,ebene3.png,%ResourceFolder%\ebene3.png,1
    FileInstall,ebene4.png,%ResourceFolder%\ebene4.png,1
    FileInstall,ebene5.png,%ResourceFolder%\ebene5.png,1
    FileInstall,ebene6.png,%ResourceFolder%\ebene6.png,1
    zeigeBildschirmTastatur=1
  }
}else{
  MsgBox,"Das Verzeichnis %ResourceFolder% konnte nicht angelegt werden!" ; Diese Zeile dient nur der eventuellen Fehlersuche und sollte eigentlich niemals auftauchen.
}

; Benutze die Dateien auch dann, wenn sie eventuell im aktuellen Verzeichnis vorhanden sind 
if(FileExist("ebene1.png")&&FileExist("ebene2.png")&&FileExist("ebene3.png")&&FileExist("ebene4.png")&&FileExist("ebene5.png")&&FileExist("ebene6.png"))
  zeigeBildschirmTastatur=1
if(FileExist("neo_enabled.ico")&&FileExist("neo_disabled.ico"))
  iconBenutzen=1

/*******************************************
* Überprüfung auf deutsches Tastaturlayout *
********************************************
*/
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

/*************************
* Menü des Systray-Icons *
**************************
*/
if (iconBenutzen)
  menu,tray,icon,%ResourceFolder%\neo_enabled.ico,,1
menu,tray,nostandard
menu,tray,add,Öffnen,open
  menu,helpmenu,add,About,about
  menu,helpmenu,add,Autohotkey-Hilfe,help
  menu,helpmenu,add
  menu,helpmenu,add,http://autohotkey.com/,autohotkey
  menu,helpmenu,add,http://www.neo-layout.org/,neo
menu,tray,add,Hilfe,:helpmenu
menu,tray,add
menu,tray,add,%disable%,togglesuspend
menu,tray,add
menu,tray,add,Bearbeiten,edit
menu,tray,add,Neu Laden,reload
menu,tray,add
menu,tray,add,Nicht im Systray anzeigen,hide
menu,tray,add,%name% beenden, exitprogram
menu,tray,default,%disable%
menu,tray,tip,%name%

/*
Sonstige Variablen
*/
guiErstellt := 0
alwaysOnTop := 1
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
; die Nachfolgenden sind nützlich um sich die Qwertz-Tasten abzugewöhnen, da alle auf der 4. Ebene vorhanden.
lernModus_std_Return := 0
lernModus_std_Backspace := 0
lernModus_std_PgUp := 0
lernModus_std_PgDn := 0
lernModus_std_Einf := 0
lernModus_std_Entf := 0
lernModus_std_Pos0 := 0
lernModus_std_Ende := 0
lernModus_std_Hoch := 0
lernModus_std_Runter := 0
lernModus_std_Links := 0
lernModus_std_Rechts := 0
lernModus_std_ZahlenReihe := 0

; im folgenden kann man auch noch ein paar Tasten der 4. Ebene deaktivieren
; nützlich um sich zu zwingen, richtig zu schreiben
lernModus_neo_Backspace := 0
lernModus_neo_Entf := 1



EbeneAktualisieren()
{
  global
  Modstate := IsMod4Active() . IsMod3Active()
  Ebene7 := 0
  Ebene8 := 0
  if        (Modstate == "00") { ; Ebene 1 oder 2
    if (IsShiftActive())         ; Ebene 2: Shift oder CapsLock
      Ebene := 2
    else                         ; Ebene 1: Ohne Mod oder CapsLock mit Shift
      Ebene := 1
    if (IsShiftPressed)          ; NC: Ebene 2: Shift (ignoriert CapsLock)
      EbeneNC := 2
    else                         ; NC: Ebene 1: Ohne Mod (ignoriert CapsLock)
      EbeneNC := 1
  } else if (Modstate == "01") { ; Ebene 3 oder 5 (ignoriert CapsLock)
    if (IsShiftPressed)          ; Ebene 5: Shift+Mod3
      Ebene := 5
    else                         ; Ebene 3: Mod3
      Ebene := 3
    EbeneNC := Ebene             ; NC: gleich
  } else if (Modstate == "10") { ; Ebene 4 (Mit Shift: Auch Ebene 7) (ignoriert CapsLock)
    Ebene := 4
    if (IsShiftPressed)          ; Ebene 7: Shift+Mod4
      Ebene7 := 1
    EbeneNC := Ebene             ; NC: gleich
  } else if (ModState == "11") { ; Ebene 6 (Mit Shift Xoder CapsLock: Auch Ebene 8)
    Ebene := 6
    if (IsShiftPressed)          ; Ebene 8: Shift (ignoriert CapsLock)
      Ebene8 := 1
    EbeneNC := Ebene             ; NC: gleich
  }
}

IsShiftActive() {
  global
  if (isMod2Locked)
    if (isShiftPressed)
      return 0
    else
      return 1
  else
    if (isShiftPressed)
      return 1
    else
      return 0
}

IsMod3Active() {
   global
   return isMod3Pressed
}

IsMod4Active() {
  global
  if (isMod4Locked)
    if (isMod4Pressed)
      return 0
    else
      return 1
  else
    if (isMod4Pressed)
      return 1
    else
      return 0
}

/* 
   ------------------------------------------------------
   Methode KeyboardLED zur Steuerung der Keyboard-LEDs
   (NumLock/CapsLock/ScrollLock-Lichter)
   
   Benutzungshinweise: Man benutze
   KeyboardLED(LEDvalue,"Cmd"), wobei
   Cmd = on/off/switch,
   LEDvalue: ScrollLock=1, NumLock=2, CapsLock=4,
   bzw. eine beliebige Summe dieser Werte:
   AlleAus=0, CapsLock+NumLock=6, etc.
   
   Der folgende Code wurde übernommen von:
   http://www.autohotkey.com/forum/viewtopic.php?t=10532
   
   Um eventuelle Wechselwirkungen mit dem bestehenden
   Code (insb. der Unicode-Konvertierung) auszuschließen,
   sind auch alle (Hilfsmethoden) mit dem Postfix LED
   versehen worden.
   ------------------------------------------------------
*/

KeyboardLED(LEDvalue, Cmd){ ; LEDvalue: ScrollLock=1, NumLock=2, CapsLock=4 ; Cmd = on/off/switch
  Static h_device
  If ! h_device ; initialise
  {
    device=\Device\KeyBoardClass0
    SetUnicodeStrLED(fn,device) 
    h_device:=NtCreateFileLED(fn,0+0x00000100+0x00000080+0x00100000,1,1,0x00000040+0x00000020,0)
  }
  VarSetCapacity(output_actual,4,0)
  input_size=4
  VarSetCapacity(input,input_size,0)
  If Cmd=switch ;switches every LED according to LEDvalue
   KeyLED:=LEDvalue
  If Cmd=on ;forces all choosen LED's to ON (LEDvalue= 0 ->LED's according to keystate)
   KeyLED:=LEDvalue | (GetKeyState("ScrollLock", "T") + 2*GetKeyState("NumLock", "T") + 4*GetKeyState("CapsLock", "T"))
  If Cmd=off ;forces all choosen LED's to OFF (LEDvalue= 0 ->LED's according to keystate)
    {
    LEDvalue:=LEDvalue ^ 7
    KeyLED:=LEDvalue & (GetKeyState("ScrollLock","T") + 2*GetKeyState("NumLock","T") + 4*GetKeyState("CapsLock","T"))
    }
  ; EncodeIntegerLED(KeyLED,1,&input,2) ;input bit pattern (KeyLED): bit 0 = scrolllock ;bit 1 = numlock ;bit 2 = capslock
  input:=Chr(1) Chr(1) Chr(KeyLED)
  input:=Chr(1)
  input=
  success:=DllCall("DeviceIoControl"
    , "uint", h_device
    , "uint", CTL_CODE_LED( 0x0000000b     ; FILE_DEVICE_KEYBOARD
              , 2
              , 0             ; METHOD_BUFFERED
              , 0  )          ; FILE_ANY_ACCESS
    , "uint", &input
    , "uint", input_size
    , "uint", 0
    , "uint", 0
    , "uint", &output_actual
    , "uint", 0 )
}

CTL_CODE_LED(p_device_type,p_function,p_method,p_access ){
  Return, ( p_device_type << 16 ) | ( p_access << 14 ) | ( p_function << 2 ) | p_method
}

NtCreateFileLED(ByRef wfilename,desiredaccess,sharemode,createdist,flags,fattribs){ 
  VarSetCapacity(fh,4,0) 
  VarSetCapacity(objattrib,24,0) 
  VarSetCapacity(io,8,0) 
  VarSetCapacity(pus,8) 
  uslen:=DllCall("lstrlenW","str",wfilename)*2 
  InsertIntegerLED(uslen,pus,0,2) 
  InsertIntegerLED(uslen,pus,2,2) 
  InsertIntegerLED(&wfilename,pus,4) 
  InsertIntegerLED(24,objattrib,0) 
  InsertIntegerLED(&pus,objattrib,8) 
  status:=DllCall("ntdll\ZwCreateFile","str",fh,"UInt",desiredaccess,"str",objattrib,"str",io,"UInt",0,"UInt",fattribs
                  ,"UInt",sharemode,"UInt",createdist,"UInt",flags,"UInt",0,"UInt",0, "UInt") 
  return ExtractIntegerLED(fh) 
} 

SetUnicodeStrLED(ByRef out, str_){ 
  VarSetCapacity(st1, 8, 0) 
  InsertIntegerLED(0x530025, st1) 
  VarSetCapacity(out, (StrLen(str_)+1)*2, 0) 
  DllCall("wsprintfW", "str", out, "str", st1, "str", str_, "Cdecl UInt") 
} 

ExtractIntegerLED(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4){
; pSource is a string (buffer) whose memory area contains a raw/binary integer at pOffset. 
; The caller should pass true for pSigned to interpret the result as signed vs. unsigned. 
; pSize is the size of PSource's integer in bytes (e.g. 4 bytes for a DWORD or Int). 
; pSource must be ByRef to avoid corruption during the formal-to-actual copying process 
; (since pSource might contain valid data beyond its first binary zero). 
  Loop %pSize%  ; Build the integer by adding up its bytes. 
    result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1) 
  if (!pIsSigned OR pSize > 4 OR result < 0x80000000) 
    return result  ; Signed vs. unsigned doesn't matter in these cases. 
  ; Otherwise, convert the value (now known to be 32-bit) to its signed counterpart: 
  return -(0xFFFFFFFF - result + 1) 
} 

InsertIntegerLED(pInteger, ByRef pDest, pOffset = 0, pSize = 4){ 
; The caller must ensure that pDest has sufficient capacity.  To preserve any existing contents in pDest, 
; only pSize number of bytes starting at pOffset are altered in it. 
  Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data. 
    DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF) 
}

/*
   ------------------------------------------------------
   Methoden zum Senden von Unicode-Zeichen
   ------------------------------------------------------

Über den GTK-Workaround:
Dieser basiert auf http://www.autohotkey.com/forum/topic32947.html
Der Aufruf von »SubStr(charCode,3)« geht davon aus, dass alle charCodes in Hex mit führendem „0x“ angegeben sind. Die abenteuerliche „^+u“-Konstruktion benötigt im Übrigen den Hex-Wert in Kleinschrift, was derzeit nicht bei den Zeichendefinitionen umgesetzt ist, daher zentral und weniger fehlerträchtig an dieser Stelle. Außerdem ein abschließend gesendetes Space, sonst bleibt der „eingetippte“ Unicode-Wert noch kurz sichtbar stehen, bevor er sich GTK-sei-dank in das gewünschte Zeichen verwandelt.
*/

SendUnicodeChar(charCode){
  IfWinActive,ahk_class gdkWindowToplevel
  {
    StringLower,charCode,charCode
    send % "^+u" . SubStr(charCode,3) . " "
  }else{
    VarSetCapacity(ki,28*2,0)
    EncodeInteger(&ki+0,1)
    EncodeInteger(&ki+6,charCode)
    EncodeInteger(&ki+8,4)
    EncodeInteger(&ki+28,1)
    EncodeInteger(&ki+34,charCode)
    EncodeInteger(&ki+36,4|2)
    DllCall("SendInput","UInt",2,"UInt",&ki,"Int",28)
  }
}

SendUnicodeCharDown(charCode){
  IfWinActive,ahk_class gdkWindowToplevel
  {
    StringLower,charCode,charCode
    send % "^+u" . SubStr(charCode,3) . " "
  }else{
    VarSetCapacity(ki,28,0)
    EncodeInteger(&ki+0,1)
    EncodeInteger(&ki+6,charCode)
    EncodeInteger(&ki+8,4)

    DllCall("SendInput","UInt",1,"UInt",&ki,"Int",28)
  }
}

SendUnicodeCharUp(charCode){
  IfWinActive,ahk_class gdkWindowToplevel
  {
    ; nothing
  }else{
    VarSetCapacity(ki,28,0)
    EncodeInteger(&ki+0,1)
    EncodeInteger(&ki+6,charCode)
    EncodeInteger(&ki+8,4|2)

    DllCall("SendInput","UInt",1,"UInt",&ki,"Int",28)
  }
}

EncodeInteger(ref,val){
  DllCall("ntdll\RtlFillMemoryUlong","Uint",ref,"Uint",4,"Uint",val)
}

/**********************
* Tastenkombinationen *
***********************
*/


+pause::
Suspend, Permit
  goto togglesuspend

/*****************
* Menüfunktionen *
******************
*/
togglesuspend:
  if A_IsSuspended {
    menu, tray, rename, %enable%, %disable%
    menu, tray, tip, %name%
    if (iconBenutzen)
      menu, tray, icon, %ResourceFolder%\neo_enabled.ico,,1
    suspend , off ; Schaltet Suspend aus -> NEO
  } else {
    menu, tray, rename, %disable%, %enable%
    menu, tray, tip, %name% : Deaktiviert
    if (iconBenutzen)
      menu, tray, icon, %ResourceFolder%\neo_disabled.ico,,1
    suspend , on  ; Schaltet Suspend ein -> QWERTZ
  }
return

help:
  Run, %A_WinDir%\hh mk:@MSITStore:autohotkey.chm
return

about:
  msgbox, 64, %name% – Ergonomische Tastaturbelegung, 
  (
  %name% 
  `nDas Neo-Layout ersetzt das übliche deutsche 
  Tastaturlayout mit der Alternative Neo, 
  beschrieben auf http://neo-layout.org/. 
  `nDazu sind keine Administratorrechte nötig. 
  `nWenn Autohotkey aktiviert ist, werden alle Tastendrucke 
  abgefangen und statt dessen eine Übersetzung weitergeschickt. 
  `nDies geschieht transparent für den Anwender, 
  es muss nichts installiert werden. 
  `nDie Zeichenübersetzung kann leicht über das Icon im 
  Systemtray deaktiviert werden.  `n
  )
return

neo:
  run http://neo-layout.org/
return

autohotkey:
  run http://autohotkey.com/
return

open:
  ListLines ; shows the Autohotkey window
return

edit:
  edit
return

reload:
  Reload
return

hide:
  menu, tray, noicon
return

exitprogram:
  exitapp
return

/**************************
* lernModus Konfiguration *
* nur relevant wenn       *
* lernModus = 1           *
* Strg+Komma schaltet um  *
***************************
*/
^,::lernModus := not(lernModus)

; 0 = aus, 1 = an

; LShift+RShift == CapsLock (simuliert)
; Es werden nur die beiden Tastenkombinationen abgefragt,
; daher kommen LShift und RShift ungehindert bis in die
; Applikation. Dies ist aber merkwürdig, da beide Shift-
; Tasten nun /modifier keys/ werden und, wie in der AHK-
; Hilfe beschrieben, eigentlich nicht mehr bis zur App
; durchkommen sollten.
; KeyboardLED(4,"switch") hatte ich zuerst genommen, aber
; das schaltet, oh Wunder, die LED nicht wieder aus.

~*VKA1SC136::
  if (isShiftLPressed and !isShiftRPressed)
    ToggleMod2Lock()
  isShiftRPressed := 1
  isShiftPressed := 1
return

~*VKA1SC136 up::
  isShiftRPressed := 0
  isShiftPressed := isShiftLPressed
return

~*VKA0SC02A::
  if (isShiftRPressed and !isShiftLPressed)
    ToggleMod2Lock()
  isShiftLPressed := 1
  isShiftPressed := 1
return

~*VKA0SC02A up::
  isShiftLPressed := 0
  isShiftPressed := isShiftRPressed
return

ToggleMod2Lock() {
  global
  if (isMod2Locked)
  {
    isMod2Locked := 0
    KeyboardLED(4,"off")
  }
  else
  {
    isMod2Locked := 1
    KeyBoardLED(4,"on")
  }
}


*VKBFSC02B::
  if (isMod3LPressed and !isMod3RPressed)
    CharStarDown("MOD3", "MOD3", "SComp")
  isMod3RPressed := 1
  isMod3Pressed := 1
return

*VKBFSC02B up::
  if (isMod3LPressed)
    CharStarUp("MOD3")
  isMod3RPressed := 0
  isMod3Pressed := isMod3LPressed
return

*VK14SC03A::
  if (isMod3RPressed and !isMod3LPressed)
    CharStarDown("MOD3", "MOD3", "SComp")
  isMod3LPressed := 1
  isMod3Pressed := 1
return

*VK14SC03A up::
  if (isMod3RPressed)
    CharStarUp("MOD3")
  isMod3LPressed := 0
  isMod3Pressed := isMod3RPressed
return

;Mod4+Mod4 == Mod4-Lock
; Im Gegensatz zu LShift+RShift werden die beiden Tasten
; _nicht_ zur Applikation weitergeleitet, und nur bei
; gleichzeitigem Drücken wird der Mod4-Lock aktiviert und
; angezeigt.

*VKA5SC138::
  wasMod4RPressed := isMod4RPressed
  isMod4RPressed := 1
  isMod4Pressed := 1
  if (isMod4LPressed and !wasMod4RPressed)
    ToggleMod4Lock()
return

*VKA5SC138 up::
  isMod4RPressed := 0
  isMod4Pressed := isMod4LPressed
return

*VKE2SC056::
  wasMod4LPressed := isMod4LPressed
  isMod4LPressed := 1
  isMod4Pressed := 1
  if (isMod4RPressed and !wasMod4LPressed)
    ToggleMod4Lock()
return

*VKE2SC056 up::
  isMod4LPressed := 0
  isMod4Pressed := isMod4RPressed
return

ToggleMod4Lock() {
  global
  if (IsMod4Locked) {
    IsMod4Locked := 0
    if (UseMod4Light)
      KeyboardLED(1,"off")
    if (zeigeLockBox)
      MsgBox Mod4-Feststellung aufgehoben!
  } else {
    IsMod4Locked := 1
    if (UseMod4Light)
      KeyboardLED(1,"on")
    if (zeigeLockBox)
      MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen, drücke beide Mod4-Tasten gleichzeitig!
  }
}

/*
   ------------------------------------------------------
   BildschirmTastatur
   ------------------------------------------------------
*/

F1::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Switch1
  else send {blind}{F1}
return

F2::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Switch2
  else send {blind}{F2}
return

F3::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Switch3
  else send {blind}{F3}
return

F4::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Switch4
  else send {blind}{F4}
return

F5::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Switch5
  else send {blind}{F5}
return

F6::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Switch6
  else send {blind}{F6}
return

F7::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto Show
  else send {blind}{F7}
return

F8::
  if(isMod4Active() && zeigeBildschirmTastatur)
    goto ToggleAlwaysOnTop
  else send {blind}{F8}
return

Switch1:
  tImage := ResourceFolder . "\ebene1.png"
  goto Switch
Return

Switch2:
  tImage := ResourceFolder . "\ebene2.png"
  goto Switch
Return

Switch3:
  tImage := ResourceFolder . "\ebene3.png"
  goto Switch
Return

Switch4:
  tImage := ResourceFolder . "\ebene4.png"
  goto Switch
Return

Switch5:
  tImage := ResourceFolder . "\ebene5.png"
  goto Switch
Return

Switch6:
  tImage := ResourceFolder . "\ebene6.png"
  goto Switch
Return

Switch:
  if (guiErstellt) 
  {
     if (Image = tImage)
        goto Close
     else
     {
       Image := tImage
       SetTimer, Refresh
     }
  }
  else 
  {
    Image := tImage
    goto Show    
  }
Return

Show:
  if (guiErstellt) 
  {
     goto Close
  }
  else
  {
    if (Image = "") 
    {
      Image := ResourceFolder . "\ebene1.png"
    }     
    yPosition := A_ScreenHeight -270
    Gui, Color, FFFFFF
    Gui, Add, Button, xm+5 gSwitch1, F1
    Gui, Add, Text, x+5, kleine Buchstaben
    Gui, Add, Button, xm+5 gSwitch2, F2
    Gui, Add, Text, x+5, große Buchstaben
    Gui, Add, Button, xm+5 gSwitch3, F3
    Gui, Add, Text, x+5, Satz-/Sonderzeichen
    Gui, Add, Button, xm+5 gSwitch4, F4
    Gui, Add, Text, x+5, Zahlen / Steuerung
    Gui, Add, Button, xm+5 gSwitch5, F5
    Gui, Add, Text, x+5, Sprachen
    Gui, Add, Button, xm+5 gSwitch6, F6
    Gui, Add, Text, x+5, Mathesymbole
    Gui, Add, Button, xm+5 gShow, F7
    Gui, Add, Text, x+5, An /
    Gui, Add, Text, y+3, Aus
    Gui, Add, Button, x+10 y+-30 gShow, F8
    Gui, Add, Text, x+5, OnTop
    Gui, Add, Picture,AltSubmit ys w564 h200 vPicture, %Image%
    Gui, +AlwaysOnTop
    Gui, Show, y%yposition% Autosize
;    SetTimer, Refresh
    guiErstellt = 1
  } 
Return

Close:
  guiErstellt = 0
  Gui, Destroy
Return

Refresh:
   If (Image != OldImage)
   {
      GuiControl, , Picture, %Image%
      OldImage := Image
   }
Return

ToggleAlwaysOnTop:
    if (alwaysOnTop)
    {
      Gui, -AlwaysOnTop
      alwaysOnTop = 0    
    }
    else
    {
      Gui, +AlwaysOnTop
      alwaysOnTop = 1
    }
Return
