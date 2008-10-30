/*
*******************************************
WICHTIGE WARNUNG:

Dies ist inzwischen eine automatisch generierte
Datei! Sie wird regelmäßig überschrieben und
sollte deshalb nicht mehr direkt bearbeitet werden!

Alle weiterführenden Informationen finden sich im Abschnitt 
== Hinweise für Entwickler ==
in der Datei README.txt!

Versionshinweise (SVN Keywords) für diese Datei:
$LastChangedRevision$
$LastChangedDate$
$LastChangedBy$
$HeadURL$
*******************************************




















*******************************************
Das war die letzte WARNUNG, ich hoffe nur, dass
Sie wirklich wissen, was Sie hier tun wollen ...
*******************************************
*/


/******************
* Initialisierung *
*******************
*/
DeadKey := ""
CompKey := ""
PriorDeadKey := ""
PriorCompKey := ""
Ebene12 = 0
noCaps = 0
isFurtherCompkey = 0

EbeneAktualisieren()
SetBatchLines -1
SetCapsLockState Off
KeyboardLED(4, "off")
SetNumLockState Off
SetScrollLockState Off

name=Neo 2.0 (%A_ScriptName%) ($Revision$)
enable=Aktiviere %name%
disable=Deaktiviere %name%
#usehook on
#singleinstance force
#LTrim ; Quelltext kann eingerückt werden
Process,Priority,,High
SendMode Input  

/****************
* Verzeichnisse *
*****************
*/
; Setzt den Pfad zu einem temporären Verzeichnis
EnvGet,WindowsEnvTempFolder,TEMP
ResourceFolder = %WindowsEnvTempFolder%\NEO2
FileCreateDir,%ResourceFolder%

; Setzt den Pfad zu den NEO-Anwendungsdateien
EnvGet,WindowsEnvAppDataFolder,APPDATA
ApplicationFolder = %WindowsEnvAppDataFolder%\NEO2
FileCreateDir,%ApplicationFolder%
ini = %ApplicationFolder%\NEO2.ini

/*******************
* Globale Schalter *
********************
*/
; Im folgenden gilt (soweit nicht anders angegeben) Ja = 1, Nein = 0:

; Sollen die Bilder für die Bildschirmtastatur in die compilierte EXE-Datei miteingebunden werden? 
; (Nachteil: grössere Dateigrösse, Vorteil: Referenz für Anfänger stets einfach verfügbar)
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
  KeyboardLED(2,"on")

; Sollen tote Tasten blind angezeigt werden?
IniRead,DeadSilence,%ini%,Global,DeadSilence,1

;Sollen Compose-Tasten blind angezeigt werden?
IniRead,DeadCompose,%ini%,Global,DeadCompose,1

;Soll der Mod2Lock auch auf die Akzente, die Ziffernreihe und das Numpad angewandt werden?
IniRead,striktesMod2Lock,%ini%,Global,striktesMod2Lock,0

/***********************
* Recourcen-Verwaltung *
************************
*/
if (FileExist("ResourceFolder") <> false) {
  ; Versuche, alle möglicherweise in die EXE eingebundenen Dateien zu extrahieren 
  FileInstall,neo.ico,%ResourceFolder%\neo.ico,1
  FileInstall,neo_disabled.ico,%ResourceFolder%\neo_disabled.ico,1
  iconBenutzen=1
  if (bildschirmTastaturEinbinden = 1) {
    FileInstall,ebene1.png,%ResourceFolder%\ebene1.png,1
    FileInstall,ebene2.png,%ResourceFolder%\ebene2.png,1
    FileInstall,ebene3.png,%ResourceFolder%\ebene3.png,1
    FileInstall,ebene4.png,%ResourceFolder%\ebene4.png,1
    FileInstall,ebene5.png,%ResourceFolder%\ebene5.png,1
    FileInstall,ebene6.png,%ResourceFolder%\ebene6.png,1
    zeigeBildschirmTastatur = 1
  }
}

; Benutze die Dateien auch dann, wenn sie eventuell im aktuellen Verzeichnis vorhanden sind 
if (FileExist("ebene1.png")&&FileExist("ebene2.png")&&FileExist("ebene3.png")&&FileExist("ebene4.png")&&FileExist("ebene5.png")&&FileExist("ebene6.png"))
  zeigeBildschirmTastatur = 1
if (FileExist("neo.ico")&&FileExist("neo_disabled.ico"))
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
  menu,tray,icon,%ResourceFolder%\neo.ico,,1
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
menu,tray,add,%name% beenden,exitprogram
menu,tray,default,%disable%
menu,tray,tip,%name%

/**************************
* lernModus Konfiguration *
* nur relevant wenn       *
* lernModus = 1           *
* Strg+Komma schaltet um  *
***************************
*/
; 0 = aus, 1 = an

; die Nachfolgenden sind nützlich um sich die Qwertz-Tasten abzugewöhnen, da alle auf der 4. Ebene vorhanden.
lernModus_std_Return = 0
lernModus_std_Backspace = 0
lernModus_std_PgUp = 0
lernModus_std_PgDn = 0
lernModus_std_Einf = 0
lernModus_std_Entf = 0
lernModus_std_Pos0 = 0
lernModus_std_Ende = 0
lernModus_std_Hoch = 0
lernModus_std_Runter = 0
lernModus_std_Links = 0
lernModus_std_Rechts = 0
lernModus_std_ZahlenReihe = 0

; im folgenden kann man auch noch ein paar Tasten der 4. Ebene deaktivieren
; nützlich um sich zu zwingen, richtig zu schreiben
lernModus_neo_Backspace = 0
lernModus_neo_Entf = 1

/****************************
* EinHandNeo                *
* Umschalten mit Strg+Punkt *
*****************************
*/
spacepressed := 0
keypressed := 0

; Reihe 1
gespiegelt_7 = neo_6
gespiegelt_8 = neo_5
gespiegelt_9 = neo_4
gespiegelt_0 = neo_3
gespiegelt_strich = neo_2
gespiegelt_tot2 = neo_1

; Reihe 2
gespiegelt_k = neo_w
gespiegelt_h = neo_c
gespiegelt_g = neo_l
gespiegelt_f = neo_v
gespiegelt_q = neo_x
gespiegelt_sz = neo_tab 
gespiegelt_tot3 = neo_tot1

; Reihe 3
gespiegelt_s = neo_o
gespiegelt_n = neo_e
gespiegelt_r = neo_a
gespiegelt_t = neo_i
gespiegelt_d = neo_u

; Reihe 4
gespiegelt_b = neo_z
gespiegelt_m = neo_p
gespiegelt_komma = neo_ä
gespiegelt_punkt = neo_ö
gespiegelt_j = neo_ü

/**********************
* Tastenkombinationen *
***********************
*/
;Blinde/Sichtbare Tote Tasten
*F9::
  if isMod4pressed()
    DeadSilence := !DeadSilence
  else send {blind}{F9}
return

;Blinde/Sichtbare Compose
*F10::
  if isMod4pressed()
    DeadCompose := !DeadCompose
  else send {blind}{F10}
return

;Lang-s-Tastatur:
*F11::
  if isMod4pressed() {
    LangSTastatur := !LangSTastatur
    if LangSTastatur
      KeyboardLED(2,"on")
    else KeyboardLED(2,"off")
  } else send {blind}{F11}
return

;Alle Modi und Locks in den Normalzustand versetzen, bzw. Skript neu laden:
*Esc::
  if isMod4pressed()
    reload
  else send {blind}{Esc}
return

*pause::
Suspend, Permit
  if isShiftpressed()
    goto togglesuspend
  else send {blind}{pause}
return

^,::lernModus := !lernModus

^.::einHandNeo := !einHandNeo

/*****************
* Menüfunktionen *
******************
*/
togglesuspend:
  if A_IsSuspended {
    menu,tray,rename,%enable%,%disable%
    menu,tray,tip,%name%
    if (iconBenutzen)
      menu,tray,icon,%ResourceFolder%\neo.ico,,1
    suspend,off ; Schaltet Suspend aus -> NEO
  } else {
    menu,tray,rename,%disable%, %enable%
    menu,tray,tip,%name% : Deaktiviert
    if (iconBenutzen)
      menu,tray,icon, %ResourceFolder%\neo_disabled.ico,,1
    suspend,on ; Schaltet Suspend ein -> QWERTZ
  } return

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


; LShift+RShift == CapsLock (simuliert)
; Es werden nur die beiden Tastenkombinationen abgefragt,
; daher kommen LShift und RShift ungehindert bis in die
; Applikation. Dies ist aber merkwürdig, da beide Shift-
; Tasten nun /modifier keys/ werden und, wie in der AHK-
; Hilfe beschrieben, eigentlich nicht mehr bis zur App
; durchkommen sollten.
; KeyboardLED(4,"switch") hatte ich zuerst genommen, aber
; das schaltet, oh Wunder, die LED nicht wieder aus.

isMod2Locked = 0
VKA1SC136 & VKA0SC02A:: ; RShift, dann LShift
VKA0SC02A & VKA1SC136:: ; LShift, dann RShift
  if GetKeyState("VKA1SC136", "P") and GetKeyState("VKA0SC02A", "P") {
    if isMod2Locked {
      isMod2Locked = 0
      KeyboardLED(4, "off")
    } else {
      isMod2Locked = 1
      KeyBoardLED(4, "on")
    }
  }
return

;Mod3-Tasten (Wichtig, sie werden sonst nicht verarbeitet!)
;Auf Mod3+Mod3 liegt zusätzlich zu Mod3+Tab Compose
*VKBFSC02B:: ; #
*VK14SC03A:: ; CapsLock
  if GetKeyState("VKBFSC02B", "P") and GetKeyState("VK14SC03A", "P") {
    DeadKey := "comp"
    CompKey := ""
  }
return

;Mod4+Mod4 == Mod4-Lock
; Im Gegensatz zu LShift+RShift werden die beiden Tasten
; _nicht_ zur Applikation weitergeleitet, und nur bei
; gleichzeitigem Drücken wird der Mod4-Lock aktiviert und
; angezeigt.

IsMod4Locked := 0
*VKA5SC138::
*VKE2SC056::
  if GetKeyState("VKA5SC138", "P") and GetKeyState("VKE2SC056", "P") {
    if IsMod4Locked {
      if zeigeLockBox
        MsgBox Mod4-Feststellung aufgebehoben!
       IsMod4Locked = 0
      if UseMod4Light
        KeyboardLED(1, "off")
    } else {
      if zeigeLockBox
        MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen, drücke beide Mod4-Tasten gleichzeitig!
      IsMod4Locked = 1
      if UseMod4Light
        KeyboardLED(1, "on")
    }
  }
return

EbeneAktualisieren() {
  global
  PriorDeadKey := DeadKey
  PriorCompKey := CompKey
  DeadKey := ""
  CompKey := ""
  Modstate := IsMod4Pressed() . IsMod3Pressed() . IsShiftPressed()
  Ebene7 := 0
  Ebene8 := 0
  if      (Modstate = "000") ; Ebene 1: Ohne Mod
    Ebene = 1
  else if (Modstate = "001") ; Ebene 2: Shift
    Ebene = 2
  else if (Modstate = "010") ; Ebene 3: Mod3
    Ebene = 3
  else if (Modstate = "100") ; Ebene 4: Mod4
    Ebene = 4
  else if (Modstate = "011") ; Ebene 5: Shift+Mod3
    Ebene = 5
  else if (Modstate = "110") ; Ebene 6: Mod3+Mod4
    Ebene = 6
  else if (Modstate = "101") { ; Ebene 7: Shift+Mod4 impliziert Ebene 4
    Ebene = 4
    Ebene7 = 1
  } else if (Modstate = "111") { ; Ebene 8: Shift+Mod3+Mod4 impliziert Ebene 6
    Ebene = 6
    Ebene8 = 1
  } Ebene12 := ((Ebene = 1) or (Ebene = 2))
  NumLock := GetKeyState("NumLock", "T")
  noCaps := 0
}

IsShiftPressed()
{
  global
  if !(NoCaps and GetKeyState("Shift", "P") and (GetKeyState("Alt", "P") or GetKeyState("Strg", "P"))) {
    if striktesMod2Lock
      noCaps = 0
    if GetKeyState("Shift","P")
      if isMod2Locked and !noCaps
        return 0
      else return 1
    else if isMod2Locked and !noCaps
      return 1
    else return 0
  }
}

IsMod3Pressed()
{
  global
  return (GetKeyState("VKBFSC02B","P") or GetKeyState("VK14SC03A","P"))
}

IsMod4Pressed()
{
  global
  if !(einHandNeo) or !(spacepressed)
    if IsMod4Locked
      return !(GetKeyState("<","P") or GetKeyState("SC138","P"))
    else
      return (GetKeyState("<","P") or GetKeyState("SC138","P"))
  else
    if IsMod4Locked
      return !(GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P"))
    else
      return (GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P"))
}



/*
   ------------------------------------------------------
   QWERTZ->Neo umwandlung
   ------------------------------------------------------
*/

; Reihe 1
*VKDCSC029::goto neo_tot1 ; Zirkumflex
*VK31SC002::goto neo_1
*VK32SC003::goto neo_2
*VK33SC004::goto neo_3
*VK34SC005::goto neo_4
*VK35SC006::goto neo_5
*VK36SC007::goto neo_6
*VK37SC008::
  if !einHandNeo or !spacepressed
    goto neo_7
  else {
    keypressed := 1
    goto %gespiegelt_7%
  }
*VK38SC009::
  if !einHandNeo or !spacepressed
    goto neo_8
  else {
    keypressed := 1
    goto %gespiegelt_8%
  }
*VK39SC00A::
  if !einHandNeo or !spacepressed
    goto neo_9
  else {
    keypressed := 1
    goto %gespiegelt_9%
  }
*VK30SC00B::
  if !einHandNeo or !spacepressed
    goto neo_0
  else {
    keypressed := 1
    goto %gespiegelt_0%
  }
*VKDBSC00C:: ; ß
  if !einHandNeo or !spacepressed
    goto neo_strich
  else {
    keypressed := 1
    goto %gespiegelt_strich%
  }
*VKDDSC00D::goto neo_tot2 ; Akut

; Reihe 2

VK09SC00F::goto neo_tab
*VK51SC010:: ; q (x)
  goto neo_x
*VK57SC011:: ; w (v)
  goto neo_v
*VK45SC012:: ; e (l)
  goto neo_l
*VK52SC013:: ; r (c)
  goto neo_c
*VK54SC014:: ; t (w)
  goto neo_w
*VK5ASC015:: ; z (k) 
  if !einHandNeo or !spacepressed
    goto neo_k
  else {
    keypressed := 1
    goto %gespiegelt_k%
  }
*VK55SC016:: ; u (h)
  if !einHandNeo or !spacepressed
    goto neo_h
  else {
    keypressed := 1
    goto %gespiegelt_h%
  }
*VK49SC017:: ; i (g)
  if !einHandNeo or !spacepressed
    goto neo_g
  else {
    keypressed := 1
    goto %gespiegelt_g%
  }
*VK4FSC018:: ; o (f)
  if !einHandNeo or !spacepressed
    goto neo_f
  else {
    keypressed := 1
    goto %gespiegelt_f%
  }
*VK50SC019:: ; p (q)
  if !einHandNeo or !spacepressed
    goto neo_q
  else {
    keypressed := 1
    goto %gespiegelt_q%
  }
*VKBASC01A:: ; ü (ß)
  if !einHandNeo or !spacepressed
    goto neo_sz
  else {
    keypressed := 1
    goto %gespiegelt_sz%
  }
*VKBBSC01B:: ; + (tot3)
  if !einHandNeo or !spacepressed
    goto neo_tot3
  else {
    keypressed := 1
    goto %gespiegelt_tot3%
  }

; Reihe 3
*VK41SC01E:: ; a (u)
  goto neo_u
*VK53SC01F:: ; s (i)
  goto neo_i
*VK44SC020:: ; d (a)
  goto neo_a
*VK46SC021:: ; f (e)
  goto neo_e
*VK47SC022:: ; g (o)
  goto neo_o
*VK48SC023:: ; h (s)
  if !einHandNeo or !spacepressed
    goto neo_s
  else {
    keypressed := 1
    goto %gespiegelt_s%
  }
*VK4ASC024:: ; j (n)
  if !einHandNeo or !spacepressed
    goto neo_n
  else {
    keypressed := 1
    goto %gespiegelt_n%
  }
*VK4BSC025:: ; k (r)
  if !einHandNeo or !spacepressed
    goto neo_r
  else {
    keypressed := 1
    goto %gespiegelt_r%
  }
*VK4CSC026:: ; l (t)
  if !einHandNeo or !spacepressed
    goto neo_t
  else {
    keypressed := 1
    goto %gespiegelt_t%
  }
*VKC0SC027:: ; ö (d)
  if !einHandNeo or !spacepressed
    goto neo_d
  else {
    keypressed := 1
    goto %gespiegelt_d%
  }
*VKDESC028:: ; ä (y)
    goto neo_y

; Reihe 4
*VK59SC02C:: ; y (ü)
  goto neo_ü
*VK58SC02D:: ; x (ö)
  goto neo_ö
*VK43SC02E:: ; c (ä)  
  goto neo_ä
*VK56SC02F:: ; v (p)
  goto neo_p
*VK42SC030:: ; b (z)
  goto neo_z
*VK4ESC031:: ; n (b)
  if !einHandNeo or !spacepressed
    goto neo_b
  else {
    keypressed := 1
    goto %gespiegelt_b%
  }
*VK4DSC032:: ; m (m)
  if !einHandNeo or !spacepressed
    goto neo_m
  else {
    keypressed := 1
    goto %gespiegelt_m%
  }
*VKBCSC033:: ; , (,)
  if !einHandNeo or !spacepressed
    goto neo_komma
  else {
    keypressed := 1
    goto %gespiegelt_komma%
  }
*VKBESC034:: ; . (.)
  if !einHandNeo or !spacepressed
    goto neo_punkt
  else {
    keypressed := 1
    goto %gespiegelt_punkt%
  }
*VKBDSC035:: ; - (j)
  if !einHandNeo or !spacepressed
    goto neo_j
  else {
    keypressed := 1
    goto %gespiegelt_j%
  }

; Numpad
*VK90SC145::goto neo_NumLock
*VK6FSC135::goto neo_NumpadDiv
*VK6ASC037::goto neo_NumpadMult
*VK6DSC04A::goto neo_NumpadSub
*VK6BSC04E::goto neo_NumpadAdd
*VK0DSC11C::goto neo_NumpadEnter
*VK67SC047::                   ; NumPad7
*VK24SC047::goto neo_Numpad7   ; NumPadHome
*VK68SC048::                   ; NumPad8
*VK26SC048::goto neo_Numpad8   ; NumPadUp
*VK69SC049::                   ; NumPad9
*VK21SC049::goto neo_Numpad9   ; NumPadPgUp
*VK64SC04B::                   ; NumPad4
*VK25SC04B::goto neo_Numpad4   ; NumPadLeft
*VK65SC04C::                   ; NumPad5
*VK0CSC04C::goto neo_Numpad5   ; NumPadClear
*VK66SC04D::                   ; NumPad6
*VK27SC04D::goto neo_Numpad6   ; NumPadRight
*VK61SC04F::                   ; NumPad1
*VK23SC04F::goto neo_Numpad1   ; NumPadEnd
*VK62SC050::                   ; NumPad2
*VK28SC050::goto neo_Numpad2   ; NumPadDown
*VK63SC051::                   ; NumPad3
*VK22SC051::goto neo_Numpad3   ; NumPadPgDn
*VK60SC052::                   ; NumPad0
*VK2DSC052::goto neo_Numpad0   ; NumPadIns
*VK6ESC053::                   ; NumPadDot
*VK2ESC053::goto neo_NumpadDot ; NumPadIns


neo_a:
  EbeneAktualisieren()
  if (((Ebene = 2) and !(CheckDeadUni("a5g1",0x1F02)
                      or CheckDeadUni("g5g1",0x1F03)))
       or (Ebene12 and !(CheckDeadUni12("c1",0x00E2,0x00C2)
                      or CheckDeadUni12("c2",0x00E3,0x00C3)
                      or CheckDeadAsc12("c3","å","Å")
                      or CheckDeadUni12("c4",0x01CE,0x01CD)
                      or CheckDeadUni12("c5",0x0103,0x0102)
                      or CheckDeadUni12("c6",0x0101,0x0100)
                      or CheckDeadUni12("g1",0x00E0,0x00C0)
                      or CheckDeadAsc12("g3","ä","Ä")
                      or CheckDeadUni12("g4",0x0201,0x0200)
                      or CheckDeadUni12("a1",0x00E1,0x00C1)
                      or CheckDeadUni12("a2",0x0105,0x0104)
                      or CheckDeadUni12("a3",0x2C65,0x023A)
                      or CheckDeadUni12("a6",0x0227,0x0226))))
    OutputChar12("a","A","a","A")
  else if (Ebene = 3)
    OutputChar("{{}", "braceleft")
  else if (Ebene = 4)
    OutputChar("{Down}", "Down")
  else if (Ebene = 5 and !(CheckDeadUni("c1",0x1FB6)
                        or CheckDeadUni("c5",0x1FB0)
                        or CheckDeadUni("c6",0x1FB1)
                        or CheckDeadUni("g1",0x1F70)
                        or CheckDeadUni("g5",0x1F01)
                        or CheckDeadUni("a1",0x03AC)
                        or CheckDeadUni("a2",0x1FB3)
                        or CheckDeadUni("a5",0x1F00)))
    SendUnicodeChar(0x03B1, "Greek_alpha") ; alpha
  else if (Ebene = 6)
    SendUnicodeChar(0x2200, "U2200") ; für alle
return

neo_b:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c6",0x1E07,0x1E06)
                 or CheckDeadUni12("a6",0x1E03,0x1E02)))
    OutputChar12("b","B","b","B")
  else if (Ebene = 3)
    if isMod2Locked
      OutputChar("{Shift Up}{+}{Shift down}", "plus")
    else OutputChar("{blind}{+}", "plus")
  else if (Ebene = 4)
    OutputChar(":", "colon")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B2, "Greek_beta") ; beta
  else if (Ebene = 6)
    SendUnicodeChar(0x21D0, "U21D0") ; Doppelpfeil links
return

neo_c:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0109,0x0108)
                 or CheckDeadUni12("c4",0x010D,0x010C)
                 or CheckDeadUni12("a1",0x0107,0x0106)
                 or CheckDeadUni12("a2",0x00E7,0x00E6)
                 or CheckDeadUni12("a6",0x010B,0x010A)))
    OutputChar12("c","C","c","C")
  else if (Ebene = 3)
    OutputChar("]", "bracketright")
  else if (Ebene = 4) and (!lernModus or lernModus_neo_Entf)
    OutputChar("{Del}", "Delete")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C7, "Greek_chi") ; chi
  else if (Ebene = 6)
    SendUnicodeChar(0x2102, "U2102") ; C (Komplexe Zahlen)]
return

neo_d:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("c1",0x1E13,0x1E12)
                  or CheckDeadUni(  "c2",0x1D6D)
                  or CheckDeadUni12("c4",0x010F,0x010E)
                  or CheckDeadUni12("g3",0x1E0D,0x1E0C)
                  or CheckDeadUni12("a1",0x00F0,0x00D0)
                  or CheckDeadUni12("a2",0x1E11,0x1E10)
                  or CheckDeadUni12("a3",0x0111,0x0110)
                  or CheckDeadUni12("a6",0x1E0B,0x1E0A)))
     OutputChar12("d","D","d","D")
   else if (Ebene = 3)
     OutputChar(":", "colon")
   else if (Ebene = 4)
     OutputChar("{NumpadDot}", "comma")
   else if (Ebene = 5)
      SendUnicodeChar(0x03B4, "Greek_delta") ; delta
   else if (Ebene = 6)
      SendUnicodeChar(0x0394, "Greek_DELTA") ; Delta
return

neo_e:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x00EA,0x00CA)
                 or CheckDeadUni12("c2",0x1EBD,0x1EBC)
                 or CheckDeadUni12("c4",0x011B,0x011A)
                 or CheckDeadUni12("c5",0x0115,0x0114)
                 or CheckDeadUni12("c6",0x0113,0x0112)
                 or CheckDeadUni12("g1",0x00E8,0x00C8)
                 or CheckDeadAsc12("g3","ë","Ë")
                 or CheckDeadUni12("g4",0x0205,0x0204)
                 or CheckDeadUni12("a1",0x00E9,0x00C9)
                 or CheckDeadUni12("a2",0x0119,0x0118)
                 or CheckDeadUni12("a6",0x0117,0x0116)))
    OutputChar12("e","E","e","E")
  else if (Ebene = 3)
    OutputChar("{}}", "braceright")
  else if (Ebene = 4)
    OutputChar("{Right}", "Right")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B5, "Greek_epsilon") ; epsilon
  else if (Ebene = 6)
    SendUnicodeChar(0x2203, "U2203") ; es existiert
return

neo_f:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a6",0x1E1F,0x1E1E)))
    OutputChar12("f","F","f","F")
  else if ((Ebene = 3) and !(CheckDeadUni("c1",0x2259) ; entspricht
                          or CheckDeadUni("c2",0x2245) ; ungefähr gleich
                          or CheckDeadUni("c3",0x2257) ; ring equal to
                          or CheckDeadUni("c4",0x225A) ; EQUIANGULAR TO
                          or CheckDeadUni("c6",0x2261) ; identisch
                          or CheckDeadUni("a3",0x2260))) ; ungleich
    OutputChar("`=", "equal")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2079)
                          or CheckDeadUni("a3",0x2089)))
    OutputChar("{Numpad9}", "KP_9")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C6, "Greek_phi") ; phi
  else if (Ebene = 6)
    SendUnicodeChar(0x03A6, "Greek_PHI") ; Phi
return

neo_g:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x011D,0x011C)
                 or CheckDeadUni12("c5",0x011F,0x011E)
                 or CheckDeadUni12("a2",0x0123,0x0122)
                 or CheckDeadUni12("a6",0x0121,0x0120)))
    OutputChar12("g","G","g","G")
  else if ((Ebene = 3) and !(CheckDeadUni("a3",0x2265))) ; größer gleich
    OutputChar(">", "greater")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2078)
                          or CheckDeadUni("a3",0x2088)))
    OutputChar("{Numpad8}", "KP_8")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B3, "Greek_gamma") ; gamma
  else if (Ebene = 6)
    SendUnicodeChar(0x0393, "Greek_GAMMA") ; Gamma
return

neo_h:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0125,0x0124)
                 or CheckDeadUni12("a3",0x0127,0x0126)
                 or CheckDeadUni12("a6",0x1E23,0x1E22)))
    OutputChar12("h","H","h","H")
  else if ((Ebene = 3) and !(CheckDeadUni("a3",0x2264))) ; kleiner gleich
    OutputChar("<", "less")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2077)
                          or CheckDeadUni("a3",0x2087)))
    OutputChar("{Numpad7}", "KP_7")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C8, "Greek_psi") ; psi
  else if (Ebene = 6)
    SendUnicodeChar(0x03A8, "Greek_PSI") ; Psi
return

neo_i:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x00EE,0x00CE)
                 or CheckDeadUni12("c2",0x0129,0x0128)
                 or CheckDeadUni12("c4",0x01D0,0x01CF)
                 or CheckDeadUni12("c5",0x012D,0x012C)
                 or CheckDeadUni12("c6",0x012B,0x012A)
                 or CheckDeadUni12("g1",0x00EC,0x00CC)
                 or CheckDeadAsc12("g3","ï","Ï")
                 or CheckDeadUni12("g4",0x0209,0x0208)
                 or CheckDeadUni12("a1",0x00ED,0x00CD)
                 or CheckDeadUni12("a2",0x012F,0x012E)
                 or CheckDeadUni12("a3",0x0268,0x0197)
                 or CheckDeadUni12("a6",0x0131,0x0130)))
    OutputChar12("i","I","i","I")
  else if (Ebene = 3)
    OutputChar("`/", "slash")
  else if (Ebene = 4)
    OutputChar("{Left}", "Left")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B9, "Greek_iota") ; iota
  else if (Ebene = 6)
    SendUnicodeChar(0x222B, "integral") ; integral
return

neo_j:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0135,0x0134)
                 or CheckDeadUni(  "c4",0x01F0)
                 or CheckDeadUni12("a3",0x0249,0x0248)))
    OutputChar12("j","J","j","J")
  else if (Ebene = 3)
    OutputChar("`;", "semicolon")
  else if (Ebene = 4)
    OutputChar("`;", "semicolon")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B8, "Greek_theta") ; theta
  else if (Ebene = 6)
    SendUnicodeChar(0x221D, "variation") ; proportional
return

neo_k:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a2",0x0137,0x0136)
                 or CheckDeadUni12("a6",0x1E33,0x1E32)))
    OutputChar12("k","K","k","K")
  else if (Ebene = 3)
    OutputChar("{!}", "exclam")
  else if (Ebene = 4)
    OutputChar("¡", "exclamdown")
  else if (Ebene = 5)
    SendUnicodeChar(0x03F0, "U03F0") ; kappa symbol (varkappa)
  else if (Ebene = 6)
    SendUnicodeChar(0x221A, "radical") ; Wurzel
return

neo_l:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c4",0x013E,0x013D)
                 or CheckDeadUni12("a1",0x013A,0x0139)
                 or CheckDeadUni12("a2",0x013C,0x013B)
                 or CheckDeadUni12("a3",0x0142,0x0141)
                 or CheckDeadUni12("a6",0x1E37,0x1E36)))
    OutputChar12("l","L","l","L")
  else if (Ebene = 3)
    OutputChar("[", "bracketleft")
  else if (Ebene = 4)
    OutputChar("{Up}", "Up")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BB, "Greek_lambda") ; lambda
  else if (Ebene = 6)
    SendUnicodeChar(0x039B, "Greek_LAMBDA") ; Lambda
return

neo_m:
  EbeneAktualisieren()
  if (Ebene12 and !CheckDeadUni12("a6",0x1E41,0x1E40))
    OutputChar12("m","M","m","M")
  else if (Ebene = 3)
    OutputChar("`%", "percent")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B9)
                          or CheckDeadUni("a3",0x2081)))
    OutputChar("{Numpad1}", "KP_1")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BC, "Greek_mu") ; griechisch mu, micro wäre 0x00B5
  else if (Ebene = 6)
    SendUnicodeChar(0x21D4, "ifonlyif") ; doppelter Doppelpfeil (genau dann wenn)
return

neo_n:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c2",0x00F1,0x00D1)
                 or CheckDeadUni12("c4",0x0148,0x0147)
                 or CheckDeadUni12("a1",0x0144,0x0143)
                 or CheckDeadUni12("a2",0x0146,0x0145)
                 or CheckDeadUni12("a6",0x1E45,0x1E44)))
    OutputChar12("n","N","n","N")
  else if (Ebene = 3)
    OutputChar("(", "parenleft")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2074)
                          or CheckDeadUni("a3",0x2084)))
    OutputChar("{Numpad4}", "KP_4")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BD, "Greek_nu") ; nu
  else if (Ebene = 6)
    SendUnicodeChar(0x2115, "U2115") ; N (natürliche Zahlen)
return

neo_o:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x00F4,0x00D4)
                 or CheckDeadUni12("c2",0x00F5,0x00D5)
                 or CheckDeadUni12("c4",0x01D2,0x01D1)
                 or CheckDeadUni12("c5",0x014F,0x014E)
                 or CheckDeadUni12("c6",0x014D,0x014C)
                 or CheckDeadUni12("g1",0x00F2,0x00D2)
                 or CheckDeadAsc12("g3","ö","Ö")
                 or CheckDeadUni12("a1",0x00F3,0x00D3)
                 or CheckDeadUni12("a2",0x01EB,0x01EA)
                 or CheckDeadUni12("a3",0x00F8,0x00D8)
                 or CheckDeadUni12("a4",0x0151,0x0150)))
    OutputChar12("o","O","o","O")
  else if (Ebene = 3)
    OutputChar("*", "asterisk")
  else if (Ebene = 4)
    OutputChar("{End}", "End")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BF, "Greek_omicron") ; omicron
  else if (Ebene = 6)
    SendUnicodeChar(0x2208, "elementof") ; element of
return

neo_p:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a6",0x1E57,0x1E56)))
    OutputChar12("p","P","p","P")
  else if ((Ebene = 3) and !(CheckDeadUni("c2",0x2248)))
    OutputChar("~", "asciitilde")
  else if (Ebene = 4)
    OutputChar("{Enter}", "Return")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C0, "Greek_pi") ; pi
  else if (Ebene = 6)
    SendUnicodeChar(0x03A0, "Greek_PI") ; Pi
return

neo_q:
  EbeneAktualisieren()
  if (Ebene12)
     OutputChar12("q","Q","q","Q")
  else if (Ebene = 3)
    OutputChar("{&}", "ampersand")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x207A)
                          or CheckDeadUni("a3",0x208A)))
    OutputChar("{NumPadAdd}", "KP_Add")
  else if (Ebene = 5)
     SendUnicodeChar(0x03D5, "U03D5") ; phi symbol (varphi)
  else if (Ebene = 6)
     SendUnicodeChar(0x211A, "U211A") ; Q (rationale Zahlen)
return

neo_r:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c4",0x0159,0x0158)
                 or CheckDeadUni12("g3",0x1E5B,0x1E5A)
                 or CheckDeadUni12("a1",0x0155,0x0154)
                 or CheckDeadUni12("a2",0x0157,0x0156)
                 or CheckDeadUni12("a6",0x0E59,0x0E58)))
    OutputChar12("r","R","r","R")
  else if (Ebene = 3)
    OutputChar(")", "parenright")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2075)
                          or CheckDeadUni("a3",0x2085)))
    OutputChar("{Numpad5}", "KP_5")
  else if (Ebene = 5)
    SendUnicodeChar(0x03F1, "U03F1") ; rho symbol (varrho)
  else if (Ebene = 6)
    SendUnicodeChar(0x211D, "U221D") ; R (reelle Zahlen)
return

neo_s:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x015B,0x015A)
                 or CheckDeadUni12("a2",0x015F,0x015E)
                 or CheckDeadUni12("a6",0x1E61,0x1E60)
                 or CheckDeadUni12("c1",0x015D,0x015C)
                 or CheckDeadUni12("c4",0x0161,0x0160)
                 or CheckDeadUni12("a6",0x1E63,0x1A62))) {
    if (LangSTastatur and (Ebene = 1))
      SendUnicodeChar(0x017F, "17F") ; langes s
    else OutputChar12("s","S","s","S")
  } else if (Ebene = 3)
    OutputChar("?", "question")
  else if (Ebene = 4)
    OutputChar("¿", "questiondown")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C3, "Greek_sigma") ;sigma
  else if (Ebene = 6)
    SendUnicodeChar(0x03A3, "Greek_SIGMA") ;Sigma
return

neo_t:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a2",0x0163,0x0162)
                 or CheckDeadUni12("a6",0x1E6B,0x1E6A)
                 or CheckDeadUni12("c4",0x0165,0x0164)
                 or CheckDeadUni(  "g3",0x1E97)))
    OutputChar12("t","T","t","T")
  else if (Ebene = 3)
    OutputChar("-", "minus") ; Bisstrich
  else if (Ebene = 4) and !(CheckDeadUni("c1",0x2076)
                          or CheckDeadUni("c5",0x2086))
    OutputChar("{Numpad6}", "KP_6")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C4, "Greek_tau") ; tau
  else if (Ebene = 6)
    SendUnicodeChar(0x2202, "partialderivative") ; partielle Ableitung
return

neo_u:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x00FB,0x00DB)
                 or CheckDeadUni12("c2",0x0169,0x0168)
                 or CheckDeadUni12("c3",0x016F,0x016E)
                 or CheckDeadUni12("c4",0x01D4,0x01D3)
                 or CheckDeadUni12("c5",0x016D,0x016C)
                 or CheckDeadUni12("c6",0x016B,0x016A)
                 or CheckDeadUni12("g1",0x00F9,0x00D9)
                 or CheckDeadAsc12("g3","ü","Ü")
                 or CheckDeadUni12("a1",0x00FA,0x00DA)
                 or CheckDeadUni12("a2",0x0173,0x0172)
                 or CheckDeadUni12("a4",0x0171,0x0170)))
    OutputChar12("u","U","u","U")
  else if (Ebene = 3)
    OutputChar("\", "backslash")
  else if (Ebene = 4)
    OutputChar("{Home}", "Home")
  else if (Ebene = 6)
    SendUnicodeChar(0x222E, "U222E") ; contour integral
return

neo_v:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a6",0x1E7F,0x1E7E)))
    OutputChar12("v","V","v","V")
  else if (Ebene = 3)
    OutputChar("_","underscore")
  else if (Ebene = 4) and (!lernModus or lernModus_neo_Backspace)
    OutputChar("{Backspace}", "BackSpace")
  else if (Ebene = 6)
    SendUnicodeChar(0x2259, "U2259") ; estimates/entspricht
return

neo_w:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0175,0x0174)))
    OutputChar12("w","W","w","W")
  else if (Ebene = 3)
    OutputChar("{^}{space}", "asciicircum") ; Zirkumflex
  else if (Ebene = 4)
    OutputChar("{Insert}", "Insert") ; Einfg
  else if (Ebene = 5)
    SendUnicodeChar(0x03C9, "Greek_omega") ; omega
  else if (Ebene = 6)
    SendUnicodeChar(0x03A9, "Greek_OMEGA") ; Omega
return

neo_x:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("x","X","x","X")
  else if (Ebene = 3)
    OutputChar("…", "ellipsis") ; Ellipse horizontal
  else if (Ebene = 4)
    SendUnicodeChar(0x22EE, "U22EE") ; Ellipse vertikal
  else if (Ebene = 5)
    SendUnicodeChar(0x03BE, "Greek_xi") ; xi
  else if (Ebene = 6)
    SendUnicodeChar(0x039E, "Greek_XI") ; Xi
return

neo_y:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0177,0x0176)
                 or CheckDeadAsc12("g3","ÿ","Ÿ")
                 or CheckDeadUni12("a1",0x00FD,0x00DD)))
    OutputChar12("y","Y","y","Y")
  else if (Ebene = 3)
    OutputChar("@", "at")
  else if (Ebene = 4)
    OutputChar(".", "period")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C5, "Greek_upsilon") ; upsilon
  else if (Ebene = 6)
    SendUnicodeChar(0x2207, "nabla") ; nabla
return

neo_z:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x017A,0x0179)
                 or CheckDeadUni12("a6",0x017C,0x017B)
                 or CheckDeadUni12("c4",0x017E,0x017D)))
    OutputChar12("z","Z","z","Z")
  else if (Ebene = 3)
    OutputChar("``{space}", "grave") ; untot
  else if (Ebene = 4)
    send {Ctrl down}z{Ctrl up}
  else if (Ebene = 5)
    SendUnicodeChar(0x03B6, "Greek_zeta") ; zeta
  else if (Ebene = 6)
    SendUnicodeChar(0x2124, "U2124") ; Z (ganze Zahlen)
return

neo_ä:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c6",0x01DF,0x01DE)))
    OutputChar12("ä","Ä","adiaeresis","Adiaeresis")
  else if (Ebene = 3)
    OutputChar("|", "bar")
  else if (Ebene = 4)
    OutputChar("{PgDn}", "Next")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B7, "Greek_eta") ; eta
  else if (Ebene = 6)
    SendUnicodeChar(0x2135, "U2135") ; Kardinalzahlen, Aleph-Symbol
return

neo_ö:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c6",0x022B,0x022A)))
    OutputChar12("ö","Ö","odiaeresis","Odiaeresis")
  else if (Ebene = 3)
    OutputChar("$", "dollar")
  else if (Ebene = 4)
    OutputChar("{Tab}", "Tab")
  else if (Ebene = 6)
    SendUnicodeChar(0x2111, "U2221") ; Fraktur I
return

neo_ü:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x01D8,0x01D7)
                 or CheckDeadUni12("g1",0x01DC,0x01DB)
                 or CheckDeadUni12("c4",0x01DA,0x01D9)
                 or CheckDeadUni12("c6",0x01D6,0x01D5)))
    OutputChar12("ü","Ü","udiaeresis","Udiaeresis")
  else if (Ebene = 3)
    if isMod2Locked
      OutputChar("{Shift Up}{#}", "numbersign")
    else OutputChar("{blind}{#}", "numbersign")
  else if (Ebene = 4)
    OutputChar("{Esc}", "Escape")
  else if (Ebene = 6)
    SendUnicodeChar(0x211C, "U221C") ; Fraktur R
return

neo_sz:
  EbeneAktualisieren()
  if (Ebene = 1)
    if LangSTastatur
      OutputChar("s", "s")
    else OutputChar("ß", "ssharp")
  else if (Ebene = 2)
    SendUnicodeChar(0x1E9E, "U1E9E") ; versal-ß
  else if (Ebene = 3)
    if LangSTastatur
      OutputChar("ß", "ssharp")
    else SendUnicodeChar(0x017F, "17F") ; langes s
  else if (Ebene = 5)
    SendUnicodeChar(0x03C2, "Greek_finalsmallsigma") ; varsigma
  else if (Ebene = 6)
    SendUnicodeChar(0x2218, "jot") ; Verknüpfungsoperator
return

neo_0:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2070) ; Hochgestellte 0
                or CheckDeadUni("a3",0x2080)) ; Tiefgestellte 0 
    OutputChar12(0,"”",0,"rightdoublequotemark")
   else if (Ebene = 3)
     OutputChar("’", "rightsingleqoutemark")
   else if (Ebene = 4)
     OutputChar("{NumpadSub}", "KP_Minus")
   else if (Ebene = 5)
     SendUnicodeChar(0x2080, "U2080")
   else if (Ebene = 6)
     SendUnicodeChar(0x2205, "emptyset") ; leere Menge
return

neo_1:
  noCaps=1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x00B9) ; Hochgestellte 1
                or CheckDeadUni("a3",0x2081)) ; Tiefgestellte 1
    OutputChar12(1,"°",1,"degree")
  else if (Ebene = 3)
    OutputChar("¹", "onesuperior") ; Hochgestellte 1
  else if (Ebene = 4)
    OutputChar("º", "U00BA") ; männlicher Ordinalindikator (º)
  else if (Ebene = 5)
    SendUnicodeChar(0x2081, "U2081") ; Tiefgestellte 1
  else if (Ebene = 6)
    OutputChar("¬", "notsign") ; Nicht-Symbol
return

neo_2:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x00B2) ; Hochgestellte 2
                or CheckDeadUni("a3",0x2082)) ; Tiefgestellte 2
    OutputChar12(2,"§",2,"section")
  else if (Ebene = 3)
    OutputChar("²", "twosuperior") ; Hochgestellte 2
  else if (Ebene = 4)
    OutputChar("ª", "U00AA") ; weiblicher Ordinalindikator (ª)
  else if (Ebene = 5)
    SendUnicodeChar(0x2082, "U2082") ; Tiefgestellte 2
  else if (Ebene = 6)
    SendUnicodeChar(0x2228, "logicalor") ; Logisches Oder
return

neo_3:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x00B3) ; Hochgestellte 3
                    or CheckDeadUni("a3",0x2083)) ; Tiefgestellte 3
    OutputChar(3,3)
  else if (Ebene = 2)
    SendUnicodeChar(0x2113, "U2113") ; kleines l (Skript)
  else if (Ebene = 3)
    OutputChar("³", "threesuperior") ; Hochgestellte 3
  else if (Ebene = 4)
    SendUnicodeChar(0x2116, "numerosign") ; Numero
  else if (Ebene = 5)
    SendUnicodeChar(0x2083, "U2083") ; Tiefgestellte 3
  else if (Ebene = 6)
    SendUnicodeChar(0x2227, "logicaland") ; Logisches Und
return

neo_4:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2074) ; Hochgestellte 4
                    or CheckDeadUni("a3",0x2084)) ; Tiefgestellte 4
    OutputChar(4,4)
  else if (Ebene = 2)
    OutputChar("»", "guillemotright")
  else if (Ebene = 3)
    OutputChar("›", "U230A") ; Single guillemot right
  else if (Ebene = 4)
    OutputChar("{PgUp}", "Prior") ; Bild auf
  else if (Ebene = 5)
    OutputChar("†", "dagger") ; Kreuz
  else if (Ebene = 6)
    SendUnicodeChar(0x22A5, "uptack") ; Senkrecht
return

neo_5:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2075) ; Hochgestellte 5
                    or CheckDeadUni("a3",0x2085)) ; Tiefgestellte 5
    OutputChar(5,5)
  else if (Ebene = 2)
    OutputChar("«", "guillemotleft") ; Double guillemot left
  else if (Ebene = 3)
    OutputChar("‹", "U2039") ; Single guillemot left
  else if (Ebene = 5)
    SendUnicodeChar(0x2640, "femalesymbol")
  else if (Ebene = 6)
    SendUnicodeChar(0x2221, "U2221") ; Winkel
return

neo_6:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2076) ; Hochgestellte 6
                    or CheckDeadUni("a3",0x2086)) ; Tiefgestellte 6
    OutputChar(6,6)
  else if (Ebene = 2)
    SendUnicodeChar(0x20AC, "EuroSign")
  else if (Ebene = 3)
    OutputChar("¢", "cent")
  else if (Ebene = 4)
    OutputChar("£", "sterling")
  else if (Ebene = 5)
    SendUnicodeChar(0x2642, "malesymbol")
  else if (Ebene = 6)
    SendUnicodeChar(0x2225, "U2225") ; parallel
return

neo_7:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2077) ; Hochgestellte 7
                or CheckDeadUni("a3",0x2087)) ; Tiefgestellte 7
    OutputChar12(7,"$",7,"dollar")
  else if (Ebene = 3)
    OutputChar("¥", "yen")
  else if (Ebene = 4)
    OutputChar("¤", "currency")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BA, "Greek_kappa") ; greek small letter kappa
  else if (Ebene = 6)
    SendUnicodeChar(0x2192, "rightarrow") ; Rechtspfeil
return

neo_8:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2078) ; Hochgestellte 8
                or CheckDeadUni("a3",0x2088)) ; Tiefgestellte 8
    OutputChar12(8,"„",8,"doublelowquotemark")
  else if (Ebene = 3)
    OutputChar("‚", "singlelowquotemark")
  else if (Ebene = 4)
    OutputChar("{NumpadDiv}", "KP_Divide")
  else if (Ebene = 5)
    SendUnicodeChar(0x27E8, "U27E8") ; bra (öffnende spitze Klammer)
  else if (Ebene = 6)
    SendUnicodeChar(0x221E, "infinity")
return

neo_9:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2079) ; Hochgestellte 9
                or CheckDeadUni("a3",0x2089)) ; Tiefgestellte 9
    OutputChar12(9,"“",9,"leftdoublequotemark")
  else if (Ebene = 3)
    OutputChar("‘", "leftsinglequotemark")
  else if (Ebene = 4)
    OutputChar("{NumpadMult}", "KP_Multiply")
  else if (Ebene = 5)
    SendUnicodeChar(0x27E9, "U27E9") ; ket (schließende spitze Klammer)
  else if (Ebene = 6)
    SendUnicodeChar(0x2226, "U2226") ; nicht parallel
return

neo_punkt:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar(".", "period")
  else if (Ebene = 2)
    SendUnicodeChar(0x2023, "") ; Dreieckiges Aufzählungszeichen
  else if (Ebene = 3)
    OutputChar("'", "apostrophe")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B3)
                          or CheckDeadUni("t4",0x2083)))
    OutputChar("{Numpad3}", "KP_3")
  else if (Ebene = 5)
    SendUnicodeChar(0x03D1, "U03D1") ; theta symbol (vartheta)
  else if (Ebene = 6)
    SendUnicodeChar(0x0398, "Greek_THETA") ; Theta
return

neo_komma:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar(",", "comma")
  else if (Ebene = 2)
    OutputChar("•", "enfilledcircbullet") ; Bullet
  else if (Ebene = 3)
    OutputChar(Chr(34), "quotedbl")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B2)
                          or CheckDeadUni("c5",0x2082)))
    OutputChar("{Numpad2}", "KP_2")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C1, "Greek_rho") ; rho
  else if (Ebene = 6)
    SendUnicodeChar(0x21D2, "implies") ; Doppelpfeil rechts
return

neo_strich:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("-", "minus") ; Bindestrich-Minus
  else if (Ebene = 2)
    SendUnicodeChar(0x2013, "endash") ; Gedankenstrich
  else if (Ebene = 3)
    SendUnicodeChar(0x2014, "emdash") ; Englischer Gedankenstrich (Geviertstrich)
  else if (Ebene = 5)
    SendUnicodeChar(0x2011, "U2011") ; geschützter Bindestrich (Bindestrich ohne Zeilenumbruch)
  else if (Ebene = 6)
    SendUnicodeChar(0x00AD, "hyphen") ; weicher Bindestrich
return

*space::
  if einHandNeo
    spacepressed := 1
  else goto neo_SpaceUp
return

*space up::
  if einHandNeo
    if keypressed {
     keypressed := 0
     spacepressed := 0
    } else goto neo_SpaceUp
  return

neo_SpaceUp:
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("a3",0x2010)  ; Echter Bindestrich
    OutputChar("{Space}", "Space")
  else if (Ebene = 2) or (Ebene = 3)
    Send {blind}{Space}
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2070)
                        or CheckDeadUni("a3",0x2080)))
   OutputChar("{Numpad0}", "KP_0")
  else if (Ebene = 5)
    SendUnicodeChar(0x00A0, "U00A0") ; geschütztes Leerzeichen
  else if (Ebene = 6)
    SendUnicodeChar(0x202F, "U202F") ; schmales geschütztes Leerzeichen
  DeadKey := ""
  CompKey := ""
  spacepressed := 0
  keypressed := 0
return

*Enter::
  EbeneAktualisieren()
  if !lernModus or lernModus_std_Return {
    if (Ebene = 4)
      send {blind}{NumpadEnter}
    else send {blind}{Enter}
    DeadKey := ""
    CompKey := ""
  } return

*Backspace::
  if !lernModus or lernModus_std_Backspace {
    send {Blind}{Backspace}
    DeadKey := ""
    CompKey := ""
  } return

*Del::
  if !lernModus or lernModus_std_Entf
    send {Blind}{Del}
return

*Ins::
  if !lernModus or lernModus_std_Einf
    send {Blind}{Ins}
return

neo_tab:
  EbeneAktualisieren()
  if IsMod3Pressed() { ; Compose!
    DeadKey := "comp"
    CompKey := ""
  } else {
    OutputChar("{Tab}", "Tab")
    DeadKey := ""
    CompKey := ""
  } return

*Home::
  if !lernModus or lernModus_std_Pos1 {
    send {Blind}{Home}
    DeadKey := ""
    CompKey := ""
  } return

*End::
  if !lernModus or lernModus_std_Ende {
    send {Blind}{End}
    DeadKey := ""
    CompKey := ""
  } return

*PgUp::
  if !lernModus or lernModus_std_PgUp {
    send {Blind}{PgUp}
    DeadKey := ""
    CompKey := ""
  } return

*PgDn::
  if !lernModus or lernModus_std_PgDn {
    send {Blind}{PgDn}
    DeadKey := ""
    CompKey := ""
  } return

*Up::
  if !lernModus or lernModus_std_Hoch {
    send {Blind}{Up}
    DeadKey := ""
    CompKey := ""
  } return

*Down::
  if !lernModus or lernModus_std_Runter {
    send {Blind}{Down}
    DeadKey := ""
    CompKey := ""
  } return

*Left::
  if !lernModus or lernModus_std_Links {
    send {Blind}{Left}
    DeadKey := ""
    CompKey := ""
  } return

*Right::
  if !lernModus or lernModus_std_Rechts {
    send {Blind}{Right}
    DeadKey := ""
    CompKey := ""
  } return

neo_Numpad0:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad0}", "KP_0")
  else if (Ebene = 2)
    SendUnicodeChar(0x2423, "U2423") ; space sign
  else if (Ebene = 3)
    SendUnicodeChar(0x0025, "percent") ; Prozent
  else if (Ebene = 4)
    send {blind}{NumpadIns}
  else if (Ebene = 5)
    OutputChar("‰", "U2030") ; Promille
  else if (Ebene = 6)
    SendUnicodeChar(0x25A1, "U25A1") ; white square
return

neo_Numpad1:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad1}", "KP_1")
  else if (Ebene = 2)
    SendUnicodeChar(0x2666, "diamond") ; Karo
  else if (Ebene = 3)
    SendUnicodeChar(0x2194, "U2194") ; Links-Rechts-Pfeil
  else if (Ebene = 4)
    send {blind}{NumpadEnd}
  else if (Ebene = 5)
    SendUnicodeChar(0x2264, "lessthanequal")
  else if (Ebene = 6)
    SendUnicodeChar(0x230A, "downstile") ;linke Untergrenze
return

neo_Numpad2:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad2}", "KP_2")
  else if (Ebene = 2)
    SendUnicodeChar(0x2265, "heart")
  else if (Ebene = 3)
    SendUnicodeChar(0x2192, "downarrow")
  else if (Ebene = 4)
    send {blind}{NumpadDown}
  else if (Ebene = 5)
    SendUnicodeChar(0x222A, "union") ; Vereinigung
  else if (Ebene = 6)
    SendUnicodeChar(0x22C3, "U22C3") ; n-ary union
return

neo_Numpad3:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad3}", "KP_3")
  else if (Ebene = 2)
    SendUnicodeChar(0x2660, "U2660") ; Pik
  else if (Ebene = 3)
    SendUnicodeChar(0x21CC, "U21CC") ; Harpune
  else if (Ebene = 4)
    send {blind}{NumpadPgDn}
  else if (Ebene = 5)
    SendUnicodeChar(0x2265, "greaterthanequal")
  else if (Ebene = 6)
    SendUnicodeChar(0x230B, "U230B") ; rechte Untergrenze
return

neo_Numpad4:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad4}", "KP_4")
  else if (Ebene = 2)
    SendUnicodeChar(0x2663, "club") ; schwarzes Kreuz
  else if (Ebene = 3)
    SendUnicodeChar(0x2190, "leftarrow") ; Linkspfeil
  else if (Ebene = 4)
    send {blind}{NumpadLeft}
  else if (Ebene = 5)
    SendUnicodeChar(0x2282, "includein") ; Teilmenge
  else if (Ebene = 6)
    SendUnicodeChar(0x2286, "U2286") ; Teilmenge-gleich
return

neo_Numpad5:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad5}", "KP_5")
  else if (Ebene = 2)
    SendUnicodeChar(0x20AC, "EuroSign") ; Euro
  else if (Ebene = 3)
    SendUnicodeChar(0x00A6, "brokenbar")
  else if (Ebene = 4)
    send {blind}{NumPadClear} ; begin
  else if (Ebene = 5)
    SendUnicodeChar(0x22B6, "U22B6") ; original of
  else if (Ebene = 6)
    SendUnicodeChar(0x22B7, "U22B7") ; image of
return

neo_Numpad6:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad6}", "KP_6")
  else if (Ebene = 3)
    SendUnicodeChar(0x2192, "rightarrow") ; Rechtspfeil
  else if (Ebene = 4)
    send {blind}{NumpadRight}
  else if (Ebene = 5)
    SendUnicodeChar(0x2283, "includes") ; Obermenge
  else if (Ebene = 6)
    SendUnicodeChar(0x2287, "U2287") ; Obermenge-gleich
return

neo_Numpad7:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad7}", "KP_7")
  else if (Ebene = 2)
    SendUnicodeChar(0x2714, "U2714") ; check mark
  else if (Ebene = 3)
    SendUnicodeChar(0x2195, "U2195") ; Hoch-Runter-Pfeil
  else if (Ebene = 4)
    send {blind}{NumpadHome}
  else if (Ebene = 5)
    SendUnicodeChar(0x226A, "U226A") ; much less
  else if (Ebene = 6)
    SendUnicodeChar(0x2308, "upstile") ; linke Obergrenze
return

neo_Numpad8:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad8}", "KP_8")
  else if (Ebene = 2)
    SendUnicodeChar(0x2718, "U2718") ; ballot x
  else if (Ebene = 3)
    SendUnicodeChar(0x2191, "uparrow") ; Hochpfeil
  else if (Ebene = 4)
    send {blind}{NumpadUp}
  else if (Ebene = 5)
    SendUnicodeChar(0x2229, "intersection") ; Durchschnitt
  else if (Ebene = 6)
    SendUnicodeChar(0x22C2, "U22C2") ; n-ary intersection
return

neo_Numpad9:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad9}", "KP_9")
  else if (Ebene = 2)
    SendUnicodeChar(0x2020, "dagger") ; Kreuz
  else if (Ebene = 3)
    SendUnicodeChar(0x20D7, "U20D7") ; Vektor
  else if (Ebene = 4)
    send {blind}{NumpadPgUp}
  else if (Ebene = 5)
    SendUnicodeChar(0x226B, "U226B") ; much greater
  else if (Ebene = 6)
    SendUnicodeChar(0x2309, "U2309") ; rechte Obergrenze
return

neo_NumLock:
  EbeneAktualisieren()
  if Ebene12
    OutputChar("{Tab}", "Tab")
  else if (Ebene = 3)
    OutputChar("`=", "equal")
  else if (Ebene = 4)
    SendUnicodeChar(0x2260, "notequal") ; Ungleich zu
  else if (Ebene = 5)
    SendUnicodeChar(0x2248, "approxeq") ; Fast gleich
  else if (Ebene = 6)
    SendUnicodeChar(0x2261, "identical")
return

neo_NumpadDiv:
  EbeneAktualisieren()
  if Ebene12
    OutputChar("{NumpadDiv}", "KP_Divide")
  else if (Ebene = 3)
    OutputChar("÷", "division")
  else if (Ebene = 4)
    SendUnicodeChar(0x2300, "U2300") ; diameter
  else if (Ebene = 5)
    SendUnicodeChar(0x2223, "U2223") ; divides
  else if (Ebene = 6)
    SendUnicodeChar(0x2044, "U2044") ; fraction slash
return

neo_NumpadMult:
  EbeneAktualisieren()
  if Ebene12
    send {blind}{NumpadMult}
  else if (Ebene = 3)
    SendUnicodeChar(0x22C5, "U22C5") ; multiplication dot
  else if (Ebene = 4)
    SendUnicodeChar(0x2299, "U2299") ; circled dot
  else if (Ebene = 5)
    OutputChar("×", "multiply")
  else if (Ebene = 6)
    SendUnicodeChar(0x2297, "U2297") ; circled times
return

neo_NumpadSub:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni("c1",0x207B)
                 or CheckDeadUni("a3",0x208B)))
    send {blind}{NumpadSub}
  else if (Ebene = 3)
    SendUnicodeChar(0x2212, "U2212") ; Echtes Minus
  else if (Ebene = 4)
    SendUnicodeChar(0x2296, "U2296") ; circled minus
  else if (Ebene = 5)
    SendUnicodeChar(0x2216, "U2216") ; set minus
  else if (Ebene = 6)
    SendUnicodeChar(0x2238, "U2238") ; dot minus
return

neo_NumpadAdd:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni("c1",0x207A)
                 or CheckDeadUni("a3",0x208A)))
    send {blind}{NumpadAdd}
  else if (Ebene = 3)
    OutputChar("±", "plusminus")
  else if (Ebene = 4)
    SendUnicodeChar(0x2295, "U2295") ; circled plus
  else if (Ebene = 5)
    SendUnicodeChar(0x2213, "U2213") ; minus-plus
  else if (Ebene = 6)
    SendUnicodeChar(0x2214, "U2214") ; dot plus
return

neo_NumpadEnter:
  send {blind}{NumpadEnter}
return

neo_NumpadDot:
  EbeneAktualisieren()
  if (Ebene = 1)
    send {blind}{NumpadDot}
  else if (Ebene = 2)
    send {blind}.
  else if (Ebene = 3)
    send `,
  else if (Ebene = 4)
    send {blind}{NumpadDel}
  else if (Ebene = 5)
    SendUnicodeChar(0x2032, "minutes")
  else if (Ebene = 6)
    SendUnicodeChar(0x2033, "seconds")
return

neo_tot1:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("c1",0x0302)      ; Zirkumflex, tot

    deadUni(0x02C6, "dead_circumflex", "c1")

  else if (Ebene = 2) and !CheckDeadUni("c2",0x0303) ; Tilde, tot

    deadUni(0x02DC, "dead_tilde", "c2")

  else if (Ebene = 3) and !CheckDeadUni("c3",0x030A) ; Ring, tot

    deadUni(0x02DA, "dead_breve", "c3")

  else if (Ebene = 4) and !CheckDeadUni("c4",0x030C) ; Caron, tot

    deadUni(0x02C7, "dead_caron", "c4")

  else if (Ebene = 5) and !CheckDeadUni("c5",0x0306) ; Brevis, tot

    deadUni(0x02D8, "dead_breve", "c5")

  else if (Ebene = 6) and !CheckDeadUni("c6",0x0304) ; Makron, tot

    deadAsc("¯", "dead_macron", "c6")
return

neo_tot2:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("g1",0x0300)      ; Gravis, tot

    deadAsc("``{space}", "dead_grave", "g1")

  else if (Ebene = 3) and !CheckDeadUni("g3",0x0308) ; Diärese, tot

    deadUni(0x00A8, "dead_diaeresis", "g3")

  else if (Ebene = 4) and !CheckDeadUni("g4",0x030F) ; Doppelgravis, tot

    deadUni(0x02F5, "dead_doublegrave", "g4")

  else if (Ebene = 5) and !CheckDeadUni("g5",0x0485) ; Spiritus asper, tot

    deadUni(0x1FFE, "U1FFE", "g5")
return

neo_tot3:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("a1",0x0301)      ; Akut, tot

    deadAsc("{´}{space}", "dead_acute", "a1")

  else if (Ebene = 2) and !CheckDeadUni("a2",0x0327) ; Cedille, tot

    deadAsc("¸", "dead_cedilla", "a2")

  else if (Ebene = 3) and !CheckDeadUni("a3",0x0337) ; Strich, tot

    deadUni(0x002F, "dead_stroke", "a3")

  else if (Ebene = 4) and !CheckDeadUni("a4",0x0338) ; Doppelakut, tot

    deadUni(0x02DD, "dead_doubleacute", "a4")

  else if (Ebene = 5) and !CheckDeadUni("a5",0x0486) ; Spiritus lenis, tot

    deadUni(0x1FBF, "U1FBF", "a5")

  else if (Ebene = 6) and !CheckDeadUni("a6",0x0307) ; Punkt darüber, tot

    deadUni(0x02D9, "dead_abovedot", "a6")
return

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

KeyboardLED(LEDvalue, Cmd) { ; LEDvalue: ScrollLock=1, NumLock=2, CapsLock=4 ; Cmd = on/off/switch
  Static h_device
  If !(h_device) { ; initialise
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
  If (Cmd=off) { ;forces all choosen LED's to OFF (LEDvalue= 0 ->LED's according to keystate)
    LEDvalue:=LEDvalue ^ 7
    KeyLED:=LEDvalue & (GetKeyState("ScrollLock","T") + 2*GetKeyState("NumLock","T") + 4*GetKeyState("CapsLock","T"))
  }
  ; EncodeIntegerLED(KeyLED,1,&input,2) ;input bit pattern (KeyLED): bit 0 = scrolllock ;bit 1 = numlock ;bit 2 = capslock
  input := Chr(1) Chr(1) Chr(KeyLED)
  input := Chr(1)
  input =
  ; ???
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

CTL_CODE_LED(p_device_type,p_function,p_method,p_access ) {
  Return,( p_device_type << 16 ) | ( p_access << 14 ) | ( p_function << 2 ) | p_method
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

SetUnicodeStrLED(ByRef out, str_) { 
  VarSetCapacity(st1, 8, 0) 
  InsertIntegerLED(0x530025, st1) 
  VarSetCapacity(out, (StrLen(str_)+1)*2, 0) 
  DllCall("wsprintfW", "str", out, "str", st1, "str", str_, "Cdecl UInt") 
} 

ExtractIntegerLED(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4) {
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

InsertIntegerLED(pInteger, ByRef pDest, pOffset = 0, pSize = 4) { 
; The caller must ensure that pDest has sufficient capacity.  To preserve any existing contents in pDest, 
; only pSize number of bytes starting at pOffset are altered in it. 
  Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data. 
    DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF) 
}


deadAsc(val1, val2, a) {
  global
  if !DeadSilence
    OutputChar(val1, val2)
  else CheckComp(val2)
  DeadKey := a
}

deadUni(val1, val2, a) {
  global
  if !DeadSilence
    SendUnicodeChar(val1, val2)
  else CheckComp(val2)
  DeadKey := a
}

undeadAsc(val) {
  global
  if DeadSilence
    send % val
  else
    send % "{bs}" . val
}

undeadUni(val){
  global
  if !DeadSilence
    send {bs}
  SendUnicodeChar(val, "")
}

CheckDeadAsc(d,val) {
  global
  if (PriorDeadKey == d) {
    undeadAsc(val)
    return 1
  }
}

CheckDeadUni(d,val) {
  global
  if (PriorDeadKey == d) {
    undeadUni(val)
    return 1
  }
}

CheckDeadAsc12(d,val1,val2) {
  global
  if (PriorDeadKey == d){
    if (Ebene = 1) and (val1 != "") {
      undeadAsc(val1)
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      undeadAsc(val2)
      return 1
    }
  }
}

CheckDeadUni12(d,val1,val2) {
  global
  if(PriorDeadKey == d) {
    if (Ebene = 1) and (val1 != "") {
      undeadUni(val1)
      return 1
    } else if (Ebene = 2) and (val2 != "") {
      undeadUni(val2)
      return 1
    }
  }
}

CheckCompUni(d,val) {
  global
  if (CompKey == d) {
    PriorCompKey =
    CompKey =
    if !DeadCompose
      send {bs}
    isFurtherCompkey = 0
    SendUnicodeChar(val, "")
    return 1
  }
}

OutputChar(val1,val2) {
  global
  if !(CheckComp(val2) and DeadCompose)
    send % "{blind}" . val1
}

OutputChar12(val1,val2,val3,val4) {
  global
  if (Ebene = 1)
    c := val1
  else c := val2
  if (Ebene = 1)
    d := val3
  else d := val4
  if !(CheckComp(d) and DeadCompose)
    if GetKeyState("Shift","P") and isMod2Locked
      send % "{blind}{Shift Up}" . c . "{Shift Down}"
    else send % "{blind}" . c
}

;Folgende Funktion prüft, ob das eben geschriebene Zeichen eine gültige Coko 
;fortsetzen KÖNNTE – falls ja, wird 1 zurückgegeben (die Eingabe soll blind erfolgen), 
;andernfalls wird 0 zurückgegeben (das Zeichen soll ausgegeben werden).

CheckComp(d) {
  global
  if (PriorDeadKey = "comp") {
    CompKey := "<" . d . ">"
    PriorDeadKey := DeadKey =
    CheckCompose()
    TryThirdCompKey = 0
    return 1
  } else if TryFourthCompKey {
    TryFourthCompKey = 0
    CompKey := ThreeCompKeys . " " . "<" . d . ">"
    ThreeCompKeys =
    CheckCompose()
    if !(CompKey) {
      send {left}{bs}{right}
      return 1
    } else CompKey =
  } else if TryThirdCompKey {
    TryThirdCompKey = 0
    CompKey := PriorCompKey . " " . "<" . d . ">"
    CheckCompose()
    if CompKey {
      TryFourthCompKey = 1
      ThreeCompKeys := CompKey
      CompKey =
    } else return 1
  } else if PriorCompKey {
    CompKey := PriorCompKey . " " . "<" . d . ">"
    CheckCompose()
    if CompKey
      TryThirdCompKey = 1
    return 1
  }
}

CumulateDeadKey(a) {
  if DeadKey = a5
  { if a = g1
      DeadKey = a5g1
    else if a = a1
      DeadKey = a5a1
    else if a = a2
      DeadKey = a5a2
    else if a = g1a2
      DeadKey = a5g1a2
    else if a = a1a2
      DeadKey = a5a1a2
    else if a = c1a2
      DeadKey = a5c1a2
  } else if DeadKey = g5
  { if a = g1
      DeadKey = g5g1
    else if a = a1
      DeadKey = g5a1
    else if a = a2
      DeadKey = g5a2
    else if a = g1a2
      DeadKey = g5g1a2
    else if a = a1a2
      DeadKey = g5a1a2
    else if a = c1a2
      DeadKey = g5c1a2
  } else if DeadKey = g1
  { if a = a5
      DeadKey = a5g1
    else if a = g5
      DeadKey = g5g1
    else if a = a2
      DeadKey = g1a2
    else if a = a5a2
      DeadKey = a5g1a2
    else if a = g5a2
      DeadKey = g5g1a2
  }
}

CheckCompose() {
CheckCompUni("<G> <A>", 0x391)
CheckCompUni("<G> <B>", 0x392)
CheckCompUni("<G> <E>", 0x395)
CheckCompUni("<G> <Z>", 0x396)
CheckCompUni("<G> <H>", 0x397)
CheckCompUni("<G> <I>", 0x399)
CheckCompUni("<G> <K>", 0x39A)
CheckCompUni("<G> <M>", 0x39C)
CheckCompUni("<G> <N>", 0x39D)
CheckCompUni("<G> <O>", 0x39F)
CheckCompUni("<G> <P>", 0x3A1)
CheckCompUni("<G> <T>", 0x3A4)
CheckCompUni("<G> <Y>", 0x3A5)
CheckCompUni("<G> <X>", 0x3A7)
CheckCompUni("<f> <f>", 0xFB00)
CheckCompUni("<f> <i>", 0xFB01)
CheckCompUni("<f> <l>", 0xFB02)
CheckCompUni("<F> <i>", 0xFB03)
CheckCompUni("<F> <l>", 0xFB04)
CheckCompUni("<17F> <t>", 0xFB05)
CheckCompUni("<s> <t>", 0xFB06)
CheckCompUni("<f> <b>", 0xE030)
CheckCompUni("<F> <b>", 0xE031)
CheckCompUni("<F> <h>", 0xE032)
CheckCompUni("<F> <j>", 0xE033)
CheckCompUni("<F> <k>", 0xE034)
CheckCompUni("<F> <t>", 0xE035)
CheckCompUni("<f> <h>", 0xE036)
CheckCompUni("<f> <j>", 0xE037)
CheckCompUni("<f> <k>", 0xE038)
CheckCompUni("<f> <t>", 0xE039)
CheckCompUni("<l> <c> <k>", 0xE03A)
CheckCompUni("<l> <c> <h>", 0xE03B)
CheckCompUni("<t> <t>", 0xE03C)
CheckCompUni("<l> <c> <t>", 0xE03D)
CheckCompUni("<17F> <i>", 0xE03E)
CheckCompUni("<17F> <17F>", 0xE03F)
CheckCompUni("<17F> <l>", 0xE043)
CheckCompUni("<S> <i>", 0xE044)
CheckCompUni("<17F> <s>", 0xE045)
CheckCompUni("<t> <z>", 0xE04A)
CheckCompUni("<Q> <u>", 0xE048)
CheckCompUni("<T> <h>", 0xE049)
CheckCompUni("<I> <J>", 0x132)
CheckCompUni("<i> <j>", 0x133)
CheckCompUni("<D> <Z>", 0x1C4)
CheckCompUni("<D> <z>", 0x1C5)
CheckCompUni("<d> <z>", 0x1C6)
CheckCompUni("<L> <J>", 0x1C7)
CheckCompUni("<L> <j>", 0x1C8)
CheckCompUni("<l> <j>", 0x1C9)
CheckCompUni("<N> <J>", 0x1CA)
CheckCompUni("<N> <j>", 0x1CB)
CheckCompUni("<n> <j>", 0x1CC)
CheckCompUni("<minus> <H>", 0x126)
CheckCompUni("<minus> <h>", 0x127)
CheckCompUni("<E> <E>", 0x18F)
CheckCompUni("<L> <period>", 0x13F)
CheckCompUni("<l> <period>", 0x140)
CheckCompUni("<2> <exclam>", 0x203C)
CheckCompUni("<exclam> <2>", 0x203C)
CheckCompUni("<KP_2> <exclam>", 0x203C)
CheckCompUni("<exclam> <KP_2>", 0x203C)
CheckCompUni("<2> <question>", 0x2047)
CheckCompUni("<question> <2>", 0x2047)
CheckCompUni("<KP_2> <question>", 0x2047)
CheckCompUni("<question> <KP_2>", 0x2047)
CheckCompUni("<question> <exclam>", 0x2048)
CheckCompUni("<exclam> <question>", 0x2049)
CheckCompUni("<1> <question> <exclam>", 0x203D)
CheckCompUni("<1> <exclam> <question>", 0x203D)
CheckCompUni("<KP_1> <question> <exclam>", 0x203D)
CheckCompUni("<KP_1> <exclam> <question>", 0x203D)
CheckCompUni("<1> <questiondown> <exclamdown>", 0x2E18)
CheckCompUni("<1> <exclamdown> <questiondown>", 0x2E18)
CheckCompUni("<KP_1> <questiondown> <exclamdown>", 0x2E18)
CheckCompUni("<KP_1> <exclamdown> <questiondown>", 0x2E18)
CheckCompUni("<dagger> <dagger>", 0x2021)
CheckCompUni("<colon> <colon>", 0x2025)
CheckCompUni("<nobreakspace> <nobreakspace>", 0x2D)
CheckCompUni("<R> <1> <space>", 0x2160)
CheckCompUni("<R> <2>", 0x2161)
CheckCompUni("<R> <3>", 0x2162)
CheckCompUni("<R> <4>", 0x2163)
CheckCompUni("<R> <5>", 0x2164)
CheckCompUni("<R> <6>", 0x2165)
CheckCompUni("<R> <7>", 0x2166)
CheckCompUni("<R> <8>", 0x2167)
CheckCompUni("<R> <9>", 0x2168)
CheckCompUni("<R> <1> <0>", 0x2169)
CheckCompUni("<R> <1> <1>", 0x216A)
CheckCompUni("<R> <1> <2>", 0x216B)
CheckCompUni("<R> <KP_1> <space>", 0x2160)
CheckCompUni("<R> <KP_2>", 0x2161)
CheckCompUni("<R> <KP_3>", 0x2162)
CheckCompUni("<R> <KP_4>", 0x2163)
CheckCompUni("<R> <KP_5>", 0x2164)
CheckCompUni("<R> <KP_6>", 0x2165)
CheckCompUni("<R> <KP_7>", 0x2166)
CheckCompUni("<R> <KP_8>", 0x2167)
CheckCompUni("<R> <KP_9>", 0x2168)
CheckCompUni("<R> <KP_1> <KP_0>", 0x2169)
CheckCompUni("<R> <KP_1> <KP_1>", 0x216A)
CheckCompUni("<R> <KP_1> <KP_2>", 0x216B)
CheckCompUni("<r> <1> <space>", 0x2170)
CheckCompUni("<r> <2>", 0x2171)
CheckCompUni("<r> <3>", 0x2172)
CheckCompUni("<r> <4>", 0x2173)
CheckCompUni("<r> <5>", 0x2174)
CheckCompUni("<r> <6>", 0x2175)
CheckCompUni("<r> <7>", 0x2176)
CheckCompUni("<r> <8>", 0x2177)
CheckCompUni("<r> <9>", 0x2178)
CheckCompUni("<r> <1> <0>", 0x2179)
CheckCompUni("<r> <1> <1>", 0x217A)
CheckCompUni("<r> <1> <2>", 0x217B)
CheckCompUni("<r> <KP_1> <space>", 0x2170)
CheckCompUni("<r> <KP_2>", 0x2171)
CheckCompUni("<r> <KP_3>", 0x2172)
CheckCompUni("<r> <KP_4>", 0x2173)
CheckCompUni("<r> <KP_5>", 0x2174)
CheckCompUni("<r> <KP_6>", 0x2175)
CheckCompUni("<r> <KP_7>", 0x2176)
CheckCompUni("<r> <KP_8>", 0x2177)
CheckCompUni("<r> <KP_9>", 0x2178)
CheckCompUni("<r> <KP_1> <KP_0>", 0x2179)
CheckCompUni("<r> <KP_1> <KP_1>", 0x217A)
CheckCompUni("<r> <KP_1> <KP_2>", 0x217B)
CheckCompUni("<a> <0>", 0x660)
CheckCompUni("<a> <1>", 0x661)
CheckCompUni("<a> <2>", 0x662)
CheckCompUni("<a> <3>", 0x663)
CheckCompUni("<a> <4>", 0x664)
CheckCompUni("<a> <5>", 0x665)
CheckCompUni("<a> <6>", 0x666)
CheckCompUni("<a> <7>", 0x667)
CheckCompUni("<a> <8>", 0x668)
CheckCompUni("<a> <9>", 0x669)
CheckCompUni("<a> <KP_0>", 0x660)
CheckCompUni("<a> <KP_1>", 0x661)
CheckCompUni("<a> <KP_2>", 0x662)
CheckCompUni("<a> <KP_3>", 0x663)
CheckCompUni("<a> <KP_4>", 0x664)
CheckCompUni("<a> <KP_5>", 0x665)
CheckCompUni("<a> <KP_6>", 0x666)
CheckCompUni("<a> <KP_7>", 0x667)
CheckCompUni("<a> <KP_8>", 0x668)
CheckCompUni("<a> <KP_9>", 0x669)
CheckCompUni("<1> <3>", 0x2153)
CheckCompUni("<2> <3>", 0x2154)
CheckCompUni("<1> <5>", 0x2155)
CheckCompUni("<2> <5>", 0x2156)
CheckCompUni("<3> <5>", 0x2157)
CheckCompUni("<4> <5>", 0x2158)
CheckCompUni("<1> <6>", 0x2159)
CheckCompUni("<5> <6>", 0x215A)
CheckCompUni("<1> <8>", 0x215B)
CheckCompUni("<3> <8>", 0x215C)
CheckCompUni("<5> <8>", 0x215D)
CheckCompUni("<7> <8>", 0x215E)
CheckCompUni("<1> <slash>", 0x215F)
CheckCompUni("<1> <KP_Divide>", 0x215F)
CheckCompUni("<KP_1> <KP_3>", 0x2153)
CheckCompUni("<KP_2> <KP_3>", 0x2154)
CheckCompUni("<KP_1> <KP_5>", 0x2155)
CheckCompUni("<KP_2> <KP_5>", 0x2156)
CheckCompUni("<KP_3> <KP_5>", 0x2157)
CheckCompUni("<KP_4> <KP_5>", 0x2158)
CheckCompUni("<KP_1> <KP_6>", 0x2159)
CheckCompUni("<KP_5> <KP_6>", 0x215A)
CheckCompUni("<KP_1> <KP_8>", 0x215B)
CheckCompUni("<KP_3> <KP_8>", 0x215C)
CheckCompUni("<KP_5> <KP_8>", 0x215D)
CheckCompUni("<KP_7> <KP_8>", 0x215E)
CheckCompUni("<KP_1> <slash>", 0x215F)
CheckCompUni("<KP_1> <KP_Divide>", 0x215F)
CheckCompUni("<KP_1> <KP_4>", 0xBC)
CheckCompUni("<KP_1> <KP_2>", 0xBD)
CheckCompUni("<KP_3> <KP_4>", 0xBE)
CheckCompUni("<3> <radical>", 0x221B)
CheckCompUni("<radical> <3>", 0x221B)
CheckCompUni("<KP_3> <radical>", 0x221B)
CheckCompUni("<radical> <KP_3>", 0x221B)
CheckCompUni("<4> <radical>", 0x221C)
CheckCompUni("<radical> <4>", 0x221C)
CheckCompUni("<KP_4> <radical>", 0x221C)
CheckCompUni("<radical> <KP_4>", 0x221C)
CheckCompUni("<integral> <2>", 0x222C)
CheckCompUni("<2> <integral>", 0x222C)
CheckCompUni("<integral> <integral>", 0x222C)
CheckCompUni("<integral> <KP_2>", 0x222C)
CheckCompUni("<KP_2> <integral>", 0x222C)
CheckCompUni("<integral> <3>", 0x222D)
CheckCompUni("<3> <integral>", 0x222D)
CheckCompUni("<integral> <KP_3>", 0x222D)
CheckCompUni("<KP_3> <integral>", 0x222D)
CheckCompUni("<integral> <4>", 0x2A0C)
CheckCompUni("<4> <integral>", 0x2A0C)
CheckCompUni("<integral> <KP_4>", 0x2A0C)
CheckCompUni("<KP_4> <integral>", 0x2A0C)
CheckCompUni("<U222E> <2>", 0x222F)
CheckCompUni("<2> <U222E>", 0x222F)
CheckCompUni("<U222E> <U222E>", 0x222F)
CheckCompUni("<U222E> <KP_2>", 0x222F)
CheckCompUni("<KP_2> <U222E>", 0x222F)
CheckCompUni("<U222E> <3>", 0x2230)
CheckCompUni("<3> <U222E>", 0x2230)
CheckCompUni("<U222E> <KP_3>", 0x2230)
CheckCompUni("<KP_3> <U222E>", 0x2230)
CheckCompUni("<l> <n>", 0x33D1)
CheckCompUni("<l> <o> <g>", 0x33D2)
CheckCompUni("<asciicircum> <bracketleft>", 0x2308)
CheckCompUni("<underscore> <bracketleft>", 0x230A)
CheckCompUni("<asciicircum> <bracketright>", 0x2309)
CheckCompUni("<underscore> <bracketright>", 0x230B)
CheckCompUni("<greater> <period>", 0x2234)
CheckCompUni("<less> <period>", 0x2235)
CheckCompUni("<asciitilde> <equal>", 0x2245)
CheckCompUni("<equal> <asciitilde>", 0x2245)
CheckCompUni("<asciitilde> <asciitilde>", 0x2248)
CheckCompUni("<greater> <equal>", 0x2265)
CheckCompUni("<equal> <greater>", 0x2265)
CheckCompUni("<less> <equal>", 0x2264)
CheckCompUni("<equal> <less>", 0x2264)
CheckCompUni("<equal> <degree>", 0x2257)
CheckCompUni("<degree> <equal>", 0x2257)
CheckCompUni("<KP_Add> <KP_Subtract>", 0xB1)
CheckCompUni("<KP_Subtract> <KP_Add>", 0x2213)
CheckCompUni("<minus> <plus>", 0x2213)
CheckCompUni("<equal> <slash>", 0x2260)
CheckCompUni("<equal> <dead_stroke> <dead_stroke>", 0x2260)
CheckCompUni("<KP_equal> <KP_Divide>", 0x2260)
CheckCompUni("<KP_equal> <dead_stroke> <dead_stroke>", 0x2260)
CheckCompUni("<less> <greater>", 0x2260)
CheckCompUni("<U2203> <slash>", 0x2204)
CheckCompUni("<U2203> <dead_stroke> <dead_stroke>", 0x2204)
CheckCompUni("<elementof> <slash>", 0x2209)
CheckCompUni("<elementof> <dead_stroke> <dead_stroke>", 0x2209)
CheckCompUni("<containsas> <slash>", 0x220C)
CheckCompUni("<containsas> <dead_stroke> <dead_stroke>", 0x220C)
CheckCompUni("<bar> <slash>", 0x2224)
CheckCompUni("<bar> <dead_stroke> <dead_stroke>", 0x2224)
CheckCompUni("<U2225> <slash>", 0x2226)
CheckCompUni("<U2225> <dead_stroke> <dead_stroke>", 0x2226)
CheckCompUni("<asciitilde> <slash>", 0x2241)
CheckCompUni("<asciitilde> <dead_stroke> <dead_stroke>", 0x2241)
CheckCompUni("<less> <slash>", 0x226E)
CheckCompUni("<less> <dead_stroke> <dead_stroke>", 0x226E)
CheckCompUni("<greater> <slash>", 0x226F)
CheckCompUni("<greater> <dead_stroke> <dead_stroke>", 0x226F)
CheckCompUni("<lessthanequal> <slash>", 0x2270)
CheckCompUni("<lessthanequal> <dead_stroke> <dead_stroke>", 0x2270)
CheckCompUni("<greaterthanequal> <slash>", 0x2271)
CheckCompUni("<greaterthanequal> <dead_stroke> <dead_stroke>", 0x2271)
CheckCompUni("<includedin> <slash>", 0x2284)
CheckCompUni("<includedin> <dead_stroke> <dead_stroke>", 0x2284)
CheckCompUni("<includes> <slash>", 0x2285)
CheckCompUni("<includes> <dead_stroke> <dead_stroke>", 0x2285)
CheckCompUni("<rightarrow>", 0x20D7)
CheckCompUni("<asciicircum> <greater>", 0x20D7)
CheckCompUni("<asciicircum> <rightarrow>", 0x20D7)
CheckCompUni("<asciicircum> <minus>", 0x207B)
CheckCompUni("<asciicircum> <KP_Subtract>", 0x207B)
CheckCompUni("<underscore> <minus>", 0x208B)
CheckCompUni("<underbar> <minus>", 0x208B)
CheckCompUni("<underscore> <KP_Subtract>", 0x208B)
CheckCompUni("<underbar> <KP_Subtract>", 0x208B)
CheckCompUni("<asciicircum> <Greek_beta>", 0x1D5D)
CheckCompUni("<asciicircum> <Greek_gamma>", 0x1D5E)
CheckCompUni("<asciicircum> <Greek_delta>", 0x1D5F)
CheckCompUni("<asciicircum> <Greek_phi>", 0x1D60)
CheckCompUni("<asciicircum> <Greek_chi>", 0x1D61)
CheckCompUni("<asciicircum> <Greek_theta>", 0x1DBF)
CheckCompUni("<underscore> <Greek_beta>", 0x1D66)
CheckCompUni("<underbar> <Greek_beta>", 0x1D66)
CheckCompUni("<underscore> <Greek_gamma>", 0x1D67)
CheckCompUni("<underbar> <Greek_gamma>", 0x1D67)
CheckCompUni("<underscore> <Greek_rho>", 0x1D68)
CheckCompUni("<underbar> <Greek_rho>", 0x1D68)
CheckCompUni("<underscore> <Greek_phi>", 0x1D69)
CheckCompUni("<underbar> <Greek_phi>", 0x1D69)
CheckCompUni("<underscore> <Greek_chi>", 0x1D6A)
CheckCompUni("<underbar> <Greek_chi>", 0x1D6A)
CheckCompUni("<s> <c> <g>", 0x210A)
CheckCompUni("<s> <c> <H>", 0x210B)
CheckCompUni("<s> <c> <I>", 0x2110)
CheckCompUni("<s> <c> <L>", 0x2112)
CheckCompUni("<s> <c> <l>", 0x2113)
CheckCompUni("<e> <l> <l>", 0x2113)
CheckCompUni("<s> <c> <P>", 0x2118)
CheckCompUni("<s> <c> <R>", 0x211B)
CheckCompUni("<s> <c> <B>", 0x212C)
CheckCompUni("<s> <c> <e>", 0x212F)
CheckCompUni("<s> <c> <E>", 0x2130)
CheckCompUni("<s> <c> <F>", 0x2131)
CheckCompUni("<s> <c> <M>", 0x2133)
CheckCompUni("<s> <c> <o>", 0x2134)
CheckCompUni("<p> <h> <space>", 0x210E)
CheckCompUni("<minus> <p> <h>", 0x210F)
CheckCompUni("<p> <h> <minus>", 0x210F)
CheckCompUni("<KP_Subtract> <p> <h>", 0x210F)
CheckCompUni("<p> <h> <KP_Subtract>", 0x210F)
CheckCompUni("<degree> <C>", 0x2103)
CheckCompUni("<degree> <F>", 0x2109)
CheckCompUni("<w> <degree>", 0xB0)
CheckCompUni("<w> <apostrophe>", 0x2032)
CheckCompUni("<w> <quotedbl>", 0x2033)
CheckCompUni("<Greek_mu> <l>", 0x3395)
CheckCompUni("<Greek_mu> <U2113>", 0x3395)
CheckCompUni("<m> <l>", 0x3396)
CheckCompUni("<m> <U2113>", 0x3396)
CheckCompUni("<d> <l>", 0x3397)
CheckCompUni("<d> <U2113>", 0x3397)
CheckCompUni("<k> <l>", 0x3398)
CheckCompUni("<k> <U2113>", 0x3398)
CheckCompUni("<f> <m>", 0x3399)
CheckCompUni("<n> <m>", 0x339A)
CheckCompUni("<Greek_mu> <m>", 0x339B)
CheckCompUni("<m> <m>", 0x339C)
CheckCompUni("<c> <m>", 0x339D)
CheckCompUni("<k> <m>", 0x339E)
CheckCompUni("<Greek_mu> <g>", 0x338D)
CheckCompUni("<m> <g>", 0x338E)
CheckCompUni("<k> <g>", 0x338F)
CheckCompUni("<H> <z>", 0x3390)
CheckCompUni("<k> <H> <z>", 0x3391)
CheckCompUni("<M> <H> <z>", 0x3392)
CheckCompUni("<2> <m> <m>", 0x339F)
CheckCompUni("<2> <c> <m>", 0x33A0)
CheckCompUni("<2> <m> <space>", 0x33A1)
CheckCompUni("<2> <k> <m>", 0x33A2)
CheckCompUni("<KP_2> <m> <m>", 0x339F)
CheckCompUni("<KP_2> <c> <m>", 0x33A0)
CheckCompUni("<KP_2> <m> <space>", 0x33A1)
CheckCompUni("<KP_2> <k> <m>", 0x33A2)
CheckCompUni("<3> <m> <m>", 0x33A3)
CheckCompUni("<3> <c> <m>", 0x33A4)
CheckCompUni("<3> <m> <space>", 0x33A5)
CheckCompUni("<3> <k> <m>", 0x33A6)
CheckCompUni("<KP_3> <m> <m>", 0x33A3)
CheckCompUni("<KP_3> <c> <m>", 0x33A4)
CheckCompUni("<KP_3> <m> <space>", 0x33A5)
CheckCompUni("<KP_3> <k> <m>", 0x33A6)
CheckCompUni("<m> <s>", 0x33A7)
CheckCompUni("<m> <2> <s>", 0x33A8)
CheckCompUni("<m> <KP_2> <s>", 0x33A8)
CheckCompUni("<m> <o> <l>", 0x33D6)
CheckCompUni("<colon> <parenright>", 0x263A)
CheckCompUni("<colon> <parenleft>", 0x2639)
CheckCompUni("<t> <m>", 0x2122)
CheckCompUni("<c> <KP_Divide> <o>", 0x2105)
CheckCompUni("<femalesymbol> <femalesymbol>", 0x26A2)
CheckCompUni("<malesymbol> <malesymbol>", 0x26A3)
CheckCompUni("<femalesymbol> <malesymbol>", 0x26A4)
CheckCompUni("<malesymbol> <femalesymbol>", 0x26A5)
CheckCompUni("<underscore> <underscore>", 0x332)
CheckCompUni("<apostrophe> <space>", 0x27)
CheckCompUni("<space> <greater>", 0x5E)
CheckCompUni("<greater> <space>", 0x5E)
CheckCompUni("<space> <asciicircum>", 0x5E)
CheckCompUni("<asciicircum> <space>", 0x5E)
CheckCompUni("<space> <minus>", 0x7E)
CheckCompUni("<minus> <space>", 0x7E)
CheckCompUni("<space> <asciitilde>", 0x7E)
CheckCompUni("<asciitilde> <space>", 0x7E)
CheckCompUni("<A> <T>", 0x40)
CheckCompUni("<less> <slash>", 0x5C5C)
CheckCompUni("<slash> <less>", 0x5C5C)
CheckCompUni("<slash> <slash>", 0x5C5C)
CheckCompUni("<l> <v>", 0x7C)
CheckCompUni("<v> <l>", 0x7C)
CheckCompUni("<L> <V>", 0x7C)
CheckCompUni("<V> <L>", 0x7C)
CheckCompUni("<asciicircum> <slash>", 0x7C)
CheckCompUni("<slash> <asciicircum>", 0x7C)
CheckCompUni("<minus> <parenleft>", 0x7B)
CheckCompUni("<parenleft> <minus>", 0x7B)
CheckCompUni("<minus> <parenright>", 0x7D)
CheckCompUni("<parenright> <minus>", 0x7D)
CheckCompUni("<parenleft> <parenleft>", 0x5B)
CheckCompUni("<parenright> <parenright>", 0x5D)
CheckCompUni("<space> <comma>", 0xB8)
CheckCompUni("<comma> <space>", 0xB8)
CheckCompUni("<space> <grave>", 0x60)
CheckCompUni("<grave> <space>", 0x60)
CheckCompUni("<plus> <plus>", 0x23)
CheckCompUni("<apostrophe> <A>", 0xC1)
CheckCompUni("<acute> <A>", 0xC1)
CheckCompUni("<apostrophe> <a>", 0xE1)
CheckCompUni("<acute> <a>", 0xE1)
CheckCompUni("<b> <A>", 0x102)
CheckCompUni("<U> <A>", 0x102)
CheckCompUni("<b> <a>", 0x103)
CheckCompUni("<U> <a>", 0x103)
CheckCompUni("<asciicircum> <A>", 0xC2)
CheckCompUni("<asciicircum> <a>", 0xE2)
CheckCompUni("<quotedbl> <A>", 0xC4)
CheckCompUni("<quotedbl> <a>", 0xE4)
CheckCompUni("<A> <E>", 0xC6)
CheckCompUni("<a> <e>", 0xE6)
CheckCompUni("<grave> <A>", 0xC0)
CheckCompUni("<grave> <a>", 0xE0)
CheckCompUni("<underscore> <A>", 0x100)
CheckCompUni("<macron> <A>", 0x100)
CheckCompUni("<underscore> <a>", 0x101)
CheckCompUni("<macron> <a>", 0x101)
CheckCompUni("<semicolon> <A>", 0x104)
CheckCompUni("<semicolon> <a>", 0x105)
CheckCompUni("<o> <A>", 0xC5)
CheckCompUni("<o> <a>", 0xE5)
CheckCompUni("<asciitilde> <A>", 0xC3)
CheckCompUni("<asciitilde> <a>", 0xE3)
CheckCompUni("<exclam> <asciicircum>", 0xA6)
CheckCompUni("<period> <C>", 0x10A)
CheckCompUni("<period> <c>", 0x10B)
CheckCompUni("<apostrophe> <C>", 0x106)
CheckCompUni("<acute> <C>", 0x106)
CheckCompUni("<apostrophe> <c>", 0x107)
CheckCompUni("<acute> <c>", 0x107)
CheckCompUni("<c> <C>", 0x10C)
CheckCompUni("<c> <c>", 0x10D)
CheckCompUni("<comma> <C>", 0xC7)
CheckCompUni("<comma> <c>", 0xE7)
CheckCompUni("<asciicircum> <C>", 0x108)
CheckCompUni("<asciicircum> <c>", 0x109)
CheckCompUni("<slash> <C>", 0xA2)
CheckCompUni("<slash> <c>", 0xA2)
CheckCompUni("<C> <slash>", 0xA2)
CheckCompUni("<c> <slash>", 0xA2)
CheckCompUni("<C> <bar>", 0xA2)
CheckCompUni("<c> <bar>", 0xA2)
CheckCompUni("<bar> <C>", 0xA2)
CheckCompUni("<bar> <c>", 0xA2)
CheckCompUni("<slash> <C>", 0x20A1)
CheckCompUni("<C> <slash>", 0x20A1)
CheckCompUni("<O> <C>", 0xA9)
CheckCompUni("<O> <c>", 0xA9)
CheckCompUni("<o> <C>", 0xA9)
CheckCompUni("<o> <c>", 0xA9)
CheckCompUni("<C> <r>", 0x20A2)
CheckCompUni("<x> <o>", 0xA4)
CheckCompUni("<o> <x>", 0xA4)
CheckCompUni("<c> <D>", 0x10E)
CheckCompUni("<c> <d>", 0x10F)
CheckCompUni("<o> <o>", 0xB0)
CheckCompUni("<minus> <colon>", 0xF7)
CheckCompUni("<colon> <minus>", 0xF7)
CheckCompUni("<d> <minus>", 0x20AB)
CheckCompUni("<quotedbl> <comma>", 0x201E)
CheckCompUni("<comma> <quotedbl>", 0x201E)
CheckCompUni("<minus> <D>", 0x110)
CheckCompUni("<minus> <d>", 0x111)
CheckCompUni("<KP_Divide> <D>", 0x110)
CheckCompUni("<slash> <D>", 0x110)
CheckCompUni("<KP_Divide> <d>", 0x111)
CheckCompUni("<slash> <d>", 0x111)
CheckCompUni("<period> <E>", 0x116)
CheckCompUni("<period> <e>", 0x117)
CheckCompUni("<apostrophe> <E>", 0xC9)
CheckCompUni("<acute> <E>", 0xC9)
CheckCompUni("<apostrophe> <e>", 0xE9)
CheckCompUni("<acute> <e>", 0xE9)
CheckCompUni("<c> <E>", 0x11A)
CheckCompUni("<c> <e>", 0x11B)
CheckCompUni("<asciicircum> <E>", 0xCA)
CheckCompUni("<asciicircum> <e>", 0xEA)
CheckCompUni("<C> <E>", 0x20A0)
CheckCompUni("<quotedbl> <E>", 0xCB)
CheckCompUni("<quotedbl> <e>", 0xEB)
CheckCompUni("<grave> <E>", 0xC8)
CheckCompUni("<grave> <e>", 0xE8)
CheckCompUni("<underscore> <E>", 0x112)
CheckCompUni("<macron> <E>", 0x112)
CheckCompUni("<underscore> <e>", 0x113)
CheckCompUni("<macron> <e>", 0x113)
CheckCompUni("<minus> <minus> <minus>", 0x2014)
CheckCompUni("<minus> <minus> <period>", 0x2013)
CheckCompUni("<N> <G>", 0x14A)
CheckCompUni("<n> <g>", 0x14B)
CheckCompUni("<semicolon> <E>", 0x118)
CheckCompUni("<semicolon> <e>", 0x119)
CheckCompUni("<D> <H>", 0xD0)
CheckCompUni("<d> <h>", 0xF0)
CheckCompUni("<equal> <E>", 0x20AC)
CheckCompUni("<E> <equal>", 0x20AC)
CheckCompUni("<equal> <C>", 0x20AC)
CheckCompUni("<C> <equal>", 0x20AC)
CheckCompUni("<exclam> <exclam>", 0xA1)
CheckCompUni("<F> <r>", 0x20A3)
CheckCompUni("<period> <G>", 0x120)
CheckCompUni("<period> <g>", 0x121)
CheckCompUni("<b> <G>", 0x11E)
CheckCompUni("<U> <G>", 0x11E)
CheckCompUni("<b> <g>", 0x11F)
CheckCompUni("<U> <g>", 0x11F)
CheckCompUni("<comma> <G>", 0x122)
CheckCompUni("<comma> <g>", 0x123)
CheckCompUni("<asciicircum> <G>", 0x11C)
CheckCompUni("<asciicircum> <g>", 0x11D)
CheckCompUni("<diaeresis> <combining_acute>", 0x385)
CheckCompUni("<diaeresis> <apostrophe>", 0x385)
CheckCompUni("<diaeresis> <acute>", 0x385)
CheckCompUni("<diaeresis> <dead_acute>", 0x385)
CheckCompUni("<apostrophe> <Greek_ALPHA>", 0x386)
CheckCompUni("<acute> <Greek_ALPHA>", 0x386)
CheckCompUni("<apostrophe> <Greek_alpha>", 0x3AC)
CheckCompUni("<acute> <Greek_alpha>", 0x3AC)
CheckCompUni("<apostrophe> <Greek_EPSILON>", 0x388)
CheckCompUni("<acute> <Greek_EPSILON>", 0x388)
CheckCompUni("<apostrophe> <Greek_epsilon>", 0x3AD)
CheckCompUni("<acute> <Greek_epsilon>", 0x3AD)
CheckCompUni("<apostrophe> <Greek_ETA>", 0x389)
CheckCompUni("<acute> <Greek_ETA>", 0x389)
CheckCompUni("<apostrophe> <Greek_eta>", 0x3AE)
CheckCompUni("<acute> <Greek_eta>", 0x3AE)
CheckCompUni("<apostrophe> <Greek_IOTA>", 0x38A)
CheckCompUni("<acute> <Greek_IOTA>", 0x38A)
CheckCompUni("<apostrophe> <Greek_iota>", 0x3AF)
CheckCompUni("<acute> <Greek_iota>", 0x3AF)
CheckCompUni("<apostrophe> <quotedbl> <Greek_iota>", 0x390)
CheckCompUni("<apostrophe> <dead_diaeresis> <Greek_iota>", 0x390)
CheckCompUni("<acute> <quotedbl> <Greek_iota>", 0x390)
CheckCompUni("<acute> <dead_diaeresis> <Greek_iota>", 0x390)
CheckCompUni("<apostrophe> <Greek_iotadieresis>", 0x390)
CheckCompUni("<acute> <Greek_iotadieresis>", 0x390)
CheckCompUni("<quotedbl> <Greek_IOTA>", 0x3AA)
CheckCompUni("<quotedbl> <Greek_iota>", 0x3CA)
CheckCompUni("<apostrophe> <Greek_OMEGA>", 0x38F)
CheckCompUni("<acute> <Greek_OMEGA>", 0x38F)
CheckCompUni("<apostrophe> <Greek_omega>", 0x3CE)
CheckCompUni("<acute> <Greek_omega>", 0x3CE)
CheckCompUni("<apostrophe> <Greek_OMICRON>", 0x38C)
CheckCompUni("<acute> <Greek_OMICRON>", 0x38C)
CheckCompUni("<apostrophe> <Greek_omicron>", 0x3CC)
CheckCompUni("<acute> <Greek_omicron>", 0x3CC)
CheckCompUni("<apostrophe> <Greek_UPSILON>", 0x38E)
CheckCompUni("<acute> <Greek_UPSILON>", 0x38E)
CheckCompUni("<apostrophe> <Greek_upsilon>", 0x3CD)
CheckCompUni("<acute> <Greek_upsilon>", 0x3CD)
CheckCompUni("<apostrophe> <quotedbl> <Greek_upsilon>", 0x3B0)
CheckCompUni("<apostrophe> <dead_diaeresis> <Greek_upsilon>", 0x3B0)
CheckCompUni("<acute> <quotedbl> <Greek_upsilon>", 0x3B0)
CheckCompUni("<acute> <dead_diaeresis> <Greek_upsilon>", 0x3B0)
CheckCompUni("<apostrophe> <Greek_upsilondieresis>", 0x3B0)
CheckCompUni("<acute> <Greek_upsilondieresis>", 0x3B0)
CheckCompUni("<quotedbl> <Greek_UPSILON>", 0x3AB)
CheckCompUni("<quotedbl> <Greek_upsilon>", 0x3CB)
CheckCompUni("<less> <less>", 0xAB)
CheckCompUni("<greater> <greater>", 0xBB)
CheckCompUni("<asciicircum> <H>", 0x124)
CheckCompUni("<asciicircum> <h>", 0x125)
CheckCompUni("<KP_Divide> <H>", 0x126)
CheckCompUni("<slash> <H>", 0x126)
CheckCompUni("<KP_Divide> <h>", 0x127)
CheckCompUni("<slash> <h>", 0x127)
CheckCompUni("<period> <I>", 0x130)
CheckCompUni("<apostrophe> <I>", 0xCD)
CheckCompUni("<acute> <I>", 0xCD)
CheckCompUni("<apostrophe> <i>", 0xED)
CheckCompUni("<acute> <i>", 0xED)
CheckCompUni("<asciicircum> <I>", 0xCE)
CheckCompUni("<asciicircum> <i>", 0xEE)
CheckCompUni("<quotedbl> <I>", 0xCF)
CheckCompUni("<quotedbl> <i>", 0xEF)
CheckCompUni("<i> <period>", 0x131)
CheckCompUni("<grave> <I>", 0xCC)
CheckCompUni("<grave> <i>", 0xEC)
CheckCompUni("<underscore> <I>", 0x12A)
CheckCompUni("<macron> <I>", 0x12A)
CheckCompUni("<underscore> <i>", 0x12B)
CheckCompUni("<macron> <i>", 0x12B)
CheckCompUni("<semicolon> <I>", 0x12E)
CheckCompUni("<semicolon> <i>", 0x12F)
CheckCompUni("<asciitilde> <I>", 0x128)
CheckCompUni("<asciitilde> <i>", 0x129)
CheckCompUni("<asciicircum> <J>", 0x134)
CheckCompUni("<asciicircum> <j>", 0x135)
CheckCompUni("<comma> <K>", 0x136)
CheckCompUni("<comma> <k>", 0x137)
CheckCompUni("<k> <k>", 0x138)
CheckCompUni("<apostrophe> <L>", 0x139)
CheckCompUni("<acute> <L>", 0x139)
CheckCompUni("<apostrophe> <l>", 0x13A)
CheckCompUni("<acute> <l>", 0x13A)
CheckCompUni("<c> <L>", 0x13D)
CheckCompUni("<c> <l>", 0x13E)
CheckCompUni("<comma> <L>", 0x13B)
CheckCompUni("<comma> <l>", 0x13C)
CheckCompUni("<quotedbl> <less>", 0x201C)
CheckCompUni("<less> <quotedbl>", 0x201C)
CheckCompUni("<apostrophe> <less>", 0x2018)
CheckCompUni("<less> <apostrophe>", 0x2018)
CheckCompUni("<equal> <L>", 0x20A4)
CheckCompUni("<L> <equal>", 0x20A4)
CheckCompUni("<KP_Divide> <L>", 0x141)
CheckCompUni("<slash> <L>", 0x141)
CheckCompUni("<KP_Divide> <l>", 0x142)
CheckCompUni("<slash> <l>", 0x142)
CheckCompUni("<asciicircum> <underbar> <o>", 0xBA)
CheckCompUni("<asciicircum> <underscore> <o>", 0xBA)
CheckCompUni("<slash> <m>", 0x20A5)
CheckCompUni("<m> <slash>", 0x20A5)
CheckCompUni("<m> <u>", 0xB5)
CheckCompUni("<x> <x>", 0xD7)
CheckCompUni("<numbersign> <b>", 0x266D)
CheckCompUni("<numbersign> <numbersign>", 0x266F)
CheckCompUni("<apostrophe> <N>", 0x143)
CheckCompUni("<acute> <N>", 0x143)
CheckCompUni("<apostrophe> <n>", 0x144)
CheckCompUni("<acute> <n>", 0x144)
CheckCompUni("<equal> <N>", 0x20A6)
CheckCompUni("<N> <equal>", 0x20A6)
CheckCompUni("<c> <N>", 0x147)
CheckCompUni("<c> <n>", 0x148)
CheckCompUni("<comma> <N>", 0x145)
CheckCompUni("<comma> <n>", 0x146)
CheckCompUni("<space> <space>", 0xA0)
CheckCompUni("<KP_Equal> <U0338>", 0x2260)
CheckCompUni("<equal> <U0338>", 0x2260)
CheckCompUni("<minus> <comma>", 0xAC)
CheckCompUni("<comma> <minus>", 0xAC)
CheckCompUni("<asciitilde> <N>", 0xD1)
CheckCompUni("<asciitilde> <n>", 0xF1)
CheckCompUni("<apostrophe> <O>", 0xD3)
CheckCompUni("<acute> <O>", 0xD3)
CheckCompUni("<apostrophe> <o>", 0xF3)
CheckCompUni("<acute> <o>", 0xF3)
CheckCompUni("<asciicircum> <O>", 0xD4)
CheckCompUni("<asciicircum> <o>", 0xF4)
CheckCompUni("<quotedbl> <O>", 0xD6)
CheckCompUni("<quotedbl> <o>", 0xF6)
CheckCompUni("<equal> <O>", 0x150)
CheckCompUni("<equal> <o>", 0x151)
CheckCompUni("<O> <E>", 0x152)
CheckCompUni("<o> <e>", 0x153)
CheckCompUni("<grave> <O>", 0xD2)
CheckCompUni("<grave> <o>", 0xF2)
CheckCompUni("<underscore> <O>", 0x14C)
CheckCompUni("<macron> <O>", 0x14C)
CheckCompUni("<underscore> <o>", 0x14D)
CheckCompUni("<macron> <o>", 0x14D)
CheckCompUni("<1> <2>", 0xBD)
CheckCompUni("<1> <4>", 0xBC)
CheckCompUni("<asciicircum> <KP_1>", 0xB9)
CheckCompUni("<asciicircum> <1>", 0xB9)
CheckCompUni("<KP_Divide> <O>", 0xD8)
CheckCompUni("<slash> <O>", 0xD8)
CheckCompUni("<asciicircum> <underbar> <a>", 0xAA)
CheckCompUni("<asciicircum> <underscore> <a>", 0xAA)
CheckCompUni("<KP_Divide> <o>", 0xF8)
CheckCompUni("<slash> <o>", 0xF8)
CheckCompUni("<asciitilde> <O>", 0xD5)
CheckCompUni("<asciitilde> <o>", 0xF5)
CheckCompUni("<P> <exclam>", 0xB6)
CheckCompUni("<p> <exclam>", 0xB6)
CheckCompUni("<P> <P>", 0xB6)
CheckCompUni("<period> <period>", 0xB7)
CheckCompUni("<P> <t>", 0x20A7)
CheckCompUni("<plus> <minus>", 0xB1)
CheckCompUni("<space> <period>", 0x2008)
CheckCompUni("<question> <question>", 0xBF)
CheckCompUni("<apostrophe> <R>", 0x154)
CheckCompUni("<acute> <R>", 0x154)
CheckCompUni("<apostrophe> <r>", 0x155)
CheckCompUni("<acute> <r>", 0x155)
CheckCompUni("<c> <R>", 0x158)
CheckCompUni("<c> <r>", 0x159)
CheckCompUni("<comma> <R>", 0x156)
CheckCompUni("<comma> <r>", 0x157)
CheckCompUni("<O> <R>", 0xAE)
CheckCompUni("<O> <r>", 0xAE)
CheckCompUni("<o> <R>", 0xAE)
CheckCompUni("<o> <r>", 0xAE)
CheckCompUni("<quotedbl> <greater>", 0x201D)
CheckCompUni("<greater> <quotedbl>", 0x201D)
CheckCompUni("<apostrophe> <greater>", 0x2019)
CheckCompUni("<greater> <apostrophe>", 0x2019)
CheckCompUni("<R> <s>", 0x20A8)
CheckCompUni("<apostrophe> <S>", 0x15A)
CheckCompUni("<acute> <S>", 0x15A)
CheckCompUni("<apostrophe> <s>", 0x15B)
CheckCompUni("<acute> <s>", 0x15B)
CheckCompUni("<c> <S>", 0x160)
CheckCompUni("<c> <s>", 0x161)
CheckCompUni("<comma> <S>", 0x15E)
CheckCompUni("<comma> <s>", 0x15F)
CheckCompUni("<asciicircum> <S>", 0x15C)
CheckCompUni("<asciicircum> <s>", 0x15D)
CheckCompUni("<o> <s>", 0xA7)
CheckCompUni("<s> <o>", 0xA7)
CheckCompUni("<apostrophe> <comma>", 0x201A)
CheckCompUni("<comma> <apostrophe>", 0x201A)
CheckCompUni("<s> <s>", 0xDF)
CheckCompUni("<minus> <L>", 0xA3)
CheckCompUni("<L> <minus>", 0xA3)
CheckCompUni("<c> <T>", 0x164)
CheckCompUni("<c> <t>", 0x165)
CheckCompUni("<comma> <T>", 0x162)
CheckCompUni("<comma> <t>", 0x163)
CheckCompUni("<T> <H>", 0xDE)
CheckCompUni("<t> <h>", 0xFE)
CheckCompUni("<3> <4>", 0xBE)
CheckCompUni("<asciicircum> <KP_3>", 0xB3)
CheckCompUni("<asciicircum> <3>", 0xB3)
CheckCompUni("<asciicircum> <T> <M>", 0x2122)
CheckCompUni("<KP_Divide> <T>", 0x166)
CheckCompUni("<slash> <T>", 0x166)
CheckCompUni("<KP_Divide> <t>", 0x167)
CheckCompUni("<slash> <t>", 0x167)
CheckCompUni("<asciicircum> <KP_2>", 0xB2)
CheckCompUni("<asciicircum> <KP_Space>", 0xB2)
CheckCompUni("<asciicircum> <2>", 0xB2)
CheckCompUni("<b> <E>", 0x114)
CheckCompUni("<U> <E>", 0x114)
CheckCompUni("<b> <e>", 0x115)
CheckCompUni("<U> <e>", 0x115)
CheckCompUni("<b> <I>", 0x12C)
CheckCompUni("<U> <I>", 0x12C)
CheckCompUni("<b> <i>", 0x12D)
CheckCompUni("<U> <i>", 0x12D)
CheckCompUni("<b> <O>", 0x14E)
CheckCompUni("<U> <O>", 0x14E)
CheckCompUni("<b> <o>", 0x14F)
CheckCompUni("<U> <o>", 0x14F)
CheckCompUni("<asciicircum> <W>", 0x174)
CheckCompUni("<asciicircum> <w>", 0x175)
CheckCompUni("<asciicircum> <Y>", 0x176)
CheckCompUni("<asciicircum> <y>", 0x177)
CheckCompUni("<f> <S>", 0x17F)
CheckCompUni("<f> <s>", 0x17F)
CheckCompUni("<KP_Divide> <b>", 0x180)
CheckCompUni("<slash> <b>", 0x180)
CheckCompUni("<KP_Divide> <I>", 0x197)
CheckCompUni("<slash> <I>", 0x197)
CheckCompUni("<plus> <O>", 0x1A0)
CheckCompUni("<plus> <o>", 0x1A1)
CheckCompUni("<plus> <U>", 0x1AF)
CheckCompUni("<plus> <u>", 0x1B0)
CheckCompUni("<KP_Divide> <Z>", 0x1B5)
CheckCompUni("<slash> <Z>", 0x1B5)
CheckCompUni("<KP_Divide> <z>", 0x1B6)
CheckCompUni("<slash> <z>", 0x1B6)
CheckCompUni("<c> <A>", 0x1CD)
CheckCompUni("<c> <a>", 0x1CE)
CheckCompUni("<c> <I>", 0x1CF)
CheckCompUni("<c> <i>", 0x1D0)
CheckCompUni("<c> <O>", 0x1D1)
CheckCompUni("<c> <o>", 0x1D2)
CheckCompUni("<c> <U>", 0x1D3)
CheckCompUni("<c> <u>", 0x1D4)
CheckCompUni("<underscore> <quotedbl> <U>", 0x1D5)
CheckCompUni("<underscore> <dead_diaeresis> <U>", 0x1D5)
CheckCompUni("<macron> <quotedbl> <U>", 0x1D5)
CheckCompUni("<macron> <dead_diaeresis> <U>", 0x1D5)
CheckCompUni("<underscore> <Udiaeresis>", 0x1D5)
CheckCompUni("<macron> <Udiaeresis>", 0x1D5)
CheckCompUni("<underscore> <quotedbl> <u>", 0x1D6)
CheckCompUni("<underscore> <dead_diaeresis> <u>", 0x1D6)
CheckCompUni("<macron> <quotedbl> <u>", 0x1D6)
CheckCompUni("<macron> <dead_diaeresis> <u>", 0x1D6)
CheckCompUni("<underscore> <udiaeresis>", 0x1D6)
CheckCompUni("<macron> <udiaeresis>", 0x1D6)
CheckCompUni("<apostrophe> <quotedbl> <U>", 0x1D7)
CheckCompUni("<apostrophe> <dead_diaeresis> <U>", 0x1D7)
CheckCompUni("<acute> <quotedbl> <U>", 0x1D7)
CheckCompUni("<acute> <dead_diaeresis> <U>", 0x1D7)
CheckCompUni("<apostrophe> <Udiaeresis>", 0x1D7)
CheckCompUni("<acute> <Udiaeresis>", 0x1D7)
CheckCompUni("<apostrophe> <quotedbl> <u>", 0x1D8)
CheckCompUni("<apostrophe> <dead_diaeresis> <u>", 0x1D8)
CheckCompUni("<acute> <quotedbl> <u>", 0x1D8)
CheckCompUni("<acute> <dead_diaeresis> <u>", 0x1D8)
CheckCompUni("<apostrophe> <udiaeresis>", 0x1D8)
CheckCompUni("<acute> <udiaeresis>", 0x1D8)
CheckCompUni("<c> <quotedbl> <U>", 0x1D9)
CheckCompUni("<c> <dead_diaeresis> <U>", 0x1D9)
CheckCompUni("<c> <Udiaeresis>", 0x1D9)
CheckCompUni("<c> <quotedbl> <u>", 0x1DA)
CheckCompUni("<c> <dead_diaeresis> <u>", 0x1DA)
CheckCompUni("<c> <udiaeresis>", 0x1DA)
CheckCompUni("<grave> <quotedbl> <U>", 0x1DB)
CheckCompUni("<grave> <dead_diaeresis> <U>", 0x1DB)
CheckCompUni("<grave> <Udiaeresis>", 0x1DB)
CheckCompUni("<grave> <quotedbl> <u>", 0x1DC)
CheckCompUni("<grave> <dead_diaeresis> <u>", 0x1DC)
CheckCompUni("<grave> <udiaeresis>", 0x1DC)
CheckCompUni("<underscore> <quotedbl> <A>", 0x1DE)
CheckCompUni("<underscore> <dead_diaeresis> <A>", 0x1DE)
CheckCompUni("<macron> <quotedbl> <A>", 0x1DE)
CheckCompUni("<macron> <dead_diaeresis> <A>", 0x1DE)
CheckCompUni("<underscore> <Adiaeresis>", 0x1DE)
CheckCompUni("<macron> <Adiaeresis>", 0x1DE)
CheckCompUni("<underscore> <quotedbl> <a>", 0x1DF)
CheckCompUni("<underscore> <dead_diaeresis> <a>", 0x1DF)
CheckCompUni("<macron> <quotedbl> <a>", 0x1DF)
CheckCompUni("<macron> <dead_diaeresis> <a>", 0x1DF)
CheckCompUni("<underscore> <adiaeresis>", 0x1DF)
CheckCompUni("<macron> <adiaeresis>", 0x1DF)
CheckCompUni("<underscore> <period> <A>", 0x1E0)
CheckCompUni("<underscore> <dead_abovedot> <A>", 0x1E0)
CheckCompUni("<macron> <period> <A>", 0x1E0)
CheckCompUni("<macron> <dead_abovedot> <A>", 0x1E0)
CheckCompUni("<underscore> <U0226>", 0x1E0)
CheckCompUni("<macron> <U0226>", 0x1E0)
CheckCompUni("<underscore> <period> <a>", 0x1E1)
CheckCompUni("<underscore> <dead_abovedot> <a>", 0x1E1)
CheckCompUni("<macron> <period> <a>", 0x1E1)
CheckCompUni("<macron> <dead_abovedot> <a>", 0x1E1)
CheckCompUni("<underscore> <U0227>", 0x1E1)
CheckCompUni("<macron> <U0227>", 0x1E1)
CheckCompUni("<underscore> <AE>", 0x1E2)
CheckCompUni("<macron> <AE>", 0x1E2)
CheckCompUni("<underscore> <ae>", 0x1E3)
CheckCompUni("<macron> <ae>", 0x1E3)
CheckCompUni("<KP_Divide> <G>", 0x1E4)
CheckCompUni("<slash> <G>", 0x1E4)
CheckCompUni("<KP_Divide> <g>", 0x1E5)
CheckCompUni("<slash> <g>", 0x1E5)
CheckCompUni("<c> <G>", 0x1E6)
CheckCompUni("<c> <g>", 0x1E7)
CheckCompUni("<c> <K>", 0x1E8)
CheckCompUni("<c> <k>", 0x1E9)
CheckCompUni("<semicolon> <O>", 0x1EA)
CheckCompUni("<semicolon> <o>", 0x1EB)
CheckCompUni("<underscore> <semicolon> <O>", 0x1EC)
CheckCompUni("<underscore> <dead_ogonek> <O>", 0x1EC)
CheckCompUni("<macron> <semicolon> <O>", 0x1EC)
CheckCompUni("<macron> <dead_ogonek> <O>", 0x1EC)
CheckCompUni("<underscore> <U01ea>", 0x1EC)
CheckCompUni("<macron> <U01ea>", 0x1EC)
CheckCompUni("<underscore> <semicolon> <o>", 0x1ED)
CheckCompUni("<underscore> <dead_ogonek> <o>", 0x1ED)
CheckCompUni("<macron> <semicolon> <o>", 0x1ED)
CheckCompUni("<macron> <dead_ogonek> <o>", 0x1ED)
CheckCompUni("<underscore> <U01eb>", 0x1ED)
CheckCompUni("<macron> <U01eb>", 0x1ED)
CheckCompUni("<c> <U01b7>", 0x1EE)
CheckCompUni("<c> <U0292>", 0x1EF)
CheckCompUni("<c> <j>", 0x1F0)
CheckCompUni("<apostrophe> <G>", 0x1F4)
CheckCompUni("<acute> <G>", 0x1F4)
CheckCompUni("<apostrophe> <g>", 0x1F5)
CheckCompUni("<acute> <g>", 0x1F5)
CheckCompUni("<grave> <N>", 0x1F8)
CheckCompUni("<grave> <n>", 0x1F9)
CheckCompUni("<o> <apostrophe> <A>", 0x1FA)
CheckCompUni("<apostrophe> <dead_abovering> <A>", 0x1FA)
CheckCompUni("<acute> <o> <A>", 0x1FA)
CheckCompUni("<acute> <dead_abovering> <A>", 0x1FA)
CheckCompUni("<apostrophe> <Aring>", 0x1FA)
CheckCompUni("<acute> <Aring>", 0x1FA)
CheckCompUni("<o> <apostrophe> <a>", 0x1FB)
CheckCompUni("<apostrophe> <dead_abovering> <a>", 0x1FB)
CheckCompUni("<acute> <o> <a>", 0x1FB)
CheckCompUni("<acute> <dead_abovering> <a>", 0x1FB)
CheckCompUni("<apostrophe> <aring>", 0x1FB)
CheckCompUni("<acute> <aring>", 0x1FB)
CheckCompUni("<apostrophe> <AE>", 0x1FC)
CheckCompUni("<acute> <AE>", 0x1FC)
CheckCompUni("<apostrophe> <ae>", 0x1FD)
CheckCompUni("<acute> <ae>", 0x1FD)
CheckCompUni("<apostrophe> <KP_Divide> <O>", 0x1FE)
CheckCompUni("<acute> <KP_Divide> <O>", 0x1FE)
CheckCompUni("<apostrophe> <slash> <O>", 0x1FE)
CheckCompUni("<acute> <slash> <O>", 0x1FE)
CheckCompUni("<apostrophe> <Ooblique>", 0x1FE)
CheckCompUni("<acute> <Ooblique>", 0x1FE)
CheckCompUni("<apostrophe> <KP_Divide> <o>", 0x1FF)
CheckCompUni("<acute> <KP_Divide> <o>", 0x1FF)
CheckCompUni("<apostrophe> <slash> <o>", 0x1FF)
CheckCompUni("<acute> <slash> <o>", 0x1FF)
CheckCompUni("<apostrophe> <oslash>", 0x1FF)
CheckCompUni("<acute> <oslash>", 0x1FF)
CheckCompUni("<c> <H>", 0x21E)
CheckCompUni("<c> <h>", 0x21F)
CheckCompUni("<period> <A>", 0x226)
CheckCompUni("<period> <a>", 0x227)
CheckCompUni("<comma> <E>", 0x228)
CheckCompUni("<comma> <e>", 0x229)
CheckCompUni("<underscore> <quotedbl> <O>", 0x22A)
CheckCompUni("<underscore> <dead_diaeresis> <O>", 0x22A)
CheckCompUni("<macron> <quotedbl> <O>", 0x22A)
CheckCompUni("<macron> <dead_diaeresis> <O>", 0x22A)
CheckCompUni("<underscore> <Odiaeresis>", 0x22A)
CheckCompUni("<macron> <Odiaeresis>", 0x22A)
CheckCompUni("<underscore> <quotedbl> <o>", 0x22B)
CheckCompUni("<underscore> <dead_diaeresis> <o>", 0x22B)
CheckCompUni("<macron> <quotedbl> <o>", 0x22B)
CheckCompUni("<macron> <dead_diaeresis> <o>", 0x22B)
CheckCompUni("<underscore> <odiaeresis>", 0x22B)
CheckCompUni("<macron> <odiaeresis>", 0x22B)
CheckCompUni("<underscore> <combining_tilde> <O>", 0x22C)
CheckCompUni("<macron> <combining_tilde> <O>", 0x22C)
CheckCompUni("<underscore> <asciitilde> <O>", 0x22C)
CheckCompUni("<underscore> <dead_tilde> <O>", 0x22C)
CheckCompUni("<macron> <asciitilde> <O>", 0x22C)
CheckCompUni("<macron> <dead_tilde> <O>", 0x22C)
CheckCompUni("<underscore> <Otilde>", 0x22C)
CheckCompUni("<macron> <Otilde>", 0x22C)
CheckCompUni("<underscore> <combining_tilde> <o>", 0x22D)
CheckCompUni("<macron> <combining_tilde> <o>", 0x22D)
CheckCompUni("<underscore> <asciitilde> <o>", 0x22D)
CheckCompUni("<underscore> <dead_tilde> <o>", 0x22D)
CheckCompUni("<macron> <asciitilde> <o>", 0x22D)
CheckCompUni("<macron> <dead_tilde> <o>", 0x22D)
CheckCompUni("<underscore> <otilde>", 0x22D)
CheckCompUni("<macron> <otilde>", 0x22D)
CheckCompUni("<period> <O>", 0x22E)
CheckCompUni("<period> <o>", 0x22F)
CheckCompUni("<underscore> <period> <O>", 0x230)
CheckCompUni("<underscore> <dead_abovedot> <O>", 0x230)
CheckCompUni("<macron> <period> <O>", 0x230)
CheckCompUni("<macron> <dead_abovedot> <O>", 0x230)
CheckCompUni("<underscore> <U022e>", 0x230)
CheckCompUni("<macron> <U022e>", 0x230)
CheckCompUni("<underscore> <period> <o>", 0x231)
CheckCompUni("<underscore> <dead_abovedot> <o>", 0x231)
CheckCompUni("<macron> <period> <o>", 0x231)
CheckCompUni("<macron> <dead_abovedot> <o>", 0x231)
CheckCompUni("<underscore> <U022f>", 0x231)
CheckCompUni("<macron> <U022f>", 0x231)
CheckCompUni("<underscore> <Y>", 0x232)
CheckCompUni("<macron> <Y>", 0x232)
CheckCompUni("<underscore> <y>", 0x233)
CheckCompUni("<macron> <y>", 0x233)
CheckCompUni("<e> <e>", 0x259)
CheckCompUni("<KP_Divide> <i>", 0x268)
CheckCompUni("<slash> <i>", 0x268)
CheckCompUni("<KP_Divide> <U0294>", 0x2A1)
CheckCompUni("<slash> <U0294>", 0x2A1)
CheckCompUni("<asciicircum> <underbar> <h>", 0x2B0)
CheckCompUni("<asciicircum> <underscore> <h>", 0x2B0)
CheckCompUni("<asciicircum> <underbar> <U0266>", 0x2B1)
CheckCompUni("<asciicircum> <underscore> <U0266>", 0x2B1)
CheckCompUni("<asciicircum> <underbar> <j>", 0x2B2)
CheckCompUni("<asciicircum> <underscore> <j>", 0x2B2)
CheckCompUni("<asciicircum> <underbar> <r>", 0x2B3)
CheckCompUni("<asciicircum> <underscore> <r>", 0x2B3)
CheckCompUni("<asciicircum> <underbar> <U0279>", 0x2B4)
CheckCompUni("<asciicircum> <underscore> <U0279>", 0x2B4)
CheckCompUni("<asciicircum> <underbar> <U027b>", 0x2B5)
CheckCompUni("<asciicircum> <underscore> <U027b>", 0x2B5)
CheckCompUni("<asciicircum> <underbar> <U0281>", 0x2B6)
CheckCompUni("<asciicircum> <underscore> <U0281>", 0x2B6)
CheckCompUni("<asciicircum> <underbar> <w>", 0x2B7)
CheckCompUni("<asciicircum> <underscore> <w>", 0x2B7)
CheckCompUni("<asciicircum> <underbar> <y>", 0x2B8)
CheckCompUni("<asciicircum> <underscore> <y>", 0x2B8)
CheckCompUni("<asciicircum> <underbar> <U0263>", 0x2E0)
CheckCompUni("<asciicircum> <underscore> <U0263>", 0x2E0)
CheckCompUni("<asciicircum> <underbar> <l>", 0x2E1)
CheckCompUni("<asciicircum> <underscore> <l>", 0x2E1)
CheckCompUni("<asciicircum> <underbar> <s>", 0x2E2)
CheckCompUni("<asciicircum> <underscore> <s>", 0x2E2)
CheckCompUni("<asciicircum> <underbar> <x>", 0x2E3)
CheckCompUni("<asciicircum> <underscore> <x>", 0x2E3)
CheckCompUni("<asciicircum> <underbar> <U0295>", 0x2E4)
CheckCompUni("<asciicircum> <underscore> <U0295>", 0x2E4)
CheckCompUni("<quotedbl> <combining_acute>", 0x344)
CheckCompUni("<quotedbl> <apostrophe>", 0x344)
CheckCompUni("<quotedbl> <acute>", 0x344)
CheckCompUni("<quotedbl> <dead_acute>", 0x344)
CheckCompUni("<apostrophe> <U03d2>", 0x3D3)
CheckCompUni("<acute> <U03d2>", 0x3D3)
CheckCompUni("<quotedbl> <U03d2>", 0x3D4)
CheckCompUni("<period> <B>", 0x1E02)
CheckCompUni("<period> <b>", 0x1E03)
CheckCompUni("<exclam> <B>", 0x1E04)
CheckCompUni("<exclam> <b>", 0x1E05)
CheckCompUni("<apostrophe> <comma> <C>", 0x1E08)
CheckCompUni("<apostrophe> <dead_cedilla> <C>", 0x1E08)
CheckCompUni("<acute> <comma> <C>", 0x1E08)
CheckCompUni("<acute> <dead_cedilla> <C>", 0x1E08)
CheckCompUni("<apostrophe> <Ccedilla>", 0x1E08)
CheckCompUni("<acute> <Ccedilla>", 0x1E08)
CheckCompUni("<apostrophe> <comma> <c>", 0x1E09)
CheckCompUni("<apostrophe> <dead_cedilla> <c>", 0x1E09)
CheckCompUni("<acute> <comma> <c>", 0x1E09)
CheckCompUni("<acute> <dead_cedilla> <c>", 0x1E09)
CheckCompUni("<apostrophe> <ccedilla>", 0x1E09)
CheckCompUni("<acute> <ccedilla>", 0x1E09)
CheckCompUni("<period> <D>", 0x1E0A)
CheckCompUni("<period> <d>", 0x1E0B)
CheckCompUni("<exclam> <D>", 0x1E0C)
CheckCompUni("<exclam> <d>", 0x1E0D)
CheckCompUni("<comma> <D>", 0x1E10)
CheckCompUni("<comma> <d>", 0x1E11)
CheckCompUni("<grave> <underscore> <E>", 0x1E14)
CheckCompUni("<grave> <macron> <E>", 0x1E14)
CheckCompUni("<grave> <dead_macron> <E>", 0x1E14)
CheckCompUni("<grave> <Emacron>", 0x1E14)
CheckCompUni("<grave> <underscore> <e>", 0x1E15)
CheckCompUni("<grave> <macron> <e>", 0x1E15)
CheckCompUni("<grave> <dead_macron> <e>", 0x1E15)
CheckCompUni("<grave> <emacron>", 0x1E15)
CheckCompUni("<apostrophe> <underscore> <E>", 0x1E16)
CheckCompUni("<apostrophe> <macron> <E>", 0x1E16)
CheckCompUni("<apostrophe> <dead_macron> <E>", 0x1E16)
CheckCompUni("<acute> <underscore> <E>", 0x1E16)
CheckCompUni("<acute> <macron> <E>", 0x1E16)
CheckCompUni("<acute> <dead_macron> <E>", 0x1E16)
CheckCompUni("<apostrophe> <Emacron>", 0x1E16)
CheckCompUni("<acute> <Emacron>", 0x1E16)
CheckCompUni("<apostrophe> <underscore> <e>", 0x1E17)
CheckCompUni("<apostrophe> <macron> <e>", 0x1E17)
CheckCompUni("<apostrophe> <dead_macron> <e>", 0x1E17)
CheckCompUni("<acute> <underscore> <e>", 0x1E17)
CheckCompUni("<acute> <macron> <e>", 0x1E17)
CheckCompUni("<acute> <dead_macron> <e>", 0x1E17)
CheckCompUni("<apostrophe> <emacron>", 0x1E17)
CheckCompUni("<acute> <emacron>", 0x1E17)
CheckCompUni("<b> <comma> <E>", 0x1E1C)
CheckCompUni("<b> <dead_cedilla> <E>", 0x1E1C)
CheckCompUni("<U> <comma> <E>", 0x1E1C)
CheckCompUni("<U> <dead_cedilla> <E>", 0x1E1C)
CheckCompUni("<b> <U0228>", 0x1E1C)
CheckCompUni("<U> <U0228>", 0x1E1C)
CheckCompUni("<b> <comma> <e>", 0x1E1D)
CheckCompUni("<b> <dead_cedilla> <e>", 0x1E1D)
CheckCompUni("<U> <comma> <e>", 0x1E1D)
CheckCompUni("<U> <dead_cedilla> <e>", 0x1E1D)
CheckCompUni("<b> <U0229>", 0x1E1D)
CheckCompUni("<U> <U0229>", 0x1E1D)
CheckCompUni("<period> <F>", 0x1E1E)
CheckCompUni("<period> <f>", 0x1E1F)
CheckCompUni("<underscore> <G>", 0x1E20)
CheckCompUni("<macron> <G>", 0x1E20)
CheckCompUni("<underscore> <g>", 0x1E21)
CheckCompUni("<macron> <g>", 0x1E21)
CheckCompUni("<period> <H>", 0x1E22)
CheckCompUni("<period> <h>", 0x1E23)
CheckCompUni("<exclam> <H>", 0x1E24)
CheckCompUni("<exclam> <h>", 0x1E25)
CheckCompUni("<quotedbl> <H>", 0x1E26)
CheckCompUni("<quotedbl> <h>", 0x1E27)
CheckCompUni("<comma> <H>", 0x1E28)
CheckCompUni("<comma> <h>", 0x1E29)
CheckCompUni("<apostrophe> <quotedbl> <I>", 0x1E2E)
CheckCompUni("<apostrophe> <dead_diaeresis> <I>", 0x1E2E)
CheckCompUni("<acute> <quotedbl> <I>", 0x1E2E)
CheckCompUni("<acute> <dead_diaeresis> <I>", 0x1E2E)
CheckCompUni("<apostrophe> <Idiaeresis>", 0x1E2E)
CheckCompUni("<acute> <Idiaeresis>", 0x1E2E)
CheckCompUni("<apostrophe> <quotedbl> <i>", 0x1E2F)
CheckCompUni("<apostrophe> <dead_diaeresis> <i>", 0x1E2F)
CheckCompUni("<acute> <quotedbl> <i>", 0x1E2F)
CheckCompUni("<acute> <dead_diaeresis> <i>", 0x1E2F)
CheckCompUni("<apostrophe> <idiaeresis>", 0x1E2F)
CheckCompUni("<acute> <idiaeresis>", 0x1E2F)
CheckCompUni("<apostrophe> <K>", 0x1E30)
CheckCompUni("<acute> <K>", 0x1E30)
CheckCompUni("<apostrophe> <k>", 0x1E31)
CheckCompUni("<acute> <k>", 0x1E31)
CheckCompUni("<exclam> <K>", 0x1E32)
CheckCompUni("<exclam> <k>", 0x1E33)
CheckCompUni("<exclam> <L>", 0x1E36)
CheckCompUni("<exclam> <l>", 0x1E37)
CheckCompUni("<underscore> <combining_belowdot> <L>", 0x1E38)
CheckCompUni("<macron> <combining_belowdot> <L>", 0x1E38)
CheckCompUni("<underscore> <exclam> <L>", 0x1E38)
CheckCompUni("<underscore> <dead_belowdot> <L>", 0x1E38)
CheckCompUni("<macron> <exclam> <L>", 0x1E38)
CheckCompUni("<macron> <dead_belowdot> <L>", 0x1E38)
CheckCompUni("<underscore> <U1e36>", 0x1E38)
CheckCompUni("<macron> <U1e36>", 0x1E38)
CheckCompUni("<underscore> <combining_belowdot> <l>", 0x1E39)
CheckCompUni("<macron> <combining_belowdot> <l>", 0x1E39)
CheckCompUni("<underscore> <exclam> <l>", 0x1E39)
CheckCompUni("<underscore> <dead_belowdot> <l>", 0x1E39)
CheckCompUni("<macron> <exclam> <l>", 0x1E39)
CheckCompUni("<macron> <dead_belowdot> <l>", 0x1E39)
CheckCompUni("<underscore> <U1e37>", 0x1E39)
CheckCompUni("<macron> <U1e37>", 0x1E39)
CheckCompUni("<apostrophe> <M>", 0x1E3E)
CheckCompUni("<acute> <M>", 0x1E3E)
CheckCompUni("<apostrophe> <m>", 0x1E3F)
CheckCompUni("<acute> <m>", 0x1E3F)
CheckCompUni("<period> <M>", 0x1E40)
CheckCompUni("<period> <m>", 0x1E41)
CheckCompUni("<exclam> <M>", 0x1E42)
CheckCompUni("<exclam> <m>", 0x1E43)
CheckCompUni("<period> <N>", 0x1E44)
CheckCompUni("<period> <n>", 0x1E45)
CheckCompUni("<exclam> <N>", 0x1E46)
CheckCompUni("<exclam> <n>", 0x1E47)
CheckCompUni("<apostrophe> <combining_tilde> <O>", 0x1E4C)
CheckCompUni("<acute> <combining_tilde> <O>", 0x1E4C)
CheckCompUni("<apostrophe> <asciitilde> <O>", 0x1E4C)
CheckCompUni("<apostrophe> <dead_tilde> <O>", 0x1E4C)
CheckCompUni("<acute> <asciitilde> <O>", 0x1E4C)
CheckCompUni("<acute> <dead_tilde> <O>", 0x1E4C)
CheckCompUni("<apostrophe> <Otilde>", 0x1E4C)
CheckCompUni("<acute> <Otilde>", 0x1E4C)
CheckCompUni("<apostrophe> <combining_tilde> <o>", 0x1E4D)
CheckCompUni("<acute> <combining_tilde> <o>", 0x1E4D)
CheckCompUni("<apostrophe> <asciitilde> <o>", 0x1E4D)
CheckCompUni("<apostrophe> <dead_tilde> <o>", 0x1E4D)
CheckCompUni("<acute> <asciitilde> <o>", 0x1E4D)
CheckCompUni("<acute> <dead_tilde> <o>", 0x1E4D)
CheckCompUni("<apostrophe> <otilde>", 0x1E4D)
CheckCompUni("<acute> <otilde>", 0x1E4D)
CheckCompUni("<quotedbl> <combining_tilde> <O>", 0x1E4E)
CheckCompUni("<quotedbl> <asciitilde> <O>", 0x1E4E)
CheckCompUni("<quotedbl> <dead_tilde> <O>", 0x1E4E)
CheckCompUni("<quotedbl> <Otilde>", 0x1E4E)
CheckCompUni("<quotedbl> <combining_tilde> <o>", 0x1E4F)
CheckCompUni("<quotedbl> <asciitilde> <o>", 0x1E4F)
CheckCompUni("<quotedbl> <dead_tilde> <o>", 0x1E4F)
CheckCompUni("<quotedbl> <otilde>", 0x1E4F)
CheckCompUni("<grave> <underscore> <O>", 0x1E50)
CheckCompUni("<grave> <macron> <O>", 0x1E50)
CheckCompUni("<grave> <dead_macron> <O>", 0x1E50)
CheckCompUni("<grave> <Omacron>", 0x1E50)
CheckCompUni("<grave> <underscore> <o>", 0x1E51)
CheckCompUni("<grave> <macron> <o>", 0x1E51)
CheckCompUni("<grave> <dead_macron> <o>", 0x1E51)
CheckCompUni("<grave> <omacron>", 0x1E51)
CheckCompUni("<apostrophe> <underscore> <O>", 0x1E52)
CheckCompUni("<apostrophe> <macron> <O>", 0x1E52)
CheckCompUni("<apostrophe> <dead_macron> <O>", 0x1E52)
CheckCompUni("<acute> <underscore> <O>", 0x1E52)
CheckCompUni("<acute> <macron> <O>", 0x1E52)
CheckCompUni("<acute> <dead_macron> <O>", 0x1E52)
CheckCompUni("<apostrophe> <Omacron>", 0x1E52)
CheckCompUni("<acute> <Omacron>", 0x1E52)
CheckCompUni("<apostrophe> <underscore> <o>", 0x1E53)
CheckCompUni("<apostrophe> <macron> <o>", 0x1E53)
CheckCompUni("<apostrophe> <dead_macron> <o>", 0x1E53)
CheckCompUni("<acute> <underscore> <o>", 0x1E53)
CheckCompUni("<acute> <macron> <o>", 0x1E53)
CheckCompUni("<acute> <dead_macron> <o>", 0x1E53)
CheckCompUni("<apostrophe> <omacron>", 0x1E53)
CheckCompUni("<acute> <omacron>", 0x1E53)
CheckCompUni("<apostrophe> <P>", 0x1E54)
CheckCompUni("<acute> <P>", 0x1E54)
CheckCompUni("<apostrophe> <p>", 0x1E55)
CheckCompUni("<acute> <p>", 0x1E55)
CheckCompUni("<period> <P>", 0x1E56)
CheckCompUni("<period> <p>", 0x1E57)
CheckCompUni("<period> <R>", 0x1E58)
CheckCompUni("<period> <r>", 0x1E59)
CheckCompUni("<exclam> <R>", 0x1E5A)
CheckCompUni("<exclam> <r>", 0x1E5B)
CheckCompUni("<underscore> <combining_belowdot> <R>", 0x1E5C)
CheckCompUni("<macron> <combining_belowdot> <R>", 0x1E5C)
CheckCompUni("<underscore> <exclam> <R>", 0x1E5C)
CheckCompUni("<underscore> <dead_belowdot> <R>", 0x1E5C)
CheckCompUni("<macron> <exclam> <R>", 0x1E5C)
CheckCompUni("<macron> <dead_belowdot> <R>", 0x1E5C)
CheckCompUni("<underscore> <U1e5a>", 0x1E5C)
CheckCompUni("<macron> <U1e5a>", 0x1E5C)
CheckCompUni("<underscore> <combining_belowdot> <r>", 0x1E5D)
CheckCompUni("<macron> <combining_belowdot> <r>", 0x1E5D)
CheckCompUni("<underscore> <exclam> <r>", 0x1E5D)
CheckCompUni("<underscore> <dead_belowdot> <r>", 0x1E5D)
CheckCompUni("<macron> <exclam> <r>", 0x1E5D)
CheckCompUni("<macron> <dead_belowdot> <r>", 0x1E5D)
CheckCompUni("<underscore> <U1e5b>", 0x1E5D)
CheckCompUni("<macron> <U1e5b>", 0x1E5D)
CheckCompUni("<period> <S>", 0x1E60)
CheckCompUni("<period> <s>", 0x1E61)
CheckCompUni("<exclam> <S>", 0x1E62)
CheckCompUni("<exclam> <s>", 0x1E63)
CheckCompUni("<period> <combining_acute> <S>", 0x1E64)
CheckCompUni("<period> <apostrophe> <S>", 0x1E64)
CheckCompUni("<period> <acute> <S>", 0x1E64)
CheckCompUni("<period> <dead_acute> <S>", 0x1E64)
CheckCompUni("<period> <Sacute>", 0x1E64)
CheckCompUni("<period> <combining_acute> <s>", 0x1E65)
CheckCompUni("<period> <apostrophe> <s>", 0x1E65)
CheckCompUni("<period> <acute> <s>", 0x1E65)
CheckCompUni("<period> <dead_acute> <s>", 0x1E65)
CheckCompUni("<period> <sacute>", 0x1E65)
CheckCompUni("<period> <c> <S>", 0x1E66)
CheckCompUni("<period> <dead_caron> <S>", 0x1E66)
CheckCompUni("<period> <Scaron>", 0x1E66)
CheckCompUni("<period> <c> <s>", 0x1E67)
CheckCompUni("<period> <dead_caron> <s>", 0x1E67)
CheckCompUni("<period> <scaron>", 0x1E67)
CheckCompUni("<period> <combining_belowdot> <S>", 0x1E68)
CheckCompUni("<period> <exclam> <S>", 0x1E68)
CheckCompUni("<period> <dead_belowdot> <S>", 0x1E68)
CheckCompUni("<period> <U1e62>", 0x1E68)
CheckCompUni("<period> <combining_belowdot> <s>", 0x1E69)
CheckCompUni("<period> <exclam> <s>", 0x1E69)
CheckCompUni("<period> <dead_belowdot> <s>", 0x1E69)
CheckCompUni("<period> <U1e63>", 0x1E69)
CheckCompUni("<period> <T>", 0x1E6A)
CheckCompUni("<period> <t>", 0x1E6B)
CheckCompUni("<exclam> <T>", 0x1E6C)
CheckCompUni("<exclam> <t>", 0x1E6D)
CheckCompUni("<apostrophe> <combining_tilde> <U>", 0x1E78)
CheckCompUni("<acute> <combining_tilde> <U>", 0x1E78)
CheckCompUni("<apostrophe> <asciitilde> <U>", 0x1E78)
CheckCompUni("<apostrophe> <dead_tilde> <U>", 0x1E78)
CheckCompUni("<acute> <asciitilde> <U>", 0x1E78)
CheckCompUni("<acute> <dead_tilde> <U>", 0x1E78)
CheckCompUni("<apostrophe> <Utilde>", 0x1E78)
CheckCompUni("<acute> <Utilde>", 0x1E78)
CheckCompUni("<apostrophe> <combining_tilde> <u>", 0x1E79)
CheckCompUni("<acute> <combining_tilde> <u>", 0x1E79)
CheckCompUni("<apostrophe> <asciitilde> <u>", 0x1E79)
CheckCompUni("<apostrophe> <dead_tilde> <u>", 0x1E79)
CheckCompUni("<acute> <asciitilde> <u>", 0x1E79)
CheckCompUni("<acute> <dead_tilde> <u>", 0x1E79)
CheckCompUni("<apostrophe> <utilde>", 0x1E79)
CheckCompUni("<acute> <utilde>", 0x1E79)
CheckCompUni("<quotedbl> <underscore> <U>", 0x1E7A)
CheckCompUni("<quotedbl> <macron> <U>", 0x1E7A)
CheckCompUni("<quotedbl> <dead_macron> <U>", 0x1E7A)
CheckCompUni("<quotedbl> <Umacron>", 0x1E7A)
CheckCompUni("<quotedbl> <underscore> <u>", 0x1E7B)
CheckCompUni("<quotedbl> <macron> <u>", 0x1E7B)
CheckCompUni("<quotedbl> <dead_macron> <u>", 0x1E7B)
CheckCompUni("<quotedbl> <umacron>", 0x1E7B)
CheckCompUni("<asciitilde> <V>", 0x1E7C)
CheckCompUni("<asciitilde> <v>", 0x1E7D)
CheckCompUni("<exclam> <V>", 0x1E7E)
CheckCompUni("<exclam> <v>", 0x1E7F)
CheckCompUni("<grave> <W>", 0x1E80)
CheckCompUni("<grave> <w>", 0x1E81)
CheckCompUni("<apostrophe> <W>", 0x1E82)
CheckCompUni("<acute> <W>", 0x1E82)
CheckCompUni("<apostrophe> <w>", 0x1E83)
CheckCompUni("<acute> <w>", 0x1E83)
CheckCompUni("<quotedbl> <W>", 0x1E84)
CheckCompUni("<quotedbl> <w>", 0x1E85)
CheckCompUni("<period> <W>", 0x1E86)
CheckCompUni("<period> <w>", 0x1E87)
CheckCompUni("<exclam> <W>", 0x1E88)
CheckCompUni("<exclam> <w>", 0x1E89)
CheckCompUni("<period> <X>", 0x1E8A)
CheckCompUni("<period> <x>", 0x1E8B)
CheckCompUni("<quotedbl> <X>", 0x1E8C)
CheckCompUni("<quotedbl> <x>", 0x1E8D)
CheckCompUni("<period> <Y>", 0x1E8E)
CheckCompUni("<period> <y>", 0x1E8F)
CheckCompUni("<asciicircum> <Z>", 0x1E90)
CheckCompUni("<asciicircum> <z>", 0x1E91)
CheckCompUni("<exclam> <Z>", 0x1E92)
CheckCompUni("<exclam> <z>", 0x1E93)
CheckCompUni("<quotedbl> <t>", 0x1E97)
CheckCompUni("<o> <w>", 0x1E98)
CheckCompUni("<o> <y>", 0x1E99)
CheckCompUni("<period> <U017f>", 0x1E9B)
CheckCompUni("<exclam> <A>", 0x1EA0)
CheckCompUni("<exclam> <a>", 0x1EA1)
CheckCompUni("<question> <A>", 0x1EA2)
CheckCompUni("<question> <a>", 0x1EA3)
CheckCompUni("<apostrophe> <asciicircum> <A>", 0x1EA4)
CheckCompUni("<apostrophe> <dead_circumflex> <A>", 0x1EA4)
CheckCompUni("<acute> <asciicircum> <A>", 0x1EA4)
CheckCompUni("<acute> <dead_circumflex> <A>", 0x1EA4)
CheckCompUni("<apostrophe> <Acircumflex>", 0x1EA4)
CheckCompUni("<acute> <Acircumflex>", 0x1EA4)
CheckCompUni("<apostrophe> <asciicircum> <a>", 0x1EA5)
CheckCompUni("<apostrophe> <dead_circumflex> <a>", 0x1EA5)
CheckCompUni("<acute> <asciicircum> <a>", 0x1EA5)
CheckCompUni("<acute> <dead_circumflex> <a>", 0x1EA5)
CheckCompUni("<apostrophe> <acircumflex>", 0x1EA5)
CheckCompUni("<acute> <acircumflex>", 0x1EA5)
CheckCompUni("<grave> <asciicircum> <A>", 0x1EA6)
CheckCompUni("<grave> <dead_circumflex> <A>", 0x1EA6)
CheckCompUni("<grave> <Acircumflex>", 0x1EA6)
CheckCompUni("<grave> <asciicircum> <a>", 0x1EA7)
CheckCompUni("<grave> <dead_circumflex> <a>", 0x1EA7)
CheckCompUni("<grave> <acircumflex>", 0x1EA7)
CheckCompUni("<question> <asciicircum> <A>", 0x1EA8)
CheckCompUni("<question> <dead_circumflex> <A>", 0x1EA8)
CheckCompUni("<question> <Acircumflex>", 0x1EA8)
CheckCompUni("<question> <asciicircum> <a>", 0x1EA9)
CheckCompUni("<question> <dead_circumflex> <a>", 0x1EA9)
CheckCompUni("<question> <acircumflex>", 0x1EA9)
CheckCompUni("<asciitilde> <asciicircum> <A>", 0x1EAA)
CheckCompUni("<asciitilde> <dead_circumflex> <A>", 0x1EAA)
CheckCompUni("<asciitilde> <Acircumflex>", 0x1EAA)
CheckCompUni("<asciitilde> <asciicircum> <a>", 0x1EAB)
CheckCompUni("<asciitilde> <dead_circumflex> <a>", 0x1EAB)
CheckCompUni("<asciitilde> <acircumflex>", 0x1EAB)
CheckCompUni("<asciicircum> <combining_belowdot> <A>", 0x1EAC)
CheckCompUni("<asciicircum> <exclam> <A>", 0x1EAC)
CheckCompUni("<asciicircum> <dead_belowdot> <A>", 0x1EAC)
CheckCompUni("<asciicircum> <U1ea0>", 0x1EAC)
CheckCompUni("<asciicircum> <combining_belowdot> <a>", 0x1EAD)
CheckCompUni("<asciicircum> <exclam> <a>", 0x1EAD)
CheckCompUni("<asciicircum> <dead_belowdot> <a>", 0x1EAD)
CheckCompUni("<asciicircum> <U1ea1>", 0x1EAD)
CheckCompUni("<apostrophe> <b> <A>", 0x1EAE)
CheckCompUni("<apostrophe> <U> <A>", 0x1EAE)
CheckCompUni("<apostrophe> <dead_breve> <A>", 0x1EAE)
CheckCompUni("<acute> <b> <A>", 0x1EAE)
CheckCompUni("<acute> <U> <A>", 0x1EAE)
CheckCompUni("<acute> <dead_breve> <A>", 0x1EAE)
CheckCompUni("<apostrophe> <Abreve>", 0x1EAE)
CheckCompUni("<acute> <Abreve>", 0x1EAE)
CheckCompUni("<apostrophe> <b> <a>", 0x1EAF)
CheckCompUni("<apostrophe> <U> <a>", 0x1EAF)
CheckCompUni("<apostrophe> <dead_breve> <a>", 0x1EAF)
CheckCompUni("<acute> <b> <a>", 0x1EAF)
CheckCompUni("<acute> <U> <a>", 0x1EAF)
CheckCompUni("<acute> <dead_breve> <a>", 0x1EAF)
CheckCompUni("<apostrophe> <abreve>", 0x1EAF)
CheckCompUni("<acute> <abreve>", 0x1EAF)
CheckCompUni("<grave> <b> <A>", 0x1EB0)
CheckCompUni("<grave> <U> <A>", 0x1EB0)
CheckCompUni("<grave> <dead_breve> <A>", 0x1EB0)
CheckCompUni("<grave> <Abreve>", 0x1EB0)
CheckCompUni("<grave> <b> <a>", 0x1EB1)
CheckCompUni("<grave> <U> <a>", 0x1EB1)
CheckCompUni("<grave> <dead_breve> <a>", 0x1EB1)
CheckCompUni("<grave> <abreve>", 0x1EB1)
CheckCompUni("<question> <b> <A>", 0x1EB2)
CheckCompUni("<question> <U> <A>", 0x1EB2)
CheckCompUni("<question> <dead_breve> <A>", 0x1EB2)
CheckCompUni("<question> <Abreve>", 0x1EB2)
CheckCompUni("<question> <b> <a>", 0x1EB3)
CheckCompUni("<question> <U> <a>", 0x1EB3)
CheckCompUni("<question> <dead_breve> <a>", 0x1EB3)
CheckCompUni("<question> <abreve>", 0x1EB3)
CheckCompUni("<asciitilde> <b> <A>", 0x1EB4)
CheckCompUni("<asciitilde> <U> <A>", 0x1EB4)
CheckCompUni("<asciitilde> <dead_breve> <A>", 0x1EB4)
CheckCompUni("<asciitilde> <Abreve>", 0x1EB4)
CheckCompUni("<asciitilde> <b> <a>", 0x1EB5)
CheckCompUni("<asciitilde> <U> <a>", 0x1EB5)
CheckCompUni("<asciitilde> <dead_breve> <a>", 0x1EB5)
CheckCompUni("<asciitilde> <abreve>", 0x1EB5)
CheckCompUni("<b> <combining_belowdot> <A>", 0x1EB6)
CheckCompUni("<U> <combining_belowdot> <A>", 0x1EB6)
CheckCompUni("<b> <exclam> <A>", 0x1EB6)
CheckCompUni("<b> <dead_belowdot> <A>", 0x1EB6)
CheckCompUni("<U> <exclam> <A>", 0x1EB6)
CheckCompUni("<U> <dead_belowdot> <A>", 0x1EB6)
CheckCompUni("<b> <U1ea0>", 0x1EB6)
CheckCompUni("<U> <U1ea0>", 0x1EB6)
CheckCompUni("<b> <combining_belowdot> <a>", 0x1EB7)
CheckCompUni("<U> <combining_belowdot> <a>", 0x1EB7)
CheckCompUni("<b> <exclam> <a>", 0x1EB7)
CheckCompUni("<b> <dead_belowdot> <a>", 0x1EB7)
CheckCompUni("<U> <exclam> <a>", 0x1EB7)
CheckCompUni("<U> <dead_belowdot> <a>", 0x1EB7)
CheckCompUni("<b> <U1ea1>", 0x1EB7)
CheckCompUni("<U> <U1ea1>", 0x1EB7)
CheckCompUni("<exclam> <E>", 0x1EB8)
CheckCompUni("<exclam> <e>", 0x1EB9)
CheckCompUni("<question> <E>", 0x1EBA)
CheckCompUni("<question> <e>", 0x1EBB)
CheckCompUni("<asciitilde> <E>", 0x1EBC)
CheckCompUni("<asciitilde> <e>", 0x1EBD)
CheckCompUni("<apostrophe> <asciicircum> <E>", 0x1EBE)
CheckCompUni("<apostrophe> <dead_circumflex> <E>", 0x1EBE)
CheckCompUni("<acute> <asciicircum> <E>", 0x1EBE)
CheckCompUni("<acute> <dead_circumflex> <E>", 0x1EBE)
CheckCompUni("<apostrophe> <Ecircumflex>", 0x1EBE)
CheckCompUni("<acute> <Ecircumflex>", 0x1EBE)
CheckCompUni("<apostrophe> <asciicircum> <e>", 0x1EBF)
CheckCompUni("<apostrophe> <dead_circumflex> <e>", 0x1EBF)
CheckCompUni("<acute> <asciicircum> <e>", 0x1EBF)
CheckCompUni("<acute> <dead_circumflex> <e>", 0x1EBF)
CheckCompUni("<apostrophe> <ecircumflex>", 0x1EBF)
CheckCompUni("<acute> <ecircumflex>", 0x1EBF)
CheckCompUni("<grave> <asciicircum> <E>", 0x1EC0)
CheckCompUni("<grave> <dead_circumflex> <E>", 0x1EC0)
CheckCompUni("<grave> <Ecircumflex>", 0x1EC0)
CheckCompUni("<grave> <asciicircum> <e>", 0x1EC1)
CheckCompUni("<grave> <dead_circumflex> <e>", 0x1EC1)
CheckCompUni("<grave> <ecircumflex>", 0x1EC1)
CheckCompUni("<question> <asciicircum> <E>", 0x1EC2)
CheckCompUni("<question> <dead_circumflex> <E>", 0x1EC2)
CheckCompUni("<question> <Ecircumflex>", 0x1EC2)
CheckCompUni("<question> <asciicircum> <e>", 0x1EC3)
CheckCompUni("<question> <dead_circumflex> <e>", 0x1EC3)
CheckCompUni("<question> <ecircumflex>", 0x1EC3)
CheckCompUni("<asciitilde> <asciicircum> <E>", 0x1EC4)
CheckCompUni("<asciitilde> <dead_circumflex> <E>", 0x1EC4)
CheckCompUni("<asciitilde> <Ecircumflex>", 0x1EC4)
CheckCompUni("<asciitilde> <asciicircum> <e>", 0x1EC5)
CheckCompUni("<asciitilde> <dead_circumflex> <e>", 0x1EC5)
CheckCompUni("<asciitilde> <ecircumflex>", 0x1EC5)
CheckCompUni("<asciicircum> <combining_belowdot> <E>", 0x1EC6)
CheckCompUni("<asciicircum> <exclam> <E>", 0x1EC6)
CheckCompUni("<asciicircum> <dead_belowdot> <E>", 0x1EC6)
CheckCompUni("<asciicircum> <U1eb8>", 0x1EC6)
CheckCompUni("<asciicircum> <combining_belowdot> <e>", 0x1EC7)
CheckCompUni("<asciicircum> <exclam> <e>", 0x1EC7)
CheckCompUni("<asciicircum> <dead_belowdot> <e>", 0x1EC7)
CheckCompUni("<asciicircum> <U1eb9>", 0x1EC7)
CheckCompUni("<question> <I>", 0x1EC8)
CheckCompUni("<question> <i>", 0x1EC9)
CheckCompUni("<exclam> <I>", 0x1ECA)
CheckCompUni("<exclam> <i>", 0x1ECB)
CheckCompUni("<exclam> <O>", 0x1ECC)
CheckCompUni("<exclam> <o>", 0x1ECD)
CheckCompUni("<question> <O>", 0x1ECE)
CheckCompUni("<question> <o>", 0x1ECF)
CheckCompUni("<apostrophe> <asciicircum> <O>", 0x1ED0)
CheckCompUni("<apostrophe> <dead_circumflex> <O>", 0x1ED0)
CheckCompUni("<acute> <asciicircum> <O>", 0x1ED0)
CheckCompUni("<acute> <dead_circumflex> <O>", 0x1ED0)
CheckCompUni("<apostrophe> <Ocircumflex>", 0x1ED0)
CheckCompUni("<acute> <Ocircumflex>", 0x1ED0)
CheckCompUni("<apostrophe> <asciicircum> <o>", 0x1ED1)
CheckCompUni("<apostrophe> <dead_circumflex> <o>", 0x1ED1)
CheckCompUni("<acute> <asciicircum> <o>", 0x1ED1)
CheckCompUni("<acute> <dead_circumflex> <o>", 0x1ED1)
CheckCompUni("<apostrophe> <ocircumflex>", 0x1ED1)
CheckCompUni("<acute> <ocircumflex>", 0x1ED1)
CheckCompUni("<grave> <asciicircum> <O>", 0x1ED2)
CheckCompUni("<grave> <dead_circumflex> <O>", 0x1ED2)
CheckCompUni("<grave> <Ocircumflex>", 0x1ED2)
CheckCompUni("<grave> <asciicircum> <o>", 0x1ED3)
CheckCompUni("<grave> <dead_circumflex> <o>", 0x1ED3)
CheckCompUni("<grave> <ocircumflex>", 0x1ED3)
CheckCompUni("<question> <asciicircum> <O>", 0x1ED4)
CheckCompUni("<question> <dead_circumflex> <O>", 0x1ED4)
CheckCompUni("<question> <Ocircumflex>", 0x1ED4)
CheckCompUni("<question> <asciicircum> <o>", 0x1ED5)
CheckCompUni("<question> <dead_circumflex> <o>", 0x1ED5)
CheckCompUni("<question> <ocircumflex>", 0x1ED5)
CheckCompUni("<asciitilde> <asciicircum> <O>", 0x1ED6)
CheckCompUni("<asciitilde> <dead_circumflex> <O>", 0x1ED6)
CheckCompUni("<asciitilde> <Ocircumflex>", 0x1ED6)
CheckCompUni("<asciitilde> <asciicircum> <o>", 0x1ED7)
CheckCompUni("<asciitilde> <dead_circumflex> <o>", 0x1ED7)
CheckCompUni("<asciitilde> <ocircumflex>", 0x1ED7)
CheckCompUni("<asciicircum> <combining_belowdot> <O>", 0x1ED8)
CheckCompUni("<asciicircum> <exclam> <O>", 0x1ED8)
CheckCompUni("<asciicircum> <dead_belowdot> <O>", 0x1ED8)
CheckCompUni("<asciicircum> <U1ecc>", 0x1ED8)
CheckCompUni("<asciicircum> <combining_belowdot> <o>", 0x1ED9)
CheckCompUni("<asciicircum> <exclam> <o>", 0x1ED9)
CheckCompUni("<asciicircum> <dead_belowdot> <o>", 0x1ED9)
CheckCompUni("<asciicircum> <U1ecd>", 0x1ED9)
CheckCompUni("<apostrophe> <plus> <O>", 0x1EDA)
CheckCompUni("<apostrophe> <dead_horn> <O>", 0x1EDA)
CheckCompUni("<acute> <plus> <O>", 0x1EDA)
CheckCompUni("<acute> <dead_horn> <O>", 0x1EDA)
CheckCompUni("<apostrophe> <Ohorn>", 0x1EDA)
CheckCompUni("<acute> <Ohorn>", 0x1EDA)
CheckCompUni("<apostrophe> <plus> <o>", 0x1EDB)
CheckCompUni("<apostrophe> <dead_horn> <o>", 0x1EDB)
CheckCompUni("<acute> <plus> <o>", 0x1EDB)
CheckCompUni("<acute> <dead_horn> <o>", 0x1EDB)
CheckCompUni("<apostrophe> <ohorn>", 0x1EDB)
CheckCompUni("<acute> <ohorn>", 0x1EDB)
CheckCompUni("<grave> <plus> <O>", 0x1EDC)
CheckCompUni("<grave> <dead_horn> <O>", 0x1EDC)
CheckCompUni("<grave> <Ohorn>", 0x1EDC)
CheckCompUni("<grave> <plus> <o>", 0x1EDD)
CheckCompUni("<grave> <dead_horn> <o>", 0x1EDD)
CheckCompUni("<grave> <ohorn>", 0x1EDD)
CheckCompUni("<question> <plus> <O>", 0x1EDE)
CheckCompUni("<question> <dead_horn> <O>", 0x1EDE)
CheckCompUni("<question> <Ohorn>", 0x1EDE)
CheckCompUni("<question> <plus> <o>", 0x1EDF)
CheckCompUni("<question> <dead_horn> <o>", 0x1EDF)
CheckCompUni("<question> <ohorn>", 0x1EDF)
CheckCompUni("<asciitilde> <plus> <O>", 0x1EE0)
CheckCompUni("<asciitilde> <dead_horn> <O>", 0x1EE0)
CheckCompUni("<asciitilde> <Ohorn>", 0x1EE0)
CheckCompUni("<asciitilde> <plus> <o>", 0x1EE1)
CheckCompUni("<asciitilde> <dead_horn> <o>", 0x1EE1)
CheckCompUni("<asciitilde> <ohorn>", 0x1EE1)
CheckCompUni("<exclam> <plus> <O>", 0x1EE2)
CheckCompUni("<exclam> <dead_horn> <O>", 0x1EE2)
CheckCompUni("<exclam> <Ohorn>", 0x1EE2)
CheckCompUni("<exclam> <plus> <o>", 0x1EE3)
CheckCompUni("<exclam> <dead_horn> <o>", 0x1EE3)
CheckCompUni("<exclam> <ohorn>", 0x1EE3)
CheckCompUni("<exclam> <U>", 0x1EE4)
CheckCompUni("<exclam> <u>", 0x1EE5)
CheckCompUni("<question> <U>", 0x1EE6)
CheckCompUni("<question> <u>", 0x1EE7)
CheckCompUni("<apostrophe> <plus> <U>", 0x1EE8)
CheckCompUni("<apostrophe> <dead_horn> <U>", 0x1EE8)
CheckCompUni("<acute> <plus> <U>", 0x1EE8)
CheckCompUni("<acute> <dead_horn> <U>", 0x1EE8)
CheckCompUni("<apostrophe> <Uhorn>", 0x1EE8)
CheckCompUni("<acute> <Uhorn>", 0x1EE8)
CheckCompUni("<apostrophe> <plus> <u>", 0x1EE9)
CheckCompUni("<apostrophe> <dead_horn> <u>", 0x1EE9)
CheckCompUni("<acute> <plus> <u>", 0x1EE9)
CheckCompUni("<acute> <dead_horn> <u>", 0x1EE9)
CheckCompUni("<apostrophe> <uhorn>", 0x1EE9)
CheckCompUni("<acute> <uhorn>", 0x1EE9)
CheckCompUni("<grave> <plus> <U>", 0x1EEA)
CheckCompUni("<grave> <dead_horn> <U>", 0x1EEA)
CheckCompUni("<grave> <Uhorn>", 0x1EEA)
CheckCompUni("<grave> <plus> <u>", 0x1EEB)
CheckCompUni("<grave> <dead_horn> <u>", 0x1EEB)
CheckCompUni("<grave> <uhorn>", 0x1EEB)
CheckCompUni("<question> <plus> <U>", 0x1EEC)
CheckCompUni("<question> <dead_horn> <U>", 0x1EEC)
CheckCompUni("<question> <Uhorn>", 0x1EEC)
CheckCompUni("<question> <plus> <u>", 0x1EED)
CheckCompUni("<question> <dead_horn> <u>", 0x1EED)
CheckCompUni("<question> <uhorn>", 0x1EED)
CheckCompUni("<asciitilde> <plus> <U>", 0x1EEE)
CheckCompUni("<asciitilde> <dead_horn> <U>", 0x1EEE)
CheckCompUni("<asciitilde> <Uhorn>", 0x1EEE)
CheckCompUni("<asciitilde> <plus> <u>", 0x1EEF)
CheckCompUni("<asciitilde> <dead_horn> <u>", 0x1EEF)
CheckCompUni("<asciitilde> <uhorn>", 0x1EEF)
CheckCompUni("<exclam> <plus> <U>", 0x1EF0)
CheckCompUni("<exclam> <dead_horn> <U>", 0x1EF0)
CheckCompUni("<exclam> <Uhorn>", 0x1EF0)
CheckCompUni("<exclam> <plus> <u>", 0x1EF1)
CheckCompUni("<exclam> <dead_horn> <u>", 0x1EF1)
CheckCompUni("<exclam> <uhorn>", 0x1EF1)
CheckCompUni("<grave> <Y>", 0x1EF2)
CheckCompUni("<grave> <y>", 0x1EF3)
CheckCompUni("<exclam> <Y>", 0x1EF4)
CheckCompUni("<exclam> <y>", 0x1EF5)
CheckCompUni("<question> <Y>", 0x1EF6)
CheckCompUni("<question> <y>", 0x1EF7)
CheckCompUni("<asciitilde> <Y>", 0x1EF8)
CheckCompUni("<asciitilde> <y>", 0x1EF9)
CheckCompUni("<parenright> <Greek_alpha>", 0x1F00)
CheckCompUni("<parenleft> <Greek_alpha>", 0x1F01)
CheckCompUni("<grave> <parenright> <Greek_alpha>", 0x1F02)
CheckCompUni("<grave> <U0313> <Greek_alpha>", 0x1F02)
CheckCompUni("<grave> <U1f00>", 0x1F02)
CheckCompUni("<grave> <parenleft> <Greek_alpha>", 0x1F03)
CheckCompUni("<grave> <U0314> <Greek_alpha>", 0x1F03)
CheckCompUni("<grave> <U1f01>", 0x1F03)
CheckCompUni("<apostrophe> <parenright> <Greek_alpha>", 0x1F04)
CheckCompUni("<apostrophe> <U0313> <Greek_alpha>", 0x1F04)
CheckCompUni("<acute> <parenright> <Greek_alpha>", 0x1F04)
CheckCompUni("<acute> <U0313> <Greek_alpha>", 0x1F04)
CheckCompUni("<apostrophe> <U1f00>", 0x1F04)
CheckCompUni("<acute> <U1f00>", 0x1F04)
CheckCompUni("<apostrophe> <parenleft> <Greek_alpha>", 0x1F05)
CheckCompUni("<apostrophe> <U0314> <Greek_alpha>", 0x1F05)
CheckCompUni("<acute> <parenleft> <Greek_alpha>", 0x1F05)
CheckCompUni("<acute> <U0314> <Greek_alpha>", 0x1F05)
CheckCompUni("<apostrophe> <U1f01>", 0x1F05)
CheckCompUni("<acute> <U1f01>", 0x1F05)
CheckCompUni("<asciitilde> <parenright> <Greek_alpha>", 0x1F06)
CheckCompUni("<asciitilde> <U0313> <Greek_alpha>", 0x1F06)
CheckCompUni("<asciitilde> <U1f00>", 0x1F06)
CheckCompUni("<asciitilde> <parenleft> <Greek_alpha>", 0x1F07)
CheckCompUni("<asciitilde> <U0314> <Greek_alpha>", 0x1F07)
CheckCompUni("<asciitilde> <U1f01>", 0x1F07)
CheckCompUni("<parenright> <Greek_ALPHA>", 0x1F08)
CheckCompUni("<parenleft> <Greek_ALPHA>", 0x1F09)
CheckCompUni("<grave> <parenright> <Greek_ALPHA>", 0x1F0A)
CheckCompUni("<grave> <U0313> <Greek_ALPHA>", 0x1F0A)
CheckCompUni("<grave> <U1f08>", 0x1F0A)
CheckCompUni("<grave> <parenleft> <Greek_ALPHA>", 0x1F0B)
CheckCompUni("<grave> <U0314> <Greek_ALPHA>", 0x1F0B)
CheckCompUni("<grave> <U1f09>", 0x1F0B)
CheckCompUni("<apostrophe> <parenright> <Greek_ALPHA>", 0x1F0C)
CheckCompUni("<apostrophe> <U0313> <Greek_ALPHA>", 0x1F0C)
CheckCompUni("<acute> <parenright> <Greek_ALPHA>", 0x1F0C)
CheckCompUni("<acute> <U0313> <Greek_ALPHA>", 0x1F0C)
CheckCompUni("<apostrophe> <U1f08>", 0x1F0C)
CheckCompUni("<acute> <U1f08>", 0x1F0C)
CheckCompUni("<apostrophe> <parenleft> <Greek_ALPHA>", 0x1F0D)
CheckCompUni("<apostrophe> <U0314> <Greek_ALPHA>", 0x1F0D)
CheckCompUni("<acute> <parenleft> <Greek_ALPHA>", 0x1F0D)
CheckCompUni("<acute> <U0314> <Greek_ALPHA>", 0x1F0D)
CheckCompUni("<apostrophe> <U1f09>", 0x1F0D)
CheckCompUni("<acute> <U1f09>", 0x1F0D)
CheckCompUni("<asciitilde> <parenright> <Greek_ALPHA>", 0x1F0E)
CheckCompUni("<asciitilde> <U0313> <Greek_ALPHA>", 0x1F0E)
CheckCompUni("<asciitilde> <U1f08>", 0x1F0E)
CheckCompUni("<asciitilde> <parenleft> <Greek_ALPHA>", 0x1F0F)
CheckCompUni("<asciitilde> <U0314> <Greek_ALPHA>", 0x1F0F)
CheckCompUni("<asciitilde> <U1f09>", 0x1F0F)
CheckCompUni("<parenright> <Greek_epsilon>", 0x1F10)
CheckCompUni("<parenleft> <Greek_epsilon>", 0x1F11)
CheckCompUni("<grave> <parenright> <Greek_epsilon>", 0x1F12)
CheckCompUni("<grave> <U0313> <Greek_epsilon>", 0x1F12)
CheckCompUni("<grave> <U1f10>", 0x1F12)
CheckCompUni("<grave> <parenleft> <Greek_epsilon>", 0x1F13)
CheckCompUni("<grave> <U0314> <Greek_epsilon>", 0x1F13)
CheckCompUni("<grave> <U1f11>", 0x1F13)
CheckCompUni("<apostrophe> <parenright> <Greek_epsilon>", 0x1F14)
CheckCompUni("<apostrophe> <U0313> <Greek_epsilon>", 0x1F14)
CheckCompUni("<acute> <parenright> <Greek_epsilon>", 0x1F14)
CheckCompUni("<acute> <U0313> <Greek_epsilon>", 0x1F14)
CheckCompUni("<apostrophe> <U1f10>", 0x1F14)
CheckCompUni("<acute> <U1f10>", 0x1F14)
CheckCompUni("<apostrophe> <parenleft> <Greek_epsilon>", 0x1F15)
CheckCompUni("<apostrophe> <U0314> <Greek_epsilon>", 0x1F15)
CheckCompUni("<acute> <parenleft> <Greek_epsilon>", 0x1F15)
CheckCompUni("<acute> <U0314> <Greek_epsilon>", 0x1F15)
CheckCompUni("<apostrophe> <U1f11>", 0x1F15)
CheckCompUni("<acute> <U1f11>", 0x1F15)
CheckCompUni("<parenright> <Greek_EPSILON>", 0x1F18)
CheckCompUni("<parenleft> <Greek_EPSILON>", 0x1F19)
CheckCompUni("<grave> <parenright> <Greek_EPSILON>", 0x1F1A)
CheckCompUni("<grave> <U0313> <Greek_EPSILON>", 0x1F1A)
CheckCompUni("<grave> <U1f18>", 0x1F1A)
CheckCompUni("<grave> <parenleft> <Greek_EPSILON>", 0x1F1B)
CheckCompUni("<grave> <U0314> <Greek_EPSILON>", 0x1F1B)
CheckCompUni("<grave> <U1f19>", 0x1F1B)
CheckCompUni("<apostrophe> <parenright> <Greek_EPSILON>", 0x1F1C)
CheckCompUni("<apostrophe> <U0313> <Greek_EPSILON>", 0x1F1C)
CheckCompUni("<acute> <parenright> <Greek_EPSILON>", 0x1F1C)
CheckCompUni("<acute> <U0313> <Greek_EPSILON>", 0x1F1C)
CheckCompUni("<apostrophe> <U1f18>", 0x1F1C)
CheckCompUni("<acute> <U1f18>", 0x1F1C)
CheckCompUni("<apostrophe> <parenleft> <Greek_EPSILON>", 0x1F1D)
CheckCompUni("<apostrophe> <U0314> <Greek_EPSILON>", 0x1F1D)
CheckCompUni("<acute> <parenleft> <Greek_EPSILON>", 0x1F1D)
CheckCompUni("<acute> <U0314> <Greek_EPSILON>", 0x1F1D)
CheckCompUni("<apostrophe> <U1f19>", 0x1F1D)
CheckCompUni("<acute> <U1f19>", 0x1F1D)
CheckCompUni("<parenright> <Greek_eta>", 0x1F20)
CheckCompUni("<parenleft> <Greek_eta>", 0x1F21)
CheckCompUni("<grave> <parenright> <Greek_eta>", 0x1F22)
CheckCompUni("<grave> <U0313> <Greek_eta>", 0x1F22)
CheckCompUni("<grave> <U1f20>", 0x1F22)
CheckCompUni("<grave> <parenleft> <Greek_eta>", 0x1F23)
CheckCompUni("<grave> <U0314> <Greek_eta>", 0x1F23)
CheckCompUni("<grave> <U1f21>", 0x1F23)
CheckCompUni("<apostrophe> <parenright> <Greek_eta>", 0x1F24)
CheckCompUni("<apostrophe> <U0313> <Greek_eta>", 0x1F24)
CheckCompUni("<acute> <parenright> <Greek_eta>", 0x1F24)
CheckCompUni("<acute> <U0313> <Greek_eta>", 0x1F24)
CheckCompUni("<apostrophe> <U1f20>", 0x1F24)
CheckCompUni("<acute> <U1f20>", 0x1F24)
CheckCompUni("<apostrophe> <parenleft> <Greek_eta>", 0x1F25)
CheckCompUni("<apostrophe> <U0314> <Greek_eta>", 0x1F25)
CheckCompUni("<acute> <parenleft> <Greek_eta>", 0x1F25)
CheckCompUni("<acute> <U0314> <Greek_eta>", 0x1F25)
CheckCompUni("<apostrophe> <U1f21>", 0x1F25)
CheckCompUni("<acute> <U1f21>", 0x1F25)
CheckCompUni("<asciitilde> <parenright> <Greek_eta>", 0x1F26)
CheckCompUni("<asciitilde> <U0313> <Greek_eta>", 0x1F26)
CheckCompUni("<asciitilde> <U1f20>", 0x1F26)
CheckCompUni("<asciitilde> <parenleft> <Greek_eta>", 0x1F27)
CheckCompUni("<asciitilde> <U0314> <Greek_eta>", 0x1F27)
CheckCompUni("<asciitilde> <U1f21>", 0x1F27)
CheckCompUni("<parenright> <Greek_ETA>", 0x1F28)
CheckCompUni("<parenleft> <Greek_ETA>", 0x1F29)
CheckCompUni("<grave> <parenright> <Greek_ETA>", 0x1F2A)
CheckCompUni("<grave> <U0313> <Greek_ETA>", 0x1F2A)
CheckCompUni("<grave> <U1f28>", 0x1F2A)
CheckCompUni("<grave> <parenleft> <Greek_ETA>", 0x1F2B)
CheckCompUni("<grave> <U0314> <Greek_ETA>", 0x1F2B)
CheckCompUni("<grave> <U1f29>", 0x1F2B)
CheckCompUni("<apostrophe> <parenright> <Greek_ETA>", 0x1F2C)
CheckCompUni("<apostrophe> <U0313> <Greek_ETA>", 0x1F2C)
CheckCompUni("<acute> <parenright> <Greek_ETA>", 0x1F2C)
CheckCompUni("<acute> <U0313> <Greek_ETA>", 0x1F2C)
CheckCompUni("<apostrophe> <U1f28>", 0x1F2C)
CheckCompUni("<acute> <U1f28>", 0x1F2C)
CheckCompUni("<apostrophe> <parenleft> <Greek_ETA>", 0x1F2D)
CheckCompUni("<apostrophe> <U0314> <Greek_ETA>", 0x1F2D)
CheckCompUni("<acute> <parenleft> <Greek_ETA>", 0x1F2D)
CheckCompUni("<acute> <U0314> <Greek_ETA>", 0x1F2D)
CheckCompUni("<apostrophe> <U1f29>", 0x1F2D)
CheckCompUni("<acute> <U1f29>", 0x1F2D)
CheckCompUni("<asciitilde> <parenright> <Greek_ETA>", 0x1F2E)
CheckCompUni("<asciitilde> <U0313> <Greek_ETA>", 0x1F2E)
CheckCompUni("<asciitilde> <U1f28>", 0x1F2E)
CheckCompUni("<asciitilde> <parenleft> <Greek_ETA>", 0x1F2F)
CheckCompUni("<asciitilde> <U0314> <Greek_ETA>", 0x1F2F)
CheckCompUni("<asciitilde> <U1f29>", 0x1F2F)
CheckCompUni("<parenright> <Greek_iota>", 0x1F30)
CheckCompUni("<parenleft> <Greek_iota>", 0x1F31)
CheckCompUni("<grave> <parenright> <Greek_iota>", 0x1F32)
CheckCompUni("<grave> <U0313> <Greek_iota>", 0x1F32)
CheckCompUni("<grave> <U1f30>", 0x1F32)
CheckCompUni("<grave> <parenleft> <Greek_iota>", 0x1F33)
CheckCompUni("<grave> <U0314> <Greek_iota>", 0x1F33)
CheckCompUni("<grave> <U1f31>", 0x1F33)
CheckCompUni("<apostrophe> <parenright> <Greek_iota>", 0x1F34)
CheckCompUni("<apostrophe> <U0313> <Greek_iota>", 0x1F34)
CheckCompUni("<acute> <parenright> <Greek_iota>", 0x1F34)
CheckCompUni("<acute> <U0313> <Greek_iota>", 0x1F34)
CheckCompUni("<apostrophe> <U1f30>", 0x1F34)
CheckCompUni("<acute> <U1f30>", 0x1F34)
CheckCompUni("<apostrophe> <parenleft> <Greek_iota>", 0x1F35)
CheckCompUni("<apostrophe> <U0314> <Greek_iota>", 0x1F35)
CheckCompUni("<acute> <parenleft> <Greek_iota>", 0x1F35)
CheckCompUni("<acute> <U0314> <Greek_iota>", 0x1F35)
CheckCompUni("<apostrophe> <U1f31>", 0x1F35)
CheckCompUni("<acute> <U1f31>", 0x1F35)
CheckCompUni("<asciitilde> <parenright> <Greek_iota>", 0x1F36)
CheckCompUni("<asciitilde> <U0313> <Greek_iota>", 0x1F36)
CheckCompUni("<asciitilde> <U1f30>", 0x1F36)
CheckCompUni("<asciitilde> <parenleft> <Greek_iota>", 0x1F37)
CheckCompUni("<asciitilde> <U0314> <Greek_iota>", 0x1F37)
CheckCompUni("<asciitilde> <U1f31>", 0x1F37)
CheckCompUni("<parenright> <Greek_IOTA>", 0x1F38)
CheckCompUni("<parenleft> <Greek_IOTA>", 0x1F39)
CheckCompUni("<grave> <parenright> <Greek_IOTA>", 0x1F3A)
CheckCompUni("<grave> <U0313> <Greek_IOTA>", 0x1F3A)
CheckCompUni("<grave> <U1f38>", 0x1F3A)
CheckCompUni("<grave> <parenleft> <Greek_IOTA>", 0x1F3B)
CheckCompUni("<grave> <U0314> <Greek_IOTA>", 0x1F3B)
CheckCompUni("<grave> <U1f39>", 0x1F3B)
CheckCompUni("<apostrophe> <parenright> <Greek_IOTA>", 0x1F3C)
CheckCompUni("<apostrophe> <U0313> <Greek_IOTA>", 0x1F3C)
CheckCompUni("<acute> <parenright> <Greek_IOTA>", 0x1F3C)
CheckCompUni("<acute> <U0313> <Greek_IOTA>", 0x1F3C)
CheckCompUni("<apostrophe> <U1f38>", 0x1F3C)
CheckCompUni("<acute> <U1f38>", 0x1F3C)
CheckCompUni("<apostrophe> <parenleft> <Greek_IOTA>", 0x1F3D)
CheckCompUni("<apostrophe> <U0314> <Greek_IOTA>", 0x1F3D)
CheckCompUni("<acute> <parenleft> <Greek_IOTA>", 0x1F3D)
CheckCompUni("<acute> <U0314> <Greek_IOTA>", 0x1F3D)
CheckCompUni("<apostrophe> <U1f39>", 0x1F3D)
CheckCompUni("<acute> <U1f39>", 0x1F3D)
CheckCompUni("<asciitilde> <parenright> <Greek_IOTA>", 0x1F3E)
CheckCompUni("<asciitilde> <U0313> <Greek_IOTA>", 0x1F3E)
CheckCompUni("<asciitilde> <U1f38>", 0x1F3E)
CheckCompUni("<asciitilde> <parenleft> <Greek_IOTA>", 0x1F3F)
CheckCompUni("<asciitilde> <U0314> <Greek_IOTA>", 0x1F3F)
CheckCompUni("<asciitilde> <U1f39>", 0x1F3F)
CheckCompUni("<parenright> <Greek_omicron>", 0x1F40)
CheckCompUni("<parenleft> <Greek_omicron>", 0x1F41)
CheckCompUni("<grave> <parenright> <Greek_omicron>", 0x1F42)
CheckCompUni("<grave> <U0313> <Greek_omicron>", 0x1F42)
CheckCompUni("<grave> <U1f40>", 0x1F42)
CheckCompUni("<grave> <parenleft> <Greek_omicron>", 0x1F43)
CheckCompUni("<grave> <U0314> <Greek_omicron>", 0x1F43)
CheckCompUni("<grave> <U1f41>", 0x1F43)
CheckCompUni("<apostrophe> <parenright> <Greek_omicron>", 0x1F44)
CheckCompUni("<apostrophe> <U0313> <Greek_omicron>", 0x1F44)
CheckCompUni("<acute> <parenright> <Greek_omicron>", 0x1F44)
CheckCompUni("<acute> <U0313> <Greek_omicron>", 0x1F44)
CheckCompUni("<apostrophe> <U1f40>", 0x1F44)
CheckCompUni("<acute> <U1f40>", 0x1F44)
CheckCompUni("<apostrophe> <parenleft> <Greek_omicron>", 0x1F45)
CheckCompUni("<apostrophe> <U0314> <Greek_omicron>", 0x1F45)
CheckCompUni("<acute> <parenleft> <Greek_omicron>", 0x1F45)
CheckCompUni("<acute> <U0314> <Greek_omicron>", 0x1F45)
CheckCompUni("<apostrophe> <U1f41>", 0x1F45)
CheckCompUni("<acute> <U1f41>", 0x1F45)
CheckCompUni("<parenright> <Greek_OMICRON>", 0x1F48)
CheckCompUni("<parenleft> <Greek_OMICRON>", 0x1F49)
CheckCompUni("<grave> <parenright> <Greek_OMICRON>", 0x1F4A)
CheckCompUni("<grave> <U0313> <Greek_OMICRON>", 0x1F4A)
CheckCompUni("<grave> <U1f48>", 0x1F4A)
CheckCompUni("<grave> <parenleft> <Greek_OMICRON>", 0x1F4B)
CheckCompUni("<grave> <U0314> <Greek_OMICRON>", 0x1F4B)
CheckCompUni("<grave> <U1f49>", 0x1F4B)
CheckCompUni("<apostrophe> <parenright> <Greek_OMICRON>", 0x1F4C)
CheckCompUni("<apostrophe> <U0313> <Greek_OMICRON>", 0x1F4C)
CheckCompUni("<acute> <parenright> <Greek_OMICRON>", 0x1F4C)
CheckCompUni("<acute> <U0313> <Greek_OMICRON>", 0x1F4C)
CheckCompUni("<apostrophe> <U1f48>", 0x1F4C)
CheckCompUni("<acute> <U1f48>", 0x1F4C)
CheckCompUni("<apostrophe> <parenleft> <Greek_OMICRON>", 0x1F4D)
CheckCompUni("<apostrophe> <U0314> <Greek_OMICRON>", 0x1F4D)
CheckCompUni("<acute> <parenleft> <Greek_OMICRON>", 0x1F4D)
CheckCompUni("<acute> <U0314> <Greek_OMICRON>", 0x1F4D)
CheckCompUni("<apostrophe> <U1f49>", 0x1F4D)
CheckCompUni("<acute> <U1f49>", 0x1F4D)
CheckCompUni("<parenright> <Greek_upsilon>", 0x1F50)
CheckCompUni("<parenleft> <Greek_upsilon>", 0x1F51)
CheckCompUni("<grave> <parenright> <Greek_upsilon>", 0x1F52)
CheckCompUni("<grave> <U0313> <Greek_upsilon>", 0x1F52)
CheckCompUni("<grave> <U1f50>", 0x1F52)
CheckCompUni("<grave> <parenleft> <Greek_upsilon>", 0x1F53)
CheckCompUni("<grave> <U0314> <Greek_upsilon>", 0x1F53)
CheckCompUni("<grave> <U1f51>", 0x1F53)
CheckCompUni("<apostrophe> <parenright> <Greek_upsilon>", 0x1F54)
CheckCompUni("<apostrophe> <U0313> <Greek_upsilon>", 0x1F54)
CheckCompUni("<acute> <parenright> <Greek_upsilon>", 0x1F54)
CheckCompUni("<acute> <U0313> <Greek_upsilon>", 0x1F54)
CheckCompUni("<apostrophe> <U1f50>", 0x1F54)
CheckCompUni("<acute> <U1f50>", 0x1F54)
CheckCompUni("<apostrophe> <parenleft> <Greek_upsilon>", 0x1F55)
CheckCompUni("<apostrophe> <U0314> <Greek_upsilon>", 0x1F55)
CheckCompUni("<acute> <parenleft> <Greek_upsilon>", 0x1F55)
CheckCompUni("<acute> <U0314> <Greek_upsilon>", 0x1F55)
CheckCompUni("<apostrophe> <U1f51>", 0x1F55)
CheckCompUni("<acute> <U1f51>", 0x1F55)
CheckCompUni("<asciitilde> <parenright> <Greek_upsilon>", 0x1F56)
CheckCompUni("<asciitilde> <U0313> <Greek_upsilon>", 0x1F56)
CheckCompUni("<asciitilde> <U1f50>", 0x1F56)
CheckCompUni("<asciitilde> <parenleft> <Greek_upsilon>", 0x1F57)
CheckCompUni("<asciitilde> <U0314> <Greek_upsilon>", 0x1F57)
CheckCompUni("<asciitilde> <U1f51>", 0x1F57)
CheckCompUni("<parenleft> <Greek_UPSILON>", 0x1F59)
CheckCompUni("<grave> <parenleft> <Greek_UPSILON>", 0x1F5B)
CheckCompUni("<grave> <U0314> <Greek_UPSILON>", 0x1F5B)
CheckCompUni("<grave> <U1f59>", 0x1F5B)
CheckCompUni("<apostrophe> <parenleft> <Greek_UPSILON>", 0x1F5D)
CheckCompUni("<apostrophe> <U0314> <Greek_UPSILON>", 0x1F5D)
CheckCompUni("<acute> <parenleft> <Greek_UPSILON>", 0x1F5D)
CheckCompUni("<acute> <U0314> <Greek_UPSILON>", 0x1F5D)
CheckCompUni("<apostrophe> <U1f59>", 0x1F5D)
CheckCompUni("<acute> <U1f59>", 0x1F5D)
CheckCompUni("<asciitilde> <parenleft> <Greek_UPSILON>", 0x1F5F)
CheckCompUni("<asciitilde> <U0314> <Greek_UPSILON>", 0x1F5F)
CheckCompUni("<asciitilde> <U1f59>", 0x1F5F)
CheckCompUni("<parenright> <Greek_omega>", 0x1F60)
CheckCompUni("<parenleft> <Greek_omega>", 0x1F61)
CheckCompUni("<grave> <parenright> <Greek_omega>", 0x1F62)
CheckCompUni("<grave> <U0313> <Greek_omega>", 0x1F62)
CheckCompUni("<grave> <U1f60>", 0x1F62)
CheckCompUni("<grave> <parenleft> <Greek_omega>", 0x1F63)
CheckCompUni("<grave> <U0314> <Greek_omega>", 0x1F63)
CheckCompUni("<grave> <U1f61>", 0x1F63)
CheckCompUni("<apostrophe> <parenright> <Greek_omega>", 0x1F64)
CheckCompUni("<apostrophe> <U0313> <Greek_omega>", 0x1F64)
CheckCompUni("<acute> <parenright> <Greek_omega>", 0x1F64)
CheckCompUni("<acute> <U0313> <Greek_omega>", 0x1F64)
CheckCompUni("<apostrophe> <U1f60>", 0x1F64)
CheckCompUni("<acute> <U1f60>", 0x1F64)
CheckCompUni("<apostrophe> <parenleft> <Greek_omega>", 0x1F65)
CheckCompUni("<apostrophe> <U0314> <Greek_omega>", 0x1F65)
CheckCompUni("<acute> <parenleft> <Greek_omega>", 0x1F65)
CheckCompUni("<acute> <U0314> <Greek_omega>", 0x1F65)
CheckCompUni("<apostrophe> <U1f61>", 0x1F65)
CheckCompUni("<acute> <U1f61>", 0x1F65)
CheckCompUni("<asciitilde> <parenright> <Greek_omega>", 0x1F66)
CheckCompUni("<asciitilde> <U0313> <Greek_omega>", 0x1F66)
CheckCompUni("<asciitilde> <U1f60>", 0x1F66)
CheckCompUni("<asciitilde> <parenleft> <Greek_omega>", 0x1F67)
CheckCompUni("<asciitilde> <U0314> <Greek_omega>", 0x1F67)
CheckCompUni("<asciitilde> <U1f61>", 0x1F67)
CheckCompUni("<parenright> <Greek_OMEGA>", 0x1F68)
CheckCompUni("<parenleft> <Greek_OMEGA>", 0x1F69)
CheckCompUni("<grave> <parenright> <Greek_OMEGA>", 0x1F6A)
CheckCompUni("<grave> <U0313> <Greek_OMEGA>", 0x1F6A)
CheckCompUni("<grave> <U1f68>", 0x1F6A)
CheckCompUni("<grave> <parenleft> <Greek_OMEGA>", 0x1F6B)
CheckCompUni("<grave> <U0314> <Greek_OMEGA>", 0x1F6B)
CheckCompUni("<grave> <U1f69>", 0x1F6B)
CheckCompUni("<apostrophe> <parenright> <Greek_OMEGA>", 0x1F6C)
CheckCompUni("<apostrophe> <U0313> <Greek_OMEGA>", 0x1F6C)
CheckCompUni("<acute> <parenright> <Greek_OMEGA>", 0x1F6C)
CheckCompUni("<acute> <U0313> <Greek_OMEGA>", 0x1F6C)
CheckCompUni("<apostrophe> <U1f68>", 0x1F6C)
CheckCompUni("<acute> <U1f68>", 0x1F6C)
CheckCompUni("<apostrophe> <parenleft> <Greek_OMEGA>", 0x1F6D)
CheckCompUni("<apostrophe> <U0314> <Greek_OMEGA>", 0x1F6D)
CheckCompUni("<acute> <parenleft> <Greek_OMEGA>", 0x1F6D)
CheckCompUni("<acute> <U0314> <Greek_OMEGA>", 0x1F6D)
CheckCompUni("<apostrophe> <U1f69>", 0x1F6D)
CheckCompUni("<acute> <U1f69>", 0x1F6D)
CheckCompUni("<asciitilde> <parenright> <Greek_OMEGA>", 0x1F6E)
CheckCompUni("<asciitilde> <U0313> <Greek_OMEGA>", 0x1F6E)
CheckCompUni("<asciitilde> <U1f68>", 0x1F6E)
CheckCompUni("<asciitilde> <parenleft> <Greek_OMEGA>", 0x1F6F)
CheckCompUni("<asciitilde> <U0314> <Greek_OMEGA>", 0x1F6F)
CheckCompUni("<asciitilde> <U1f69>", 0x1F6F)
CheckCompUni("<grave> <Greek_alpha>", 0x1F70)
CheckCompUni("<grave> <Greek_epsilon>", 0x1F72)
CheckCompUni("<grave> <Greek_eta>", 0x1F74)
CheckCompUni("<grave> <Greek_iota>", 0x1F76)
CheckCompUni("<grave> <Greek_omicron>", 0x1F78)
CheckCompUni("<grave> <Greek_upsilon>", 0x1F7A)
CheckCompUni("<grave> <Greek_omega>", 0x1F7C)
CheckCompUni("<Greek_iota> <parenright> <Greek_alpha>", 0x1F80)
CheckCompUni("<Greek_iota> <U0313> <Greek_alpha>", 0x1F80)
CheckCompUni("<Greek_iota> <U1f00>", 0x1F80)
CheckCompUni("<Greek_iota> <parenleft> <Greek_alpha>", 0x1F81)
CheckCompUni("<Greek_iota> <U0314> <Greek_alpha>", 0x1F81)
CheckCompUni("<Greek_iota> <U1f01>", 0x1F81)
CheckCompUni("<Greek_iota> <combining_grave> <parenright> <Greek_alpha>", 0x1F82)
CheckCompUni("<Greek_iota> <combining_grave> <U0313> <Greek_alpha>", 0x1F82)
CheckCompUni("<Greek_iota> <combining_grave> <U1f00>", 0x1F82)
CheckCompUni("<Greek_iota> <grave> <parenright> <Greek_alpha>", 0x1F82)
CheckCompUni("<Greek_iota> <grave> <U0313> <Greek_alpha>", 0x1F82)
CheckCompUni("<Greek_iota> <dead_grave> <parenright> <Greek_alpha>", 0x1F82)
CheckCompUni("<Greek_iota> <dead_grave> <U0313> <Greek_alpha>", 0x1F82)
CheckCompUni("<Greek_iota> <grave> <U1f00>", 0x1F82)
CheckCompUni("<Greek_iota> <dead_grave> <U1f00>", 0x1F82)
CheckCompUni("<Greek_iota> <U1f02>", 0x1F82)
CheckCompUni("<Greek_iota> <combining_grave> <parenleft> <Greek_alpha>", 0x1F83)
CheckCompUni("<Greek_iota> <combining_grave> <U0314> <Greek_alpha>", 0x1F83)
CheckCompUni("<Greek_iota> <combining_grave> <U1f01>", 0x1F83)
CheckCompUni("<Greek_iota> <grave> <parenleft> <Greek_alpha>", 0x1F83)
CheckCompUni("<Greek_iota> <grave> <U0314> <Greek_alpha>", 0x1F83)
CheckCompUni("<Greek_iota> <dead_grave> <parenleft> <Greek_alpha>", 0x1F83)
CheckCompUni("<Greek_iota> <dead_grave> <U0314> <Greek_alpha>", 0x1F83)
CheckCompUni("<Greek_iota> <grave> <U1f01>", 0x1F83)
CheckCompUni("<Greek_iota> <dead_grave> <U1f01>", 0x1F83)
CheckCompUni("<Greek_iota> <U1f03>", 0x1F83)
CheckCompUni("<Greek_iota> <combining_acute> <parenright> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <combining_acute> <U0313> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <combining_acute> <U1f00>", 0x1F84)
CheckCompUni("<Greek_iota> <apostrophe> <parenright> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <apostrophe> <U0313> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <acute> <parenright> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <acute> <U0313> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <dead_acute> <parenright> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <dead_acute> <U0313> <Greek_alpha>", 0x1F84)
CheckCompUni("<Greek_iota> <apostrophe> <U1f00>", 0x1F84)
CheckCompUni("<Greek_iota> <acute> <U1f00>", 0x1F84)
CheckCompUni("<Greek_iota> <dead_acute> <U1f00>", 0x1F84)
CheckCompUni("<Greek_iota> <U1f04>", 0x1F84)
CheckCompUni("<Greek_iota> <combining_acute> <parenleft> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <combining_acute> <U0314> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <combining_acute> <U1f01>", 0x1F85)
CheckCompUni("<Greek_iota> <apostrophe> <parenleft> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <apostrophe> <U0314> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <acute> <parenleft> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <acute> <U0314> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <dead_acute> <parenleft> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <dead_acute> <U0314> <Greek_alpha>", 0x1F85)
CheckCompUni("<Greek_iota> <apostrophe> <U1f01>", 0x1F85)
CheckCompUni("<Greek_iota> <acute> <U1f01>", 0x1F85)
CheckCompUni("<Greek_iota> <dead_acute> <U1f01>", 0x1F85)
CheckCompUni("<Greek_iota> <U1f05>", 0x1F85)
CheckCompUni("<Greek_iota> <asciitilde> <parenright> <Greek_alpha>", 0x1F86)
CheckCompUni("<Greek_iota> <asciitilde> <U0313> <Greek_alpha>", 0x1F86)
CheckCompUni("<Greek_iota> <dead_tilde> <parenright> <Greek_alpha>", 0x1F86)
CheckCompUni("<Greek_iota> <dead_tilde> <U0313> <Greek_alpha>", 0x1F86)
CheckCompUni("<Greek_iota> <U0342> <parenright> <Greek_alpha>", 0x1F86)
CheckCompUni("<Greek_iota> <U0342> <U0313> <Greek_alpha>", 0x1F86)
CheckCompUni("<Greek_iota> <asciitilde> <U1f00>", 0x1F86)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f00>", 0x1F86)
CheckCompUni("<Greek_iota> <U0342> <U1f00>", 0x1F86)
CheckCompUni("<Greek_iota> <U1f06>", 0x1F86)
CheckCompUni("<Greek_iota> <asciitilde> <parenleft> <Greek_alpha>", 0x1F87)
CheckCompUni("<Greek_iota> <asciitilde> <U0314> <Greek_alpha>", 0x1F87)
CheckCompUni("<Greek_iota> <dead_tilde> <parenleft> <Greek_alpha>", 0x1F87)
CheckCompUni("<Greek_iota> <dead_tilde> <U0314> <Greek_alpha>", 0x1F87)
CheckCompUni("<Greek_iota> <U0342> <parenleft> <Greek_alpha>", 0x1F87)
CheckCompUni("<Greek_iota> <U0342> <U0314> <Greek_alpha>", 0x1F87)
CheckCompUni("<Greek_iota> <asciitilde> <U1f01>", 0x1F87)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f01>", 0x1F87)
CheckCompUni("<Greek_iota> <U0342> <U1f01>", 0x1F87)
CheckCompUni("<Greek_iota> <U1f07>", 0x1F87)
CheckCompUni("<Greek_iota> <parenright> <Greek_ALPHA>", 0x1F88)
CheckCompUni("<Greek_iota> <U0313> <Greek_ALPHA>", 0x1F88)
CheckCompUni("<Greek_iota> <U1f08>", 0x1F88)
CheckCompUni("<Greek_iota> <parenleft> <Greek_ALPHA>", 0x1F89)
CheckCompUni("<Greek_iota> <U0314> <Greek_ALPHA>", 0x1F89)
CheckCompUni("<Greek_iota> <U1f09>", 0x1F89)
CheckCompUni("<Greek_iota> <combining_grave> <parenright> <Greek_ALPHA>", 0x1F8A)
CheckCompUni("<Greek_iota> <combining_grave> <U0313> <Greek_ALPHA>", 0x1F8A)
CheckCompUni("<Greek_iota> <combining_grave> <U1f08>", 0x1F8A)
CheckCompUni("<Greek_iota> <grave> <parenright> <Greek_ALPHA>", 0x1F8A)
CheckCompUni("<Greek_iota> <grave> <U0313> <Greek_ALPHA>", 0x1F8A)
CheckCompUni("<Greek_iota> <dead_grave> <parenright> <Greek_ALPHA>", 0x1F8A)
CheckCompUni("<Greek_iota> <dead_grave> <U0313> <Greek_ALPHA>", 0x1F8A)
CheckCompUni("<Greek_iota> <grave> <U1f08>", 0x1F8A)
CheckCompUni("<Greek_iota> <dead_grave> <U1f08>", 0x1F8A)
CheckCompUni("<Greek_iota> <U1f0a>", 0x1F8A)
CheckCompUni("<Greek_iota> <combining_grave> <parenleft> <Greek_ALPHA>", 0x1F8B)
CheckCompUni("<Greek_iota> <combining_grave> <U0314> <Greek_ALPHA>", 0x1F8B)
CheckCompUni("<Greek_iota> <combining_grave> <U1f09>", 0x1F8B)
CheckCompUni("<Greek_iota> <grave> <parenleft> <Greek_ALPHA>", 0x1F8B)
CheckCompUni("<Greek_iota> <grave> <U0314> <Greek_ALPHA>", 0x1F8B)
CheckCompUni("<Greek_iota> <dead_grave> <parenleft> <Greek_ALPHA>", 0x1F8B)
CheckCompUni("<Greek_iota> <dead_grave> <U0314> <Greek_ALPHA>", 0x1F8B)
CheckCompUni("<Greek_iota> <grave> <U1f09>", 0x1F8B)
CheckCompUni("<Greek_iota> <dead_grave> <U1f09>", 0x1F8B)
CheckCompUni("<Greek_iota> <U1f0b>", 0x1F8B)
CheckCompUni("<Greek_iota> <combining_acute> <parenright> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <combining_acute> <U0313> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <combining_acute> <U1f08>", 0x1F8C)
CheckCompUni("<Greek_iota> <apostrophe> <parenright> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <apostrophe> <U0313> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <acute> <parenright> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <acute> <U0313> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <dead_acute> <parenright> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <dead_acute> <U0313> <Greek_ALPHA>", 0x1F8C)
CheckCompUni("<Greek_iota> <apostrophe> <U1f08>", 0x1F8C)
CheckCompUni("<Greek_iota> <acute> <U1f08>", 0x1F8C)
CheckCompUni("<Greek_iota> <dead_acute> <U1f08>", 0x1F8C)
CheckCompUni("<Greek_iota> <U1f0c>", 0x1F8C)
CheckCompUni("<Greek_iota> <combining_acute> <parenleft> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <combining_acute> <U0314> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <combining_acute> <U1f09>", 0x1F8D)
CheckCompUni("<Greek_iota> <apostrophe> <parenleft> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <apostrophe> <U0314> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <acute> <parenleft> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <acute> <U0314> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <dead_acute> <parenleft> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <dead_acute> <U0314> <Greek_ALPHA>", 0x1F8D)
CheckCompUni("<Greek_iota> <apostrophe> <U1f09>", 0x1F8D)
CheckCompUni("<Greek_iota> <acute> <U1f09>", 0x1F8D)
CheckCompUni("<Greek_iota> <dead_acute> <U1f09>", 0x1F8D)
CheckCompUni("<Greek_iota> <U1f0d>", 0x1F8D)
CheckCompUni("<Greek_iota> <asciitilde> <parenright> <Greek_ALPHA>", 0x1F8E)
CheckCompUni("<Greek_iota> <asciitilde> <U0313> <Greek_ALPHA>", 0x1F8E)
CheckCompUni("<Greek_iota> <dead_tilde> <parenright> <Greek_ALPHA>", 0x1F8E)
CheckCompUni("<Greek_iota> <dead_tilde> <U0313> <Greek_ALPHA>", 0x1F8E)
CheckCompUni("<Greek_iota> <U0342> <parenright> <Greek_ALPHA>", 0x1F8E)
CheckCompUni("<Greek_iota> <U0342> <U0313> <Greek_ALPHA>", 0x1F8E)
CheckCompUni("<Greek_iota> <asciitilde> <U1f08>", 0x1F8E)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f08>", 0x1F8E)
CheckCompUni("<Greek_iota> <U0342> <U1f08>", 0x1F8E)
CheckCompUni("<Greek_iota> <U1f0e>", 0x1F8E)
CheckCompUni("<Greek_iota> <asciitilde> <parenleft> <Greek_ALPHA>", 0x1F8F)
CheckCompUni("<Greek_iota> <asciitilde> <U0314> <Greek_ALPHA>", 0x1F8F)
CheckCompUni("<Greek_iota> <dead_tilde> <parenleft> <Greek_ALPHA>", 0x1F8F)
CheckCompUni("<Greek_iota> <dead_tilde> <U0314> <Greek_ALPHA>", 0x1F8F)
CheckCompUni("<Greek_iota> <U0342> <parenleft> <Greek_ALPHA>", 0x1F8F)
CheckCompUni("<Greek_iota> <U0342> <U0314> <Greek_ALPHA>", 0x1F8F)
CheckCompUni("<Greek_iota> <asciitilde> <U1f09>", 0x1F8F)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f09>", 0x1F8F)
CheckCompUni("<Greek_iota> <U0342> <U1f09>", 0x1F8F)
CheckCompUni("<Greek_iota> <U1f0f>", 0x1F8F)
CheckCompUni("<Greek_iota> <parenright> <Greek_eta>", 0x1F90)
CheckCompUni("<Greek_iota> <U0313> <Greek_eta>", 0x1F90)
CheckCompUni("<Greek_iota> <U1f20>", 0x1F90)
CheckCompUni("<Greek_iota> <parenleft> <Greek_eta>", 0x1F91)
CheckCompUni("<Greek_iota> <U0314> <Greek_eta>", 0x1F91)
CheckCompUni("<Greek_iota> <U1f21>", 0x1F91)
CheckCompUni("<Greek_iota> <combining_grave> <parenright> <Greek_eta>", 0x1F92)
CheckCompUni("<Greek_iota> <combining_grave> <U0313> <Greek_eta>", 0x1F92)
CheckCompUni("<Greek_iota> <combining_grave> <U1f20>", 0x1F92)
CheckCompUni("<Greek_iota> <grave> <parenright> <Greek_eta>", 0x1F92)
CheckCompUni("<Greek_iota> <grave> <U0313> <Greek_eta>", 0x1F92)
CheckCompUni("<Greek_iota> <dead_grave> <parenright> <Greek_eta>", 0x1F92)
CheckCompUni("<Greek_iota> <dead_grave> <U0313> <Greek_eta>", 0x1F92)
CheckCompUni("<Greek_iota> <grave> <U1f20>", 0x1F92)
CheckCompUni("<Greek_iota> <dead_grave> <U1f20>", 0x1F92)
CheckCompUni("<Greek_iota> <U1f22>", 0x1F92)
CheckCompUni("<Greek_iota> <combining_grave> <parenleft> <Greek_eta>", 0x1F93)
CheckCompUni("<Greek_iota> <combining_grave> <U0314> <Greek_eta>", 0x1F93)
CheckCompUni("<Greek_iota> <combining_grave> <U1f21>", 0x1F93)
CheckCompUni("<Greek_iota> <grave> <parenleft> <Greek_eta>", 0x1F93)
CheckCompUni("<Greek_iota> <grave> <U0314> <Greek_eta>", 0x1F93)
CheckCompUni("<Greek_iota> <dead_grave> <parenleft> <Greek_eta>", 0x1F93)
CheckCompUni("<Greek_iota> <dead_grave> <U0314> <Greek_eta>", 0x1F93)
CheckCompUni("<Greek_iota> <grave> <U1f21>", 0x1F93)
CheckCompUni("<Greek_iota> <dead_grave> <U1f21>", 0x1F93)
CheckCompUni("<Greek_iota> <U1f23>", 0x1F93)
CheckCompUni("<Greek_iota> <combining_acute> <parenright> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <combining_acute> <U0313> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <combining_acute> <U1f20>", 0x1F94)
CheckCompUni("<Greek_iota> <apostrophe> <parenright> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <apostrophe> <U0313> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <acute> <parenright> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <acute> <U0313> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <dead_acute> <parenright> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <dead_acute> <U0313> <Greek_eta>", 0x1F94)
CheckCompUni("<Greek_iota> <apostrophe> <U1f20>", 0x1F94)
CheckCompUni("<Greek_iota> <acute> <U1f20>", 0x1F94)
CheckCompUni("<Greek_iota> <dead_acute> <U1f20>", 0x1F94)
CheckCompUni("<Greek_iota> <U1f24>", 0x1F94)
CheckCompUni("<Greek_iota> <combining_acute> <parenleft> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <combining_acute> <U0314> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <combining_acute> <U1f21>", 0x1F95)
CheckCompUni("<Greek_iota> <apostrophe> <parenleft> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <apostrophe> <U0314> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <acute> <parenleft> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <acute> <U0314> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <dead_acute> <parenleft> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <dead_acute> <U0314> <Greek_eta>", 0x1F95)
CheckCompUni("<Greek_iota> <apostrophe> <U1f21>", 0x1F95)
CheckCompUni("<Greek_iota> <acute> <U1f21>", 0x1F95)
CheckCompUni("<Greek_iota> <dead_acute> <U1f21>", 0x1F95)
CheckCompUni("<Greek_iota> <U1f25>", 0x1F95)
CheckCompUni("<Greek_iota> <asciitilde> <parenright> <Greek_eta>", 0x1F96)
CheckCompUni("<Greek_iota> <asciitilde> <U0313> <Greek_eta>", 0x1F96)
CheckCompUni("<Greek_iota> <dead_tilde> <parenright> <Greek_eta>", 0x1F96)
CheckCompUni("<Greek_iota> <dead_tilde> <U0313> <Greek_eta>", 0x1F96)
CheckCompUni("<Greek_iota> <U0342> <parenright> <Greek_eta>", 0x1F96)
CheckCompUni("<Greek_iota> <U0342> <U0313> <Greek_eta>", 0x1F96)
CheckCompUni("<Greek_iota> <asciitilde> <U1f20>", 0x1F96)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f20>", 0x1F96)
CheckCompUni("<Greek_iota> <U0342> <U1f20>", 0x1F96)
CheckCompUni("<Greek_iota> <U1f26>", 0x1F96)
CheckCompUni("<Greek_iota> <asciitilde> <parenleft> <Greek_eta>", 0x1F97)
CheckCompUni("<Greek_iota> <asciitilde> <U0314> <Greek_eta>", 0x1F97)
CheckCompUni("<Greek_iota> <dead_tilde> <parenleft> <Greek_eta>", 0x1F97)
CheckCompUni("<Greek_iota> <dead_tilde> <U0314> <Greek_eta>", 0x1F97)
CheckCompUni("<Greek_iota> <U0342> <parenleft> <Greek_eta>", 0x1F97)
CheckCompUni("<Greek_iota> <U0342> <U0314> <Greek_eta>", 0x1F97)
CheckCompUni("<Greek_iota> <asciitilde> <U1f21>", 0x1F97)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f21>", 0x1F97)
CheckCompUni("<Greek_iota> <U0342> <U1f21>", 0x1F97)
CheckCompUni("<Greek_iota> <U1f27>", 0x1F97)
CheckCompUni("<Greek_iota> <parenright> <Greek_ETA>", 0x1F98)
CheckCompUni("<Greek_iota> <U0313> <Greek_ETA>", 0x1F98)
CheckCompUni("<Greek_iota> <U1f28>", 0x1F98)
CheckCompUni("<Greek_iota> <parenleft> <Greek_ETA>", 0x1F99)
CheckCompUni("<Greek_iota> <U0314> <Greek_ETA>", 0x1F99)
CheckCompUni("<Greek_iota> <U1f29>", 0x1F99)
CheckCompUni("<Greek_iota> <combining_grave> <parenright> <Greek_ETA>", 0x1F9A)
CheckCompUni("<Greek_iota> <combining_grave> <U0313> <Greek_ETA>", 0x1F9A)
CheckCompUni("<Greek_iota> <combining_grave> <U1f28>", 0x1F9A)
CheckCompUni("<Greek_iota> <grave> <parenright> <Greek_ETA>", 0x1F9A)
CheckCompUni("<Greek_iota> <grave> <U0313> <Greek_ETA>", 0x1F9A)
CheckCompUni("<Greek_iota> <dead_grave> <parenright> <Greek_ETA>", 0x1F9A)
CheckCompUni("<Greek_iota> <dead_grave> <U0313> <Greek_ETA>", 0x1F9A)
CheckCompUni("<Greek_iota> <grave> <U1f28>", 0x1F9A)
CheckCompUni("<Greek_iota> <dead_grave> <U1f28>", 0x1F9A)
CheckCompUni("<Greek_iota> <U1f2a>", 0x1F9A)
CheckCompUni("<Greek_iota> <combining_grave> <parenleft> <Greek_ETA>", 0x1F9B)
CheckCompUni("<Greek_iota> <combining_grave> <U0314> <Greek_ETA>", 0x1F9B)
CheckCompUni("<Greek_iota> <combining_grave> <U1f29>", 0x1F9B)
CheckCompUni("<Greek_iota> <grave> <parenleft> <Greek_ETA>", 0x1F9B)
CheckCompUni("<Greek_iota> <grave> <U0314> <Greek_ETA>", 0x1F9B)
CheckCompUni("<Greek_iota> <dead_grave> <parenleft> <Greek_ETA>", 0x1F9B)
CheckCompUni("<Greek_iota> <dead_grave> <U0314> <Greek_ETA>", 0x1F9B)
CheckCompUni("<Greek_iota> <grave> <U1f29>", 0x1F9B)
CheckCompUni("<Greek_iota> <dead_grave> <U1f29>", 0x1F9B)
CheckCompUni("<Greek_iota> <U1f2b>", 0x1F9B)
CheckCompUni("<Greek_iota> <combining_acute> <parenright> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <combining_acute> <U0313> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <combining_acute> <U1f28>", 0x1F9C)
CheckCompUni("<Greek_iota> <apostrophe> <parenright> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <apostrophe> <U0313> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <acute> <parenright> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <acute> <U0313> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <dead_acute> <parenright> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <dead_acute> <U0313> <Greek_ETA>", 0x1F9C)
CheckCompUni("<Greek_iota> <apostrophe> <U1f28>", 0x1F9C)
CheckCompUni("<Greek_iota> <acute> <U1f28>", 0x1F9C)
CheckCompUni("<Greek_iota> <dead_acute> <U1f28>", 0x1F9C)
CheckCompUni("<Greek_iota> <U1f2c>", 0x1F9C)
CheckCompUni("<Greek_iota> <combining_acute> <parenleft> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <combining_acute> <U0314> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <combining_acute> <U1f29>", 0x1F9D)
CheckCompUni("<Greek_iota> <apostrophe> <parenleft> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <apostrophe> <U0314> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <acute> <parenleft> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <acute> <U0314> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <dead_acute> <parenleft> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <dead_acute> <U0314> <Greek_ETA>", 0x1F9D)
CheckCompUni("<Greek_iota> <apostrophe> <U1f29>", 0x1F9D)
CheckCompUni("<Greek_iota> <acute> <U1f29>", 0x1F9D)
CheckCompUni("<Greek_iota> <dead_acute> <U1f29>", 0x1F9D)
CheckCompUni("<Greek_iota> <U1f2d>", 0x1F9D)
CheckCompUni("<Greek_iota> <asciitilde> <parenright> <Greek_ETA>", 0x1F9E)
CheckCompUni("<Greek_iota> <asciitilde> <U0313> <Greek_ETA>", 0x1F9E)
CheckCompUni("<Greek_iota> <dead_tilde> <parenright> <Greek_ETA>", 0x1F9E)
CheckCompUni("<Greek_iota> <dead_tilde> <U0313> <Greek_ETA>", 0x1F9E)
CheckCompUni("<Greek_iota> <U0342> <parenright> <Greek_ETA>", 0x1F9E)
CheckCompUni("<Greek_iota> <U0342> <U0313> <Greek_ETA>", 0x1F9E)
CheckCompUni("<Greek_iota> <asciitilde> <U1f28>", 0x1F9E)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f28>", 0x1F9E)
CheckCompUni("<Greek_iota> <U0342> <U1f28>", 0x1F9E)
CheckCompUni("<Greek_iota> <U1f2e>", 0x1F9E)
CheckCompUni("<Greek_iota> <asciitilde> <parenleft> <Greek_ETA>", 0x1F9F)
CheckCompUni("<Greek_iota> <asciitilde> <U0314> <Greek_ETA>", 0x1F9F)
CheckCompUni("<Greek_iota> <dead_tilde> <parenleft> <Greek_ETA>", 0x1F9F)
CheckCompUni("<Greek_iota> <dead_tilde> <U0314> <Greek_ETA>", 0x1F9F)
CheckCompUni("<Greek_iota> <U0342> <parenleft> <Greek_ETA>", 0x1F9F)
CheckCompUni("<Greek_iota> <U0342> <U0314> <Greek_ETA>", 0x1F9F)
CheckCompUni("<Greek_iota> <asciitilde> <U1f29>", 0x1F9F)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f29>", 0x1F9F)
CheckCompUni("<Greek_iota> <U0342> <U1f29>", 0x1F9F)
CheckCompUni("<Greek_iota> <U1f2f>", 0x1F9F)
CheckCompUni("<Greek_iota> <parenright> <Greek_omega>", 0x1FA0)
CheckCompUni("<Greek_iota> <U0313> <Greek_omega>", 0x1FA0)
CheckCompUni("<Greek_iota> <U1f60>", 0x1FA0)
CheckCompUni("<Greek_iota> <parenleft> <Greek_omega>", 0x1FA1)
CheckCompUni("<Greek_iota> <U0314> <Greek_omega>", 0x1FA1)
CheckCompUni("<Greek_iota> <U1f61>", 0x1FA1)
CheckCompUni("<Greek_iota> <combining_grave> <parenright> <Greek_omega>", 0x1FA2)
CheckCompUni("<Greek_iota> <combining_grave> <U0313> <Greek_omega>", 0x1FA2)
CheckCompUni("<Greek_iota> <combining_grave> <U1f60>", 0x1FA2)
CheckCompUni("<Greek_iota> <grave> <parenright> <Greek_omega>", 0x1FA2)
CheckCompUni("<Greek_iota> <grave> <U0313> <Greek_omega>", 0x1FA2)
CheckCompUni("<Greek_iota> <dead_grave> <parenright> <Greek_omega>", 0x1FA2)
CheckCompUni("<Greek_iota> <dead_grave> <U0313> <Greek_omega>", 0x1FA2)
CheckCompUni("<Greek_iota> <grave> <U1f60>", 0x1FA2)
CheckCompUni("<Greek_iota> <dead_grave> <U1f60>", 0x1FA2)
CheckCompUni("<Greek_iota> <U1f62>", 0x1FA2)
CheckCompUni("<Greek_iota> <combining_grave> <parenleft> <Greek_omega>", 0x1FA3)
CheckCompUni("<Greek_iota> <combining_grave> <U0314> <Greek_omega>", 0x1FA3)
CheckCompUni("<Greek_iota> <combining_grave> <U1f61>", 0x1FA3)
CheckCompUni("<Greek_iota> <grave> <parenleft> <Greek_omega>", 0x1FA3)
CheckCompUni("<Greek_iota> <grave> <U0314> <Greek_omega>", 0x1FA3)
CheckCompUni("<Greek_iota> <dead_grave> <parenleft> <Greek_omega>", 0x1FA3)
CheckCompUni("<Greek_iota> <dead_grave> <U0314> <Greek_omega>", 0x1FA3)
CheckCompUni("<Greek_iota> <grave> <U1f61>", 0x1FA3)
CheckCompUni("<Greek_iota> <dead_grave> <U1f61>", 0x1FA3)
CheckCompUni("<Greek_iota> <U1f63>", 0x1FA3)
CheckCompUni("<Greek_iota> <combining_acute> <parenright> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <combining_acute> <U0313> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <combining_acute> <U1f60>", 0x1FA4)
CheckCompUni("<Greek_iota> <apostrophe> <parenright> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <apostrophe> <U0313> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <acute> <parenright> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <acute> <U0313> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <dead_acute> <parenright> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <dead_acute> <U0313> <Greek_omega>", 0x1FA4)
CheckCompUni("<Greek_iota> <apostrophe> <U1f60>", 0x1FA4)
CheckCompUni("<Greek_iota> <acute> <U1f60>", 0x1FA4)
CheckCompUni("<Greek_iota> <dead_acute> <U1f60>", 0x1FA4)
CheckCompUni("<Greek_iota> <U1f64>", 0x1FA4)
CheckCompUni("<Greek_iota> <combining_acute> <parenleft> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <combining_acute> <U0314> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <combining_acute> <U1f61>", 0x1FA5)
CheckCompUni("<Greek_iota> <apostrophe> <parenleft> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <apostrophe> <U0314> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <acute> <parenleft> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <acute> <U0314> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <dead_acute> <parenleft> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <dead_acute> <U0314> <Greek_omega>", 0x1FA5)
CheckCompUni("<Greek_iota> <apostrophe> <U1f61>", 0x1FA5)
CheckCompUni("<Greek_iota> <acute> <U1f61>", 0x1FA5)
CheckCompUni("<Greek_iota> <dead_acute> <U1f61>", 0x1FA5)
CheckCompUni("<Greek_iota> <U1f65>", 0x1FA5)
CheckCompUni("<Greek_iota> <asciitilde> <parenright> <Greek_omega>", 0x1FA6)
CheckCompUni("<Greek_iota> <asciitilde> <U0313> <Greek_omega>", 0x1FA6)
CheckCompUni("<Greek_iota> <dead_tilde> <parenright> <Greek_omega>", 0x1FA6)
CheckCompUni("<Greek_iota> <dead_tilde> <U0313> <Greek_omega>", 0x1FA6)
CheckCompUni("<Greek_iota> <U0342> <parenright> <Greek_omega>", 0x1FA6)
CheckCompUni("<Greek_iota> <U0342> <U0313> <Greek_omega>", 0x1FA6)
CheckCompUni("<Greek_iota> <asciitilde> <U1f60>", 0x1FA6)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f60>", 0x1FA6)
CheckCompUni("<Greek_iota> <U0342> <U1f60>", 0x1FA6)
CheckCompUni("<Greek_iota> <U1f66>", 0x1FA6)
CheckCompUni("<Greek_iota> <asciitilde> <parenleft> <Greek_omega>", 0x1FA7)
CheckCompUni("<Greek_iota> <asciitilde> <U0314> <Greek_omega>", 0x1FA7)
CheckCompUni("<Greek_iota> <dead_tilde> <parenleft> <Greek_omega>", 0x1FA7)
CheckCompUni("<Greek_iota> <dead_tilde> <U0314> <Greek_omega>", 0x1FA7)
CheckCompUni("<Greek_iota> <U0342> <parenleft> <Greek_omega>", 0x1FA7)
CheckCompUni("<Greek_iota> <U0342> <U0314> <Greek_omega>", 0x1FA7)
CheckCompUni("<Greek_iota> <asciitilde> <U1f61>", 0x1FA7)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f61>", 0x1FA7)
CheckCompUni("<Greek_iota> <U0342> <U1f61>", 0x1FA7)
CheckCompUni("<Greek_iota> <U1f67>", 0x1FA7)
CheckCompUni("<Greek_iota> <parenright> <Greek_OMEGA>", 0x1FA8)
CheckCompUni("<Greek_iota> <U0313> <Greek_OMEGA>", 0x1FA8)
CheckCompUni("<Greek_iota> <U1f68>", 0x1FA8)
CheckCompUni("<Greek_iota> <parenleft> <Greek_OMEGA>", 0x1FA9)
CheckCompUni("<Greek_iota> <U0314> <Greek_OMEGA>", 0x1FA9)
CheckCompUni("<Greek_iota> <U1f69>", 0x1FA9)
CheckCompUni("<Greek_iota> <combining_grave> <parenright> <Greek_OMEGA>", 0x1FAA)
CheckCompUni("<Greek_iota> <combining_grave> <U0313> <Greek_OMEGA>", 0x1FAA)
CheckCompUni("<Greek_iota> <combining_grave> <U1f68>", 0x1FAA)
CheckCompUni("<Greek_iota> <grave> <parenright> <Greek_OMEGA>", 0x1FAA)
CheckCompUni("<Greek_iota> <grave> <U0313> <Greek_OMEGA>", 0x1FAA)
CheckCompUni("<Greek_iota> <dead_grave> <parenright> <Greek_OMEGA>", 0x1FAA)
CheckCompUni("<Greek_iota> <dead_grave> <U0313> <Greek_OMEGA>", 0x1FAA)
CheckCompUni("<Greek_iota> <grave> <U1f68>", 0x1FAA)
CheckCompUni("<Greek_iota> <dead_grave> <U1f68>", 0x1FAA)
CheckCompUni("<Greek_iota> <U1f6a>", 0x1FAA)
CheckCompUni("<Greek_iota> <combining_grave> <parenleft> <Greek_OMEGA>", 0x1FAB)
CheckCompUni("<Greek_iota> <combining_grave> <U0314> <Greek_OMEGA>", 0x1FAB)
CheckCompUni("<Greek_iota> <combining_grave> <U1f69>", 0x1FAB)
CheckCompUni("<Greek_iota> <grave> <parenleft> <Greek_OMEGA>", 0x1FAB)
CheckCompUni("<Greek_iota> <grave> <U0314> <Greek_OMEGA>", 0x1FAB)
CheckCompUni("<Greek_iota> <dead_grave> <parenleft> <Greek_OMEGA>", 0x1FAB)
CheckCompUni("<Greek_iota> <dead_grave> <U0314> <Greek_OMEGA>", 0x1FAB)
CheckCompUni("<Greek_iota> <grave> <U1f69>", 0x1FAB)
CheckCompUni("<Greek_iota> <dead_grave> <U1f69>", 0x1FAB)
CheckCompUni("<Greek_iota> <U1f6b>", 0x1FAB)
CheckCompUni("<Greek_iota> <combining_acute> <parenright> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <combining_acute> <U0313> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <combining_acute> <U1f68>", 0x1FAC)
CheckCompUni("<Greek_iota> <apostrophe> <parenright> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <apostrophe> <U0313> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <acute> <parenright> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <acute> <U0313> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <dead_acute> <parenright> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <dead_acute> <U0313> <Greek_OMEGA>", 0x1FAC)
CheckCompUni("<Greek_iota> <apostrophe> <U1f68>", 0x1FAC)
CheckCompUni("<Greek_iota> <acute> <U1f68>", 0x1FAC)
CheckCompUni("<Greek_iota> <dead_acute> <U1f68>", 0x1FAC)
CheckCompUni("<Greek_iota> <U1f6c>", 0x1FAC)
CheckCompUni("<Greek_iota> <combining_acute> <parenleft> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <combining_acute> <U0314> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <combining_acute> <U1f69>", 0x1FAD)
CheckCompUni("<Greek_iota> <apostrophe> <parenleft> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <apostrophe> <U0314> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <acute> <parenleft> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <acute> <U0314> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <dead_acute> <parenleft> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <dead_acute> <U0314> <Greek_OMEGA>", 0x1FAD)
CheckCompUni("<Greek_iota> <apostrophe> <U1f69>", 0x1FAD)
CheckCompUni("<Greek_iota> <acute> <U1f69>", 0x1FAD)
CheckCompUni("<Greek_iota> <dead_acute> <U1f69>", 0x1FAD)
CheckCompUni("<Greek_iota> <U1f6d>", 0x1FAD)
CheckCompUni("<Greek_iota> <asciitilde> <parenright> <Greek_OMEGA>", 0x1FAE)
CheckCompUni("<Greek_iota> <asciitilde> <U0313> <Greek_OMEGA>", 0x1FAE)
CheckCompUni("<Greek_iota> <dead_tilde> <parenright> <Greek_OMEGA>", 0x1FAE)
CheckCompUni("<Greek_iota> <dead_tilde> <U0313> <Greek_OMEGA>", 0x1FAE)
CheckCompUni("<Greek_iota> <U0342> <parenright> <Greek_OMEGA>", 0x1FAE)
CheckCompUni("<Greek_iota> <U0342> <U0313> <Greek_OMEGA>", 0x1FAE)
CheckCompUni("<Greek_iota> <asciitilde> <U1f68>", 0x1FAE)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f68>", 0x1FAE)
CheckCompUni("<Greek_iota> <U0342> <U1f68>", 0x1FAE)
CheckCompUni("<Greek_iota> <U1f6e>", 0x1FAE)
CheckCompUni("<Greek_iota> <asciitilde> <parenleft> <Greek_OMEGA>", 0x1FAF)
CheckCompUni("<Greek_iota> <asciitilde> <U0314> <Greek_OMEGA>", 0x1FAF)
CheckCompUni("<Greek_iota> <dead_tilde> <parenleft> <Greek_OMEGA>", 0x1FAF)
CheckCompUni("<Greek_iota> <dead_tilde> <U0314> <Greek_OMEGA>", 0x1FAF)
CheckCompUni("<Greek_iota> <U0342> <parenleft> <Greek_OMEGA>", 0x1FAF)
CheckCompUni("<Greek_iota> <U0342> <U0314> <Greek_OMEGA>", 0x1FAF)
CheckCompUni("<Greek_iota> <asciitilde> <U1f69>", 0x1FAF)
CheckCompUni("<Greek_iota> <dead_tilde> <U1f69>", 0x1FAF)
CheckCompUni("<Greek_iota> <U0342> <U1f69>", 0x1FAF)
CheckCompUni("<Greek_iota> <U1f6f>", 0x1FAF)
CheckCompUni("<b> <Greek_alpha>", 0x1FB0)
CheckCompUni("<U> <Greek_alpha>", 0x1FB0)
CheckCompUni("<underscore> <Greek_alpha>", 0x1FB1)
CheckCompUni("<macron> <Greek_alpha>", 0x1FB1)
CheckCompUni("<Greek_iota> <combining_grave> <Greek_alpha>", 0x1FB2)
CheckCompUni("<Greek_iota> <grave> <Greek_alpha>", 0x1FB2)
CheckCompUni("<Greek_iota> <dead_grave> <Greek_alpha>", 0x1FB2)
CheckCompUni("<Greek_iota> <U1f70>", 0x1FB2)
CheckCompUni("<Greek_iota> <Greek_alpha>", 0x1FB3)
CheckCompUni("<Greek_iota> <combining_acute> <Greek_alpha>", 0x1FB4)
CheckCompUni("<Greek_iota> <apostrophe> <Greek_alpha>", 0x1FB4)
CheckCompUni("<Greek_iota> <acute> <Greek_alpha>", 0x1FB4)
CheckCompUni("<Greek_iota> <dead_acute> <Greek_alpha>", 0x1FB4)
CheckCompUni("<Greek_iota> <Greek_alphaaccent>", 0x1FB4)
CheckCompUni("<asciitilde> <Greek_alpha>", 0x1FB6)
CheckCompUni("<Greek_iota> <asciitilde> <Greek_alpha>", 0x1FB7)
CheckCompUni("<Greek_iota> <dead_tilde> <Greek_alpha>", 0x1FB7)
CheckCompUni("<Greek_iota> <U0342> <Greek_alpha>", 0x1FB7)
CheckCompUni("<Greek_iota> <U1fb6>", 0x1FB7)
CheckCompUni("<b> <Greek_ALPHA>", 0x1FB8)
CheckCompUni("<U> <Greek_ALPHA>", 0x1FB8)
CheckCompUni("<underscore> <Greek_ALPHA>", 0x1FB9)
CheckCompUni("<macron> <Greek_ALPHA>", 0x1FB9)
CheckCompUni("<grave> <Greek_ALPHA>", 0x1FBA)
CheckCompUni("<Greek_iota> <Greek_ALPHA>", 0x1FBC)
CheckCompUni("<diaeresis> <asciitilde>", 0x1FC1)
CheckCompUni("<diaeresis> <dead_tilde>", 0x1FC1)
CheckCompUni("<diaeresis> <U0342>", 0x1FC1)
CheckCompUni("<Greek_iota> <combining_grave> <Greek_eta>", 0x1FC2)
CheckCompUni("<Greek_iota> <grave> <Greek_eta>", 0x1FC2)
CheckCompUni("<Greek_iota> <dead_grave> <Greek_eta>", 0x1FC2)
CheckCompUni("<Greek_iota> <U1f74>", 0x1FC2)
CheckCompUni("<Greek_iota> <Greek_eta>", 0x1FC3)
CheckCompUni("<Greek_iota> <combining_acute> <Greek_eta>", 0x1FC4)
CheckCompUni("<Greek_iota> <apostrophe> <Greek_eta>", 0x1FC4)
CheckCompUni("<Greek_iota> <acute> <Greek_eta>", 0x1FC4)
CheckCompUni("<Greek_iota> <dead_acute> <Greek_eta>", 0x1FC4)
CheckCompUni("<Greek_iota> <Greek_etaaccent>", 0x1FC4)
CheckCompUni("<asciitilde> <Greek_eta>", 0x1FC6)
CheckCompUni("<Greek_iota> <asciitilde> <Greek_eta>", 0x1FC7)
CheckCompUni("<Greek_iota> <dead_tilde> <Greek_eta>", 0x1FC7)
CheckCompUni("<Greek_iota> <U0342> <Greek_eta>", 0x1FC7)
CheckCompUni("<Greek_iota> <U1fc6>", 0x1FC7)
CheckCompUni("<grave> <Greek_EPSILON>", 0x1FC8)
CheckCompUni("<grave> <Greek_ETA>", 0x1FCA)
CheckCompUni("<Greek_iota> <Greek_ETA>", 0x1FCC)
CheckCompUni("<U1fbf> <combining_grave>", 0x1FCD)
CheckCompUni("<U1fbf> <grave>", 0x1FCD)
CheckCompUni("<U1fbf> <dead_grave>", 0x1FCD)
CheckCompUni("<U1fbf> <combining_acute>", 0x1FCE)
CheckCompUni("<U1fbf> <apostrophe>", 0x1FCE)
CheckCompUni("<U1fbf> <acute>", 0x1FCE)
CheckCompUni("<U1fbf> <dead_acute>", 0x1FCE)
CheckCompUni("<U1fbf> <asciitilde>", 0x1FCF)
CheckCompUni("<U1fbf> <dead_tilde>", 0x1FCF)
CheckCompUni("<U1fbf> <U0342>", 0x1FCF)
CheckCompUni("<b> <Greek_iota>", 0x1FD0)
CheckCompUni("<U> <Greek_iota>", 0x1FD0)
CheckCompUni("<underscore> <Greek_iota>", 0x1FD1)
CheckCompUni("<macron> <Greek_iota>", 0x1FD1)
CheckCompUni("<grave> <quotedbl> <Greek_iota>", 0x1FD2)
CheckCompUni("<grave> <dead_diaeresis> <Greek_iota>", 0x1FD2)
CheckCompUni("<grave> <Greek_iotadieresis>", 0x1FD2)
CheckCompUni("<asciitilde> <Greek_iota>", 0x1FD6)
CheckCompUni("<asciitilde> <quotedbl> <Greek_iota>", 0x1FD7)
CheckCompUni("<asciitilde> <dead_diaeresis> <Greek_iota>", 0x1FD7)
CheckCompUni("<asciitilde> <Greek_iotadieresis>", 0x1FD7)
CheckCompUni("<b> <Greek_IOTA>", 0x1FD8)
CheckCompUni("<U> <Greek_IOTA>", 0x1FD8)
CheckCompUni("<underscore> <Greek_IOTA>", 0x1FD9)
CheckCompUni("<macron> <Greek_IOTA>", 0x1FD9)
CheckCompUni("<grave> <Greek_IOTA>", 0x1FDA)
CheckCompUni("<U1ffe> <combining_grave>", 0x1FDD)
CheckCompUni("<U1ffe> <grave>", 0x1FDD)
CheckCompUni("<U1ffe> <dead_grave>", 0x1FDD)
CheckCompUni("<U1ffe> <combining_acute>", 0x1FDE)
CheckCompUni("<U1ffe> <apostrophe>", 0x1FDE)
CheckCompUni("<U1ffe> <acute>", 0x1FDE)
CheckCompUni("<U1ffe> <dead_acute>", 0x1FDE)
CheckCompUni("<U1ffe> <asciitilde>", 0x1FDF)
CheckCompUni("<U1ffe> <dead_tilde>", 0x1FDF)
CheckCompUni("<U1ffe> <U0342>", 0x1FDF)
CheckCompUni("<b> <Greek_upsilon>", 0x1FE0)
CheckCompUni("<U> <Greek_upsilon>", 0x1FE0)
CheckCompUni("<underscore> <Greek_upsilon>", 0x1FE1)
CheckCompUni("<macron> <Greek_upsilon>", 0x1FE1)
CheckCompUni("<grave> <quotedbl> <Greek_upsilon>", 0x1FE2)
CheckCompUni("<grave> <dead_diaeresis> <Greek_upsilon>", 0x1FE2)
CheckCompUni("<grave> <Greek_upsilondieresis>", 0x1FE2)
CheckCompUni("<parenright> <Greek_rho>", 0x1FE4)
CheckCompUni("<parenleft> <Greek_rho>", 0x1FE5)
CheckCompUni("<asciitilde> <Greek_upsilon>", 0x1FE6)
CheckCompUni("<asciitilde> <quotedbl> <Greek_upsilon>", 0x1FE7)
CheckCompUni("<asciitilde> <dead_diaeresis> <Greek_upsilon>", 0x1FE7)
CheckCompUni("<asciitilde> <Greek_upsilondieresis>", 0x1FE7)
CheckCompUni("<b> <Greek_UPSILON>", 0x1FE8)
CheckCompUni("<U> <Greek_UPSILON>", 0x1FE8)
CheckCompUni("<underscore> <Greek_UPSILON>", 0x1FE9)
CheckCompUni("<macron> <Greek_UPSILON>", 0x1FE9)
CheckCompUni("<grave> <Greek_UPSILON>", 0x1FEA)
CheckCompUni("<parenleft> <Greek_RHO>", 0x1FEC)
CheckCompUni("<diaeresis> <combining_grave>", 0x1FED)
CheckCompUni("<diaeresis> <grave>", 0x1FED)
CheckCompUni("<diaeresis> <dead_grave>", 0x1FED)
CheckCompUni("<Greek_iota> <combining_grave> <Greek_omega>", 0x1FF2)
CheckCompUni("<Greek_iota> <grave> <Greek_omega>", 0x1FF2)
CheckCompUni("<Greek_iota> <dead_grave> <Greek_omega>", 0x1FF2)
CheckCompUni("<Greek_iota> <U1f7c>", 0x1FF2)
CheckCompUni("<Greek_iota> <Greek_omega>", 0x1FF3)
CheckCompUni("<Greek_iota> <combining_acute> <Greek_omega>", 0x1FF4)
CheckCompUni("<Greek_iota> <apostrophe> <Greek_omega>", 0x1FF4)
CheckCompUni("<Greek_iota> <acute> <Greek_omega>", 0x1FF4)
CheckCompUni("<Greek_iota> <dead_acute> <Greek_omega>", 0x1FF4)
CheckCompUni("<Greek_iota> <Greek_omegaaccent>", 0x1FF4)
CheckCompUni("<asciitilde> <Greek_omega>", 0x1FF6)
CheckCompUni("<Greek_iota> <asciitilde> <Greek_omega>", 0x1FF7)
CheckCompUni("<Greek_iota> <dead_tilde> <Greek_omega>", 0x1FF7)
CheckCompUni("<Greek_iota> <U0342> <Greek_omega>", 0x1FF7)
CheckCompUni("<Greek_iota> <U1ff6>", 0x1FF7)
CheckCompUni("<grave> <Greek_OMICRON>", 0x1FF8)
CheckCompUni("<grave> <Greek_OMEGA>", 0x1FFA)
CheckCompUni("<Greek_iota> <Greek_OMEGA>", 0x1FFC)
CheckCompUni("<percent> <o>", 0x2030)
CheckCompUni("<period> <less>", 0x2039)
CheckCompUni("<period> <greater>", 0x203A)
CheckCompUni("<asciicircum> <KP_0>", 0x2070)
CheckCompUni("<asciicircum> <0>", 0x2070)
CheckCompUni("<asciicircum> <underbar> <i>", 0x2071)
CheckCompUni("<asciicircum> <underscore> <i>", 0x2071)
CheckCompUni("<asciicircum> <KP_4>", 0x2074)
CheckCompUni("<asciicircum> <4>", 0x2074)
CheckCompUni("<asciicircum> <KP_5>", 0x2075)
CheckCompUni("<asciicircum> <5>", 0x2075)
CheckCompUni("<asciicircum> <KP_6>", 0x2076)
CheckCompUni("<asciicircum> <6>", 0x2076)
CheckCompUni("<asciicircum> <KP_7>", 0x2077)
CheckCompUni("<asciicircum> <7>", 0x2077)
CheckCompUni("<asciicircum> <KP_8>", 0x2078)
CheckCompUni("<asciicircum> <8>", 0x2078)
CheckCompUni("<asciicircum> <KP_9>", 0x2079)
CheckCompUni("<asciicircum> <9>", 0x2079)
CheckCompUni("<asciicircum> <KP_Add>", 0x207A)
CheckCompUni("<asciicircum> <plus>", 0x207A)
CheckCompUni("<asciicircum> <U2212>", 0x207B)
CheckCompUni("<asciicircum> <KP_Equal>", 0x207C)
CheckCompUni("<asciicircum> <equal>", 0x207C)
CheckCompUni("<asciicircum> <parenleft>", 0x207D)
CheckCompUni("<asciicircum> <parenright>", 0x207E)
CheckCompUni("<asciicircum> <underbar> <n>", 0x207F)
CheckCompUni("<asciicircum> <underscore> <n>", 0x207F)
CheckCompUni("<underbar> <KP_0>", 0x2080)
CheckCompUni("<underbar> <0>", 0x2080)
CheckCompUni("<underscore> <KP_0>", 0x2080)
CheckCompUni("<underscore> <0>", 0x2080)
CheckCompUni("<underbar> <KP_1>", 0x2081)
CheckCompUni("<underbar> <1>", 0x2081)
CheckCompUni("<underscore> <KP_1>", 0x2081)
CheckCompUni("<underscore> <1>", 0x2081)
CheckCompUni("<underbar> <KP_2>", 0x2082)
CheckCompUni("<underbar> <KP_Space>", 0x2082)
CheckCompUni("<underbar> <2>", 0x2082)
CheckCompUni("<underscore> <KP_2>", 0x2082)
CheckCompUni("<underscore> <KP_Space>", 0x2082)
CheckCompUni("<underscore> <2>", 0x2082)
CheckCompUni("<underbar> <KP_3>", 0x2083)
CheckCompUni("<underbar> <3>", 0x2083)
CheckCompUni("<underscore> <KP_3>", 0x2083)
CheckCompUni("<underscore> <3>", 0x2083)
CheckCompUni("<underbar> <KP_4>", 0x2084)
CheckCompUni("<underbar> <4>", 0x2084)
CheckCompUni("<underscore> <KP_4>", 0x2084)
CheckCompUni("<underscore> <4>", 0x2084)
CheckCompUni("<underbar> <KP_5>", 0x2085)
CheckCompUni("<underbar> <5>", 0x2085)
CheckCompUni("<underscore> <KP_5>", 0x2085)
CheckCompUni("<underscore> <5>", 0x2085)
CheckCompUni("<underbar> <KP_6>", 0x2086)
CheckCompUni("<underbar> <6>", 0x2086)
CheckCompUni("<underscore> <KP_6>", 0x2086)
CheckCompUni("<underscore> <6>", 0x2086)
CheckCompUni("<underbar> <KP_7>", 0x2087)
CheckCompUni("<underbar> <7>", 0x2087)
CheckCompUni("<underscore> <KP_7>", 0x2087)
CheckCompUni("<underscore> <7>", 0x2087)
CheckCompUni("<underbar> <KP_8>", 0x2088)
CheckCompUni("<underbar> <8>", 0x2088)
CheckCompUni("<underscore> <KP_8>", 0x2088)
CheckCompUni("<underscore> <8>", 0x2088)
CheckCompUni("<underbar> <KP_9>", 0x2089)
CheckCompUni("<underbar> <9>", 0x2089)
CheckCompUni("<underscore> <KP_9>", 0x2089)
CheckCompUni("<underscore> <9>", 0x2089)
CheckCompUni("<underbar> <KP_Add>", 0x208A)
CheckCompUni("<underbar> <plus>", 0x208A)
CheckCompUni("<underscore> <KP_Add>", 0x208A)
CheckCompUni("<underscore> <plus>", 0x208A)
CheckCompUni("<underbar> <U2212>", 0x208B)
CheckCompUni("<underscore> <U2212>", 0x208B)
CheckCompUni("<underbar> <KP_Equal>", 0x208C)
CheckCompUni("<underbar> <equal>", 0x208C)
CheckCompUni("<underscore> <KP_Equal>", 0x208C)
CheckCompUni("<underscore> <equal>", 0x208C)
CheckCompUni("<underbar> <parenleft>", 0x208D)
CheckCompUni("<underscore> <parenleft>", 0x208D)
CheckCompUni("<underbar> <parenright>", 0x208E)
CheckCompUni("<underscore> <parenright>", 0x208E)
CheckCompUni("<asciicircum> <S> <M>", 0x2120)
CheckCompUni("<KP_Divide> <leftarrow>", 0x219A)
CheckCompUni("<slash> <leftarrow>", 0x219A)
CheckCompUni("<KP_Divide> <rightarrow>", 0x219B)
CheckCompUni("<slash> <rightarrow>", 0x219B)
CheckCompUni("<KP_Divide> <U2194>", 0x21AE)
CheckCompUni("<slash> <U2194>", 0x21AE)
CheckCompUni("<U2203> <U0338>", 0x2204)
CheckCompUni("<U2208> <U0338>", 0x2209)
CheckCompUni("<U220b> <U0338>", 0x220C)
CheckCompUni("<U2223> <U0338>", 0x2224)
CheckCompUni("<U2225> <U0338>", 0x2226)
CheckCompUni("<U223c> <U0338>", 0x2241)
CheckCompUni("<U2243> <U0338>", 0x2244)
CheckCompUni("<approximate> <U0338>", 0x2247)
CheckCompUni("<U2248> <U0338>", 0x2249)
CheckCompUni("<identical> <U0338>", 0x2262)
CheckCompUni("<U224d> <U0338>", 0x226D)
CheckCompUni("<leftcaret> <U0338>", 0x226E)
CheckCompUni("<less> <U0338>", 0x226E)
CheckCompUni("<rightcaret> <U0338>", 0x226F)
CheckCompUni("<greater> <U0338>", 0x226F)
CheckCompUni("<lessthanequal> <U0338>", 0x2270)
CheckCompUni("<greaterthanequal> <U0338>", 0x2271)
CheckCompUni("<U2272> <U0338>", 0x2274)
CheckCompUni("<U2273> <U0338>", 0x2275)
CheckCompUni("<U2276> <U0338>", 0x2278)
CheckCompUni("<U2277> <U0338>", 0x2279)
CheckCompUni("<U227a> <U0338>", 0x2280)
CheckCompUni("<U227b> <U0338>", 0x2281)
CheckCompUni("<leftshoe> <U0338>", 0x2284)
CheckCompUni("<includedin> <U0338>", 0x2284)
CheckCompUni("<rightshoe> <U0338>", 0x2285)
CheckCompUni("<includes> <U0338>", 0x2285)
CheckCompUni("<U2286> <U0338>", 0x2288)
CheckCompUni("<U2287> <U0338>", 0x2289)
CheckCompUni("<righttack> <U0338>", 0x22AC)
CheckCompUni("<U22a8> <U0338>", 0x22AD)
CheckCompUni("<U22a9> <U0338>", 0x22AE)
CheckCompUni("<U22ab> <U0338>", 0x22AF)
CheckCompUni("<U227c> <U0338>", 0x22E0)
CheckCompUni("<U227d> <U0338>", 0x22E1)
CheckCompUni("<U2291> <U0338>", 0x22E2)
CheckCompUni("<U2292> <U0338>", 0x22E3)
CheckCompUni("<U22b2> <U0338>", 0x22EA)
CheckCompUni("<U22b3> <U0338>", 0x22EB)
CheckCompUni("<U22b4> <U0338>", 0x22EC)
CheckCompUni("<U22b5> <U0338>", 0x22ED)
CheckCompUni("<parenleft> <KP_1> <parenright>", 0x2460)
CheckCompUni("<parenleft> <1> <parenright>", 0x2460)
CheckCompUni("<parenleft> <KP_2> <parenright>", 0x2461)
CheckCompUni("<parenleft> <KP_Space> <parenright>", 0x2461)
CheckCompUni("<parenleft> <2> <parenright>", 0x2461)
CheckCompUni("<parenleft> <KP_3> <parenright>", 0x2462)
CheckCompUni("<parenleft> <3> <parenright>", 0x2462)
CheckCompUni("<parenleft> <KP_4> <parenright>", 0x2463)
CheckCompUni("<parenleft> <4> <parenright>", 0x2463)
CheckCompUni("<parenleft> <KP_5> <parenright>", 0x2464)
CheckCompUni("<parenleft> <5> <parenright>", 0x2464)
CheckCompUni("<parenleft> <KP_6> <parenright>", 0x2465)
CheckCompUni("<parenleft> <6> <parenright>", 0x2465)
CheckCompUni("<parenleft> <KP_7> <parenright>", 0x2466)
CheckCompUni("<parenleft> <7> <parenright>", 0x2466)
CheckCompUni("<parenleft> <KP_8> <parenright>", 0x2467)
CheckCompUni("<parenleft> <8> <parenright>", 0x2467)
CheckCompUni("<parenleft> <KP_9> <parenright>", 0x2468)
CheckCompUni("<parenleft> <9> <parenright>", 0x2468)
CheckCompUni("<parenleft> <KP_1> <KP_0> <parenright>", 0x2469)
CheckCompUni("<parenleft> <KP_1> <0> <parenright>", 0x2469)
CheckCompUni("<parenleft> <1> <KP_0> <parenright>", 0x2469)
CheckCompUni("<parenleft> <1> <0> <parenright>", 0x2469)
CheckCompUni("<parenleft> <KP_1> <KP_1> <parenright>", 0x246A)
CheckCompUni("<parenleft> <KP_1> <1> <parenright>", 0x246A)
CheckCompUni("<parenleft> <1> <KP_1> <parenright>", 0x246A)
CheckCompUni("<parenleft> <1> <1> <parenright>", 0x246A)
CheckCompUni("<parenleft> <KP_1> <KP_2> <parenright>", 0x246B)
CheckCompUni("<parenleft> <KP_1> <KP_Space> <parenright>", 0x246B)
CheckCompUni("<parenleft> <KP_1> <2> <parenright>", 0x246B)
CheckCompUni("<parenleft> <1> <KP_2> <parenright>", 0x246B)
CheckCompUni("<parenleft> <1> <KP_Space> <parenright>", 0x246B)
CheckCompUni("<parenleft> <1> <2> <parenright>", 0x246B)
CheckCompUni("<parenleft> <KP_1> <KP_3> <parenright>", 0x246C)
CheckCompUni("<parenleft> <KP_1> <3> <parenright>", 0x246C)
CheckCompUni("<parenleft> <1> <KP_3> <parenright>", 0x246C)
CheckCompUni("<parenleft> <1> <3> <parenright>", 0x246C)
CheckCompUni("<parenleft> <KP_1> <KP_4> <parenright>", 0x246D)
CheckCompUni("<parenleft> <KP_1> <4> <parenright>", 0x246D)
CheckCompUni("<parenleft> <1> <KP_4> <parenright>", 0x246D)
CheckCompUni("<parenleft> <1> <4> <parenright>", 0x246D)
CheckCompUni("<parenleft> <KP_1> <KP_5> <parenright>", 0x246E)
CheckCompUni("<parenleft> <KP_1> <5> <parenright>", 0x246E)
CheckCompUni("<parenleft> <1> <KP_5> <parenright>", 0x246E)
CheckCompUni("<parenleft> <1> <5> <parenright>", 0x246E)
CheckCompUni("<parenleft> <KP_1> <KP_6> <parenright>", 0x246F)
CheckCompUni("<parenleft> <KP_1> <6> <parenright>", 0x246F)
CheckCompUni("<parenleft> <1> <KP_6> <parenright>", 0x246F)
CheckCompUni("<parenleft> <1> <6> <parenright>", 0x246F)
CheckCompUni("<parenleft> <KP_1> <KP_7> <parenright>", 0x2470)
CheckCompUni("<parenleft> <KP_1> <7> <parenright>", 0x2470)
CheckCompUni("<parenleft> <1> <KP_7> <parenright>", 0x2470)
CheckCompUni("<parenleft> <1> <7> <parenright>", 0x2470)
CheckCompUni("<parenleft> <KP_1> <KP_8> <parenright>", 0x2471)
CheckCompUni("<parenleft> <KP_1> <8> <parenright>", 0x2471)
CheckCompUni("<parenleft> <1> <KP_8> <parenright>", 0x2471)
CheckCompUni("<parenleft> <1> <8> <parenright>", 0x2471)
CheckCompUni("<parenleft> <KP_1> <KP_9> <parenright>", 0x2472)
CheckCompUni("<parenleft> <KP_1> <9> <parenright>", 0x2472)
CheckCompUni("<parenleft> <1> <KP_9> <parenright>", 0x2472)
CheckCompUni("<parenleft> <1> <9> <parenright>", 0x2472)
CheckCompUni("<parenleft> <KP_2> <KP_0> <parenright>", 0x2473)
CheckCompUni("<parenleft> <KP_2> <0> <parenright>", 0x2473)
CheckCompUni("<parenleft> <KP_Space> <KP_0> <parenright>", 0x2473)
CheckCompUni("<parenleft> <KP_Space> <0> <parenright>", 0x2473)
CheckCompUni("<parenleft> <2> <KP_0> <parenright>", 0x2473)
CheckCompUni("<parenleft> <2> <0> <parenright>", 0x2473)
CheckCompUni("<parenleft> <A> <parenright>", 0x24B6)
CheckCompUni("<parenleft> <B> <parenright>", 0x24B7)
CheckCompUni("<parenleft> <C> <parenright>", 0x24B8)
CheckCompUni("<parenleft> <D> <parenright>", 0x24B9)
CheckCompUni("<parenleft> <E> <parenright>", 0x24BA)
CheckCompUni("<parenleft> <F> <parenright>", 0x24BB)
CheckCompUni("<parenleft> <G> <parenright>", 0x24BC)
CheckCompUni("<parenleft> <H> <parenright>", 0x24BD)
CheckCompUni("<parenleft> <I> <parenright>", 0x24BE)
CheckCompUni("<parenleft> <J> <parenright>", 0x24BF)
CheckCompUni("<parenleft> <K> <parenright>", 0x24C0)
CheckCompUni("<parenleft> <L> <parenright>", 0x24C1)
CheckCompUni("<parenleft> <M> <parenright>", 0x24C2)
CheckCompUni("<parenleft> <N> <parenright>", 0x24C3)
CheckCompUni("<parenleft> <O> <parenright>", 0x24C4)
CheckCompUni("<parenleft> <P> <parenright>", 0x24C5)
CheckCompUni("<parenleft> <Q> <parenright>", 0x24C6)
CheckCompUni("<parenleft> <R> <parenright>", 0x24C7)
CheckCompUni("<parenleft> <S> <parenright>", 0x24C8)
CheckCompUni("<parenleft> <T> <parenright>", 0x24C9)
CheckCompUni("<parenleft> <U> <parenright>", 0x24CA)
CheckCompUni("<parenleft> <V> <parenright>", 0x24CB)
CheckCompUni("<parenleft> <W> <parenright>", 0x24CC)
CheckCompUni("<parenleft> <X> <parenright>", 0x24CD)
CheckCompUni("<parenleft> <Y> <parenright>", 0x24CE)
CheckCompUni("<parenleft> <Z> <parenright>", 0x24CF)
CheckCompUni("<parenleft> <a> <parenright>", 0x24D0)
CheckCompUni("<parenleft> <b> <parenright>", 0x24D1)
CheckCompUni("<parenleft> <c> <parenright>", 0x24D2)
CheckCompUni("<parenleft> <d> <parenright>", 0x24D3)
CheckCompUni("<parenleft> <e> <parenright>", 0x24D4)
CheckCompUni("<parenleft> <f> <parenright>", 0x24D5)
CheckCompUni("<parenleft> <g> <parenright>", 0x24D6)
CheckCompUni("<parenleft> <h> <parenright>", 0x24D7)
CheckCompUni("<parenleft> <i> <parenright>", 0x24D8)
CheckCompUni("<parenleft> <j> <parenright>", 0x24D9)
CheckCompUni("<parenleft> <k> <parenright>", 0x24DA)
CheckCompUni("<parenleft> <l> <parenright>", 0x24DB)
CheckCompUni("<parenleft> <m> <parenright>", 0x24DC)
CheckCompUni("<parenleft> <n> <parenright>", 0x24DD)
CheckCompUni("<parenleft> <o> <parenright>", 0x24DE)
CheckCompUni("<parenleft> <p> <parenright>", 0x24DF)
CheckCompUni("<parenleft> <q> <parenright>", 0x24E0)
CheckCompUni("<parenleft> <r> <parenright>", 0x24E1)
CheckCompUni("<parenleft> <s> <parenright>", 0x24E2)
CheckCompUni("<parenleft> <t> <parenright>", 0x24E3)
CheckCompUni("<parenleft> <u> <parenright>", 0x24E4)
CheckCompUni("<parenleft> <v> <parenright>", 0x24E5)
CheckCompUni("<parenleft> <w> <parenright>", 0x24E6)
CheckCompUni("<parenleft> <x> <parenright>", 0x24E7)
CheckCompUni("<parenleft> <y> <parenright>", 0x24E8)
CheckCompUni("<parenleft> <z> <parenright>", 0x24E9)
CheckCompUni("<parenleft> <KP_0> <parenright>", 0x24EA)
CheckCompUni("<parenleft> <0> <parenright>", 0x24EA)
CheckCompUni("<numbersign> <f>", 0x266E)
CheckCompUni("<U2add> <U0338>", 0x2ADC)
CheckCompUni("<quotedbl> <backslash>", 0x301D)
CheckCompUni("<quotedbl> <slash>", 0x301E)
CheckCompUni("<parenleft> <KP_2> <KP_1> <parenright>", 0x3251)
CheckCompUni("<parenleft> <KP_2> <1> <parenright>", 0x3251)
CheckCompUni("<parenleft> <KP_Space> <KP_1> <parenright>", 0x3251)
CheckCompUni("<parenleft> <KP_Space> <1> <parenright>", 0x3251)
CheckCompUni("<parenleft> <2> <KP_1> <parenright>", 0x3251)
CheckCompUni("<parenleft> <2> <1> <parenright>", 0x3251)
CheckCompUni("<parenleft> <KP_2> <KP_2> <parenright>", 0x3252)
CheckCompUni("<parenleft> <KP_2> <KP_Space> <parenright>", 0x3252)
CheckCompUni("<parenleft> <KP_2> <2> <parenright>", 0x3252)
CheckCompUni("<parenleft> <KP_Space> <KP_2> <parenright>", 0x3252)
CheckCompUni("<parenleft> <KP_Space> <KP_Space> <parenright>", 0x3252)
CheckCompUni("<parenleft> <KP_Space> <2> <parenright>", 0x3252)
CheckCompUni("<parenleft> <2> <KP_2> <parenright>", 0x3252)
CheckCompUni("<parenleft> <2> <KP_Space> <parenright>", 0x3252)
CheckCompUni("<parenleft> <2> <2> <parenright>", 0x3252)
CheckCompUni("<parenleft> <KP_2> <KP_3> <parenright>", 0x3253)
CheckCompUni("<parenleft> <KP_2> <3> <parenright>", 0x3253)
CheckCompUni("<parenleft> <KP_Space> <KP_3> <parenright>", 0x3253)
CheckCompUni("<parenleft> <KP_Space> <3> <parenright>", 0x3253)
CheckCompUni("<parenleft> <2> <KP_3> <parenright>", 0x3253)
CheckCompUni("<parenleft> <2> <3> <parenright>", 0x3253)
CheckCompUni("<parenleft> <KP_2> <KP_4> <parenright>", 0x3254)
CheckCompUni("<parenleft> <KP_2> <4> <parenright>", 0x3254)
CheckCompUni("<parenleft> <KP_Space> <KP_4> <parenright>", 0x3254)
CheckCompUni("<parenleft> <KP_Space> <4> <parenright>", 0x3254)
CheckCompUni("<parenleft> <2> <KP_4> <parenright>", 0x3254)
CheckCompUni("<parenleft> <2> <4> <parenright>", 0x3254)
CheckCompUni("<parenleft> <KP_2> <KP_5> <parenright>", 0x3255)
CheckCompUni("<parenleft> <KP_2> <5> <parenright>", 0x3255)
CheckCompUni("<parenleft> <KP_Space> <KP_5> <parenright>", 0x3255)
CheckCompUni("<parenleft> <KP_Space> <5> <parenright>", 0x3255)
CheckCompUni("<parenleft> <2> <KP_5> <parenright>", 0x3255)
CheckCompUni("<parenleft> <2> <5> <parenright>", 0x3255)
CheckCompUni("<parenleft> <KP_2> <KP_6> <parenright>", 0x3256)
CheckCompUni("<parenleft> <KP_2> <6> <parenright>", 0x3256)
CheckCompUni("<parenleft> <KP_Space> <KP_6> <parenright>", 0x3256)
CheckCompUni("<parenleft> <KP_Space> <6> <parenright>", 0x3256)
CheckCompUni("<parenleft> <2> <KP_6> <parenright>", 0x3256)
CheckCompUni("<parenleft> <2> <6> <parenright>", 0x3256)
CheckCompUni("<parenleft> <KP_2> <KP_7> <parenright>", 0x3257)
CheckCompUni("<parenleft> <KP_2> <7> <parenright>", 0x3257)
CheckCompUni("<parenleft> <KP_Space> <KP_7> <parenright>", 0x3257)
CheckCompUni("<parenleft> <KP_Space> <7> <parenright>", 0x3257)
CheckCompUni("<parenleft> <2> <KP_7> <parenright>", 0x3257)
CheckCompUni("<parenleft> <2> <7> <parenright>", 0x3257)
CheckCompUni("<parenleft> <KP_2> <KP_8> <parenright>", 0x3258)
CheckCompUni("<parenleft> <KP_2> <8> <parenright>", 0x3258)
CheckCompUni("<parenleft> <KP_Space> <KP_8> <parenright>", 0x3258)
CheckCompUni("<parenleft> <KP_Space> <8> <parenright>", 0x3258)
CheckCompUni("<parenleft> <2> <KP_8> <parenright>", 0x3258)
CheckCompUni("<parenleft> <2> <8> <parenright>", 0x3258)
CheckCompUni("<parenleft> <KP_2> <KP_9> <parenright>", 0x3259)
CheckCompUni("<parenleft> <KP_2> <9> <parenright>", 0x3259)
CheckCompUni("<parenleft> <KP_Space> <KP_9> <parenright>", 0x3259)
CheckCompUni("<parenleft> <KP_Space> <9> <parenright>", 0x3259)
CheckCompUni("<parenleft> <2> <KP_9> <parenright>", 0x3259)
CheckCompUni("<parenleft> <2> <9> <parenright>", 0x3259)
CheckCompUni("<parenleft> <KP_3> <KP_0> <parenright>", 0x325A)
CheckCompUni("<parenleft> <KP_3> <0> <parenright>", 0x325A)
CheckCompUni("<parenleft> <3> <KP_0> <parenright>", 0x325A)
CheckCompUni("<parenleft> <3> <0> <parenright>", 0x325A)
CheckCompUni("<parenleft> <KP_3> <KP_1> <parenright>", 0x325B)
CheckCompUni("<parenleft> <KP_3> <1> <parenright>", 0x325B)
CheckCompUni("<parenleft> <3> <KP_1> <parenright>", 0x325B)
CheckCompUni("<parenleft> <3> <1> <parenright>", 0x325B)
CheckCompUni("<parenleft> <KP_3> <KP_2> <parenright>", 0x325C)
CheckCompUni("<parenleft> <KP_3> <KP_Space> <parenright>", 0x325C)
CheckCompUni("<parenleft> <KP_3> <2> <parenright>", 0x325C)
CheckCompUni("<parenleft> <3> <KP_2> <parenright>", 0x325C)
CheckCompUni("<parenleft> <3> <KP_Space> <parenright>", 0x325C)
CheckCompUni("<parenleft> <3> <2> <parenright>", 0x325C)
CheckCompUni("<parenleft> <KP_3> <KP_3> <parenright>", 0x325D)
CheckCompUni("<parenleft> <KP_3> <3> <parenright>", 0x325D)
CheckCompUni("<parenleft> <3> <KP_3> <parenright>", 0x325D)
CheckCompUni("<parenleft> <3> <3> <parenright>", 0x325D)
CheckCompUni("<parenleft> <KP_3> <KP_4> <parenright>", 0x325E)
CheckCompUni("<parenleft> <KP_3> <4> <parenright>", 0x325E)
CheckCompUni("<parenleft> <3> <KP_4> <parenright>", 0x325E)
CheckCompUni("<parenleft> <3> <4> <parenright>", 0x325E)
CheckCompUni("<parenleft> <KP_3> <KP_5> <parenright>", 0x325F)
CheckCompUni("<parenleft> <KP_3> <5> <parenright>", 0x325F)
CheckCompUni("<parenleft> <3> <KP_5> <parenright>", 0x325F)
CheckCompUni("<parenleft> <3> <5> <parenright>", 0x325F)
CheckCompUni("<parenleft> <KP_3> <KP_6> <parenright>", 0x32B1)
CheckCompUni("<parenleft> <KP_3> <6> <parenright>", 0x32B1)
CheckCompUni("<parenleft> <3> <KP_6> <parenright>", 0x32B1)
CheckCompUni("<parenleft> <3> <6> <parenright>", 0x32B1)
CheckCompUni("<parenleft> <KP_3> <KP_7> <parenright>", 0x32B2)
CheckCompUni("<parenleft> <KP_3> <7> <parenright>", 0x32B2)
CheckCompUni("<parenleft> <3> <KP_7> <parenright>", 0x32B2)
CheckCompUni("<parenleft> <3> <7> <parenright>", 0x32B2)
CheckCompUni("<parenleft> <KP_3> <KP_8> <parenright>", 0x32B3)
CheckCompUni("<parenleft> <KP_3> <8> <parenright>", 0x32B3)
CheckCompUni("<parenleft> <3> <KP_8> <parenright>", 0x32B3)
CheckCompUni("<parenleft> <3> <8> <parenright>", 0x32B3)
CheckCompUni("<parenleft> <KP_3> <KP_9> <parenright>", 0x32B4)
CheckCompUni("<parenleft> <KP_3> <9> <parenright>", 0x32B4)
CheckCompUni("<parenleft> <3> <KP_9> <parenright>", 0x32B4)
CheckCompUni("<parenleft> <3> <9> <parenright>", 0x32B4)
CheckCompUni("<parenleft> <KP_4> <KP_0> <parenright>", 0x32B5)
CheckCompUni("<parenleft> <KP_4> <0> <parenright>", 0x32B5)
CheckCompUni("<parenleft> <4> <KP_0> <parenright>", 0x32B5)
CheckCompUni("<parenleft> <4> <0> <parenright>", 0x32B5)
CheckCompUni("<parenleft> <KP_4> <KP_1> <parenright>", 0x32B6)
CheckCompUni("<parenleft> <KP_4> <1> <parenright>", 0x32B6)
CheckCompUni("<parenleft> <4> <KP_1> <parenright>", 0x32B6)
CheckCompUni("<parenleft> <4> <1> <parenright>", 0x32B6)
CheckCompUni("<parenleft> <KP_4> <KP_2> <parenright>", 0x32B7)
CheckCompUni("<parenleft> <KP_4> <KP_Space> <parenright>", 0x32B7)
CheckCompUni("<parenleft> <KP_4> <2> <parenright>", 0x32B7)
CheckCompUni("<parenleft> <4> <KP_2> <parenright>", 0x32B7)
CheckCompUni("<parenleft> <4> <KP_Space> <parenright>", 0x32B7)
CheckCompUni("<parenleft> <4> <2> <parenright>", 0x32B7)
CheckCompUni("<parenleft> <KP_4> <KP_3> <parenright>", 0x32B8)
CheckCompUni("<parenleft> <KP_4> <3> <parenright>", 0x32B8)
CheckCompUni("<parenleft> <4> <KP_3> <parenright>", 0x32B8)
CheckCompUni("<parenleft> <4> <3> <parenright>", 0x32B8)
CheckCompUni("<parenleft> <KP_4> <KP_4> <parenright>", 0x32B9)
CheckCompUni("<parenleft> <KP_4> <4> <parenright>", 0x32B9)
CheckCompUni("<parenleft> <4> <KP_4> <parenright>", 0x32B9)
CheckCompUni("<parenleft> <4> <4> <parenright>", 0x32B9)
CheckCompUni("<parenleft> <KP_4> <KP_5> <parenright>", 0x32BA)
CheckCompUni("<parenleft> <KP_4> <5> <parenright>", 0x32BA)
CheckCompUni("<parenleft> <4> <KP_5> <parenright>", 0x32BA)
CheckCompUni("<parenleft> <4> <5> <parenright>", 0x32BA)
CheckCompUni("<parenleft> <KP_4> <KP_6> <parenright>", 0x32BB)
CheckCompUni("<parenleft> <KP_4> <6> <parenright>", 0x32BB)
CheckCompUni("<parenleft> <4> <KP_6> <parenright>", 0x32BB)
CheckCompUni("<parenleft> <4> <6> <parenright>", 0x32BB)
CheckCompUni("<parenleft> <KP_4> <KP_7> <parenright>", 0x32BC)
CheckCompUni("<parenleft> <KP_4> <7> <parenright>", 0x32BC)
CheckCompUni("<parenleft> <4> <KP_7> <parenright>", 0x32BC)
CheckCompUni("<parenleft> <4> <7> <parenright>", 0x32BC)
CheckCompUni("<parenleft> <KP_4> <KP_8> <parenright>", 0x32BD)
CheckCompUni("<parenleft> <KP_4> <8> <parenright>", 0x32BD)
CheckCompUni("<parenleft> <4> <KP_8> <parenright>", 0x32BD)
CheckCompUni("<parenleft> <4> <8> <parenright>", 0x32BD)
CheckCompUni("<parenleft> <KP_4> <KP_9> <parenright>", 0x32BE)
CheckCompUni("<parenleft> <KP_4> <9> <parenright>", 0x32BE)
CheckCompUni("<parenleft> <4> <KP_9> <parenright>", 0x32BE)
CheckCompUni("<parenleft> <4> <9> <parenright>", 0x32BE)
CheckCompUni("<parenleft> <KP_5> <KP_0> <parenright>", 0x32BF)
CheckCompUni("<parenleft> <KP_5> <0> <parenright>", 0x32BF)
CheckCompUni("<parenleft> <5> <KP_0> <parenright>", 0x32BF)
CheckCompUni("<parenleft> <5> <0> <parenright>", 0x32BF)
CheckCompUni("<apostrophe> <U>", 0xDA)
CheckCompUni("<acute> <U>", 0xDA)
CheckCompUni("<apostrophe> <u>", 0xFA)
CheckCompUni("<acute> <u>", 0xFA)
CheckCompUni("<b> <U>", 0x16C)
CheckCompUni("<U> <U>", 0x16C)
CheckCompUni("<b> <u>", 0x16D)
CheckCompUni("<U> <u>", 0x16D)
CheckCompUni("<asciicircum> <U>", 0xDB)
CheckCompUni("<asciicircum> <u>", 0xFB)
CheckCompUni("<quotedbl> <U>", 0xDC)
CheckCompUni("<quotedbl> <u>", 0xFC)
CheckCompUni("<equal> <U>", 0x170)
CheckCompUni("<equal> <u>", 0x171)
CheckCompUni("<grave> <U>", 0xD9)
CheckCompUni("<grave> <u>", 0xF9)
CheckCompUni("<underscore> <U>", 0x16A)
CheckCompUni("<macron> <U>", 0x16A)
CheckCompUni("<underscore> <u>", 0x16B)
CheckCompUni("<macron> <u>", 0x16B)
CheckCompUni("<semicolon> <U>", 0x172)
CheckCompUni("<semicolon> <u>", 0x173)
CheckCompUni("<o> <U>", 0x16E)
CheckCompUni("<o> <u>", 0x16F)
CheckCompUni("<asciitilde> <U>", 0x168)
CheckCompUni("<asciitilde> <u>", 0x169)
CheckCompUni("<equal> <W>", 0x20A9)
CheckCompUni("<W> <equal>", 0x20A9)
CheckCompUni("<apostrophe> <Y>", 0xDD)
CheckCompUni("<acute> <Y>", 0xDD)
CheckCompUni("<apostrophe> <y>", 0xFD)
CheckCompUni("<acute> <y>", 0xFD)
CheckCompUni("<quotedbl> <Y>", 0x178)
CheckCompUni("<quotedbl> <y>", 0xFF)
CheckCompUni("<equal> <Y>", 0xA5)
CheckCompUni("<Y> <equal>", 0xA5)
CheckCompUni("<period> <Z>", 0x17B)
CheckCompUni("<period> <z>", 0x17C)
CheckCompUni("<apostrophe> <Z>", 0x179)
CheckCompUni("<acute> <Z>", 0x179)
CheckCompUni("<apostrophe> <z>", 0x17A)
CheckCompUni("<acute> <z>", 0x17A)
CheckCompUni("<c> <Z>", 0x17D)
CheckCompUni("<c> <z>", 0x17E)
}
/*
   ------------------------------------------------------
   Methoden zum Senden von Unicode-Zeichen
   ------------------------------------------------------

Über den GTK-Workaround:
Dieser basiert auf http://www.autohotkey.com/forum/topic32947.html
Der Aufruf von »SubStr(charCode,3)« geht davon aus, dass alle charCodes in Hex mit führendem „0x“ angegeben sind. Die abenteuerliche „^+u“-Konstruktion benötigt im Übrigen den Hex-Wert in Kleinschrift, was derzeit nicht bei den Zeichendefinitionen umgesetzt ist, daher zentral und weniger fehlerträchtig an dieser Stelle. Außerdem ein abschließend gesendetes Space, sonst bleibt der „eingetippte“ Unicode-Wert noch kurz sichtbar stehen, bevor er sich GTK-sei-dank in das gewünschte Zeichen verwandelt.
*/

SendUnicodeChar(charCode1, charCode2) {

  global
  if !(CheckComp(charCode2) and DeadCompose)
  IfWinActive,ahk_class gdkWindowToplevel
  {
    StringLower,charCode1,charCode1
    send % "^+u" . SubStr(charCode1,3) . " "
  } else {
    VarSetCapacity(ki,28*2,0)
    EncodeInteger(&ki+0,1)
    EncodeInteger(&ki+6,charCode1)
    EncodeInteger(&ki+8,4)
    EncodeInteger(&ki+28,1)
    EncodeInteger(&ki+34,charCode1)
    EncodeInteger(&ki+36,4|2)
    DllCall("SendInput","UInt",2,"UInt",&ki,"Int",28)
  }
}

EncodeInteger(ref,val) {
  DllCall("ntdll\RtlFillMemoryUlong","Uint",ref,"Uint",4,"Uint",val)
}


/*
   ------------------------------------------------------
   BildschirmTastatur
   ------------------------------------------------------
*/

guiErstellt = 0
alwaysOnTop = 1

*F1::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Switch1
  else send {blind}{F1}
return

*F2::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Switch2
  else send {blind}{F2}
return

*F3::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Switch3
  else send {blind}{F3}
return

*F4::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Switch4
  else send {blind}{F4}
return

*F5::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Switch5
  else send {blind}{F5}
return

*F6::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Switch6
  else send {blind}{F6}
return

*F7::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
    goto Show
  else send {blind}{F7}
return

*F8::
  if (isMod4Pressed()&&zeigeBildschirmTastatur)
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
  if guiErstellt {
    if (Image = tImage)
       goto Close
    else {
      Image := tImage
      SetTimer, Refresh
    }
  } else {
    Image := tImage
    goto Show    
  }
Return

Show:
  if guiErstellt {
     goto Close
  } else {
    if (Image = "") {
      Image := ResourceFolder . "\ebene1.png"
    }     
    yPosition := A_ScreenHeight -270
    Gui,Color,FFFFFF
    Gui,Add,Button,xm+5 gSwitch1,F1
    Gui,Add,Text,x+5,kleine Buchstaben
    Gui,Add,Button,xm+5 gSwitch2,F2
    Gui,Add,Text,x+5,große Buchstaben
    Gui,Add,Button,xm+5 gSwitch3,F3
    Gui,Add,Text,x+5,Satz-/Sonderzeichen
    Gui,Add,Button,xm+5 gSwitch4,F4
    Gui,Add,Text,x+5,Zahlen / Steuerung
    Gui,Add,Button,xm+5 gSwitch5,F5
    Gui,Add,Text,x+5,Sprachen
    Gui,Add,Button,xm+5 gSwitch6,F6
    Gui,Add,Text,x+5,Mathesymbole
    Gui,Add,Button,xm+5 gShow,F7
    Gui,Add,Text,x+5,An /
    Gui,Add,Text,y+3,Aus
    Gui,Add,Button,x+10 y+-30 gShow,F8
    Gui,Add,Text,x+5,OnTop
    Gui,Add,Picture,AltSubmit ys w564 h200 vPicture,%Image%
    Gui,+AlwaysOnTop
    Gui,Show,y%yposition% Autosize
;    SetTimer,Refresh
    guiErstellt = 1
  } 
Return

Close:
  guiErstellt = 0
  Gui,Destroy
Return

Refresh:
  If (Image != OldImage) {
    GuiControl,,Picture,%Image%
    OldImage := Image
  }
Return

ToggleAlwaysOnTop:
  if alwaysOnTop {
    Gui, -AlwaysOnTop
    alwaysOnTop = 0    
  } else {
    Gui, +AlwaysOnTop
    alwaysOnTop = 1
  }
Return


