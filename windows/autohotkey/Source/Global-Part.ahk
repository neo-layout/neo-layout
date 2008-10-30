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


