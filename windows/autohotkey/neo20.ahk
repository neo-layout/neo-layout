/*
*******************************************
WICHTIGE WARNUNG:

Dies ist inzwischen eine automatisch generierte
Datei! Sie wird regelmäßig überschrieben und
sollte deshalb nicht mehr direkt bearbeitet werden!

Alle weiterführende Informationen finden sich im Abschnitt 
== Hinweise für Entwickler ==
in der Datei README.txt!  
*******************************************
*/

















/*
*******************************************
Das war die letzte WARNUNG, ich hoffe nur dass
sie wirklich wissen was sie hier tun wollen ...
*******************************************
*/


/*
*************************************
* NEO 2.0 (beta) Autohotkey-Treiber *
*************************************
Autoren:
Stefan Mayer <stm (at) neo-layout. o r g>
Nora Geissler <nora_geissler (at) yahoo. d e>
Matthias Berg <neo (at) matthias-berg. e u>
Martin Roppelt <m.p.roppelt (at) web. d e>
Dennis Heidsiek <HeidsiekB (at) aol. c o m>
Matthias Wächter <matthias (at) waechter.. w i z .. a t>
...



*********
* TODO: *
*********
- Die Bildschirmtastatur mit Mod4 hat den Mod4-Lock deaktiviert!
- Compose vollständig implementieren (Welche Methode ist hierzu am besten geeignet?)
- ausgiebig testen... (besonders Vollständigkeit bei Deadkeys)
- Bessere Lösung für das Leeren von PriorDeadKey finden, damit die Sondertasten nicht mehr abgefangen werden müssen.
- Testen, ob die Capslocklösung (siehe *1:: ebene 1) auch für Numpad gebraucht wird
- Die Ebenen vom Tastenblock an die neue Referenz anpassen (wenn da ein Konsens gefunden wurde)


**********
* IDEEN: *
**********
- Tastatur-Reset: mod4+escape (oder ev. ein anderer Hotkey) soll die Tastatur wieder in den Normalzustand versetzen (d.h. alle Ebenen unlocken und Einhand, Lang-s oder Sonstwelche-Modi deaktivieren)
- Die Varianten (lernModus, einHandNeo, Lang-s-Tastatur, Qwertz/pausieren) sollten einheitlich (de-)aktiviert werden, etwa über Mod4 F9-F12
- bei Ebene 4 rechte Hand (Numpad) z.B. Numpad5 statt 5 senden



******************
* CHANGEHISTORY: *
******************



Revision 728 (von Dennis Heidsiek):
- Ist die Datei [...]\Anwendungsdaten\NEO2\NEO2.ini vorhanden, werden dort eventuell vonhandene Werte für die Globalen Schalter beim Start übernommen
Revision 707 (von Dennis Heidsiek):
- Die Resourcen-Dateien (PNGs, ICOs) werden nun nach "Von Windows vorgegebenes TEMP Verzeichnis\NEO2\ extrahiert und nicht mehr in das Verzeichnis, in dem sich die EXE befindet
- Die doppelten französischen Anführungszeichen werden nun ebenfalls über SendUnicodeChar gesendet
Revision 694 (von Martin Roppelt):
- LangSTastatur auf F11 (Ebene 4)
- Entwickler können durch das Erstellen einer Datei »LangSTastaturStandardmäßigEingeschaltet.ahk« mit dem Inhalt »LangSTastatur := 1« diese standardmäßig aktivieren
- Mehrere DeadKeys aktualisiert (T*, Ebene 4 und T*, Ebene 5)
Revision 687 (von Dennis Heidsiek):
- Die SendUnicodeChar-Methode um den GDK-Workarround von Matthias Wächter ergänzt
- (An/Aus) Icons an Favicon der neuen Homepage angepasst
Revision 645 (von Martin Roppelt):
- Ellipse zusätzlich auf M3+x; 
- Lang-s-Tastatur probeweise auf M4+Esc
Revision 640 (von Dennis Heidsiek):
- Der untote Zirkumflex (^) auf Ebene 3 funktioniert jetzt auch in Java-Programmen
Revision 639 (von Martin Roppelt):
- Lang-s-Tastatur kann nicht mehr durch einen Hotkey aktiviert werden
Revision 629 (von Martin Roppelt):
- Spitze Klammern (bra und ket) testweise auf M5+8/9
Revision 624 (von Martin Roppelt):
- Lang-s-Tastatur (ein- und auszuschalten durch Mod4+ß)
Revision 616 (von Dennis Heidsiek):
- Der nicht funktionierende Mod5-Lock-Fix wurde wieder entfernt, da er sogar neue Fehler produzierte.
Revision 615 (von Dennis Heidsiek):
- Erfolgloser Versuch, den Mod4-Lock wiederherzustellen (durch eine Tilde vor den Scancodes der Bildschirmtastatur).
- Rechtschreibfehler korrigiert.
- Zwei AHK-Links eingefügt.
Revision 609 (von Dennis Heidsiek):
- Vorläufiger Abschluss der AHK-Modularisierung.
- Bessere Testmöglichkeit »All.ahk« für AHK-Entwickler hinzugefügt, bei der sich die Zeilenangaben in Fehlermeldungen auf die tatsächlichen Module und nicht auf das große »vereinigte« Skript beziehen.
Revision 608 (von Martin Roppelt):
- Rechtschreibfehler korrigiert und Dateinamen aktualisiert und sortiert.
Revision 590 (von Dennis Heidsiek):
- Erste technische Vorarbeiten zur logischen Modularisierung des viel zu lange gewordenen AHK-Quellcodes.
- Neue Batch-Datei Build-Update.bat zur einfachen Aktualisierung der EXE-Datei
Revision 583 (von Dennis Heidsiek):
- Kleinere Korrekturen (Mod3+Numpad5, Mod5+Numpad5 und Mod3+Numpad9 stimmen wieder mit der Referenz überein).
Revision 580 (von Matthias Berg):
- Bildschirmtastatur jetzt mit Mod4+F* statt Strg+F*, dies deaktiviert jedoch leider den Mod4-Lock
Revision 570 (von Matthias Berg):
- Hotkeys für einHandNeo und lernModus durch entsprechende ScanCodes ersetzt 
Revision 568 (von Matthias Berg):
- Sonderzeichen, Umlaute, z und y durch ScanCodes ersetzt
  * jetzt wird auch bei eingestelltem US Layout Neo verwendet. (z.B. für Chinesische InputMethodEditors)
  * rechter Mod3 geht noch nicht bei US Layout (weder ScanCode noch "\")
Revision 567 (von Dennis Heidsiek):
- Aktivierter Mod4 Lock wird jetzt über die Rollen-LED des Keybord angezeigt (analog zu CapsLock), die NUM-LED behält ihr bisheriges Verhalten
- Neue Option im Skript: UseMod4Light
Revision 561 (von Matthias Berg):
- Ebene 4 Tab verhält sich jetzt wie das andere Tab dank "goto neo_tab"
Revision 560 (von Dennis Heidsiek):
- Neue Option im Skript: bildschirmTastaturEinbinden bindet die PNG-Bilder der Bildschirmtastur mit in die exe-Datei ein, so dass sich der Benutzer nur eine Datei herunterladen muss
Revision 559 (von Matthias Berg):
- Shift+Alt+Tab Problem gelöst (muss noch mehr auf Nebeneffekte getestet werden)
Revision 558 (von Matthias Berg):
- Icon-Bug behoben
  * Hotkeys dürfen nicht vor der folgenden Zeile stehen:
   "menu, tray, icon, neo.ico,,1"
- lernModus-Konfigurations-Bug behoben: or statt and(not)
- Ein paar leere Else-Fälle eingebaut (Verständlichkeit, mögliche Compilerprobleme vermeiden)   
Revision 556 (von Matthias Berg):
- lernModus (an/aus mit Strg+Komma)
  * im Skript konfigurierbar
  * Schaltet z.B. Qwertz Tasten aus, die es auf der 4. Ebene gibt (Return, Backspace,...)
  * Kann auch Backspace und/oder Entfernen der 4. Ebene ausschalten (gut zum Lernen richtig zu schreiben)
- Bug aufgetaucht: Icons werden nicht mehr angezeigt
Revision 544 (von Stefan Mayer):
- ,.:; auf dem Mod4-Ziffernblock an die aktuelle Referenz angepasst
- Versionen von rho, theta, kappa und phi an die aktuelle Referenz angepasst
Revision 542 (von Matthias Berg):
- bei EinHandNeo ist jetzt Space+y auch Mod4
- AltGr-Bug  hoffentlich wieder behoben. Diesmal mit extra altGrPressed Variable
- nurEbenenFuenfUndSechs umbenannt in ahkTreiberKombi und auf Ebene 4 statt 5 und 6 geändert
Revision 540 (von Matthias Berg):
- stark überarbeitet um Wartbarkeit zu erhöhen und Redundanz zu veringern
- nurEbenenFuenfUndSechs sollte nun auch auf Neo Treiber statt Qwertz laufen
  * aber es muss noch jemand testen
  * Problem: was kann man abfangen, wenn eine tote Taste gedrückt wird
- einHandNeo:
  * An-/Ausschalten mit STRG+Punkt
  * Buchstaben der rechten Hand werden mit Space zur linken Hand
  * Nebeneffekt: es gibt beim Festhalten von Space keine wiederholten Leerzeichen mehr
Revision 532 (von Matthias Berg):
- BildschirmTastatur 
  * aktiviert mit strg+F1 bis 7 schaltet Keyboard ein oder aus
  * strg+F7 zeigt die zuletzt angezeigte Ebene an (und wieder aus).
  * strg+F8 schaltet AlwaysOnTop um    
Revision 529 (von Stefan Mayer):
- Icon wird automatisch geladen, falls .ico-Dateien im selbem Ordner
- in der .exe sind die .ico mitgespeichert und werden geladen
Revision 528 (von Matthias Berg):
- Neo-Icon
- Neo-Prozess jetzt automatisch auf hoher Prioritaet
  (siehe globale Schalter)
- Mod3-Lock (nur wenn rechtes Mod3 zuerst gedrückt wird, andere Lösung führte zum Caps-Bug)
- Mod4-Lock (nur wenn das linke Mod4 zuerst gedrückt wird, andere Lösung fühte zum AltGr-Bug)
- Ein paar falsche Zeichen korrigiert
Revision 527 (von Matthias Berg):
- AltGr Problem hoffentlich behoben
- Umschalt+Mod4 Bug behoben
Revision 526 (von Matthias Berg):
- Ebenen 1 bis 4 ausschalten per Umschalter siehe erste Codezeile nurEbenenFuenfUndSechs = 0
- Mod4-Lock durch Mod4+Mod4
- EbenenAktualisierung neu geschrieben
- Ebene 6 über Mod3+Mod4
- Ebenen (besonders Matheebene) an Referenz angepasst (allerdings kaum um Ebenen 1&2 gekümmert, besonders Compose könnte noch überholt werden)
Revision 525 (von Matthias Berg):
- Capslock bei Zahlen und Sonderzeichen berücksichtigt
Revision 524 (von Matthias Berg):
- umgekehrtes ^ für o, a, ü,i  sowie für die grossen vokale ( 3. ton chinesisch)
  • damit wird jetzt PinYin vollständig unterstützt caron, macron, akut, grave auf uiaeoü
- Sonderzeichen senden wieder blind -> Shortcuts funktionieren, Capslock ist leider Shiftlock
Revision 523 (von Matthias Berg):
- CapsLock geht jetzt auch bei allen Zeichen ('send Zeichen' statt 'send {blind} Zeichen')
- vertikale Ellipse eingebaut
- Umschalt+Umschalt für Capslock statt Mod3+Mod3
- bei Suspend wird jetzt wirklich togglesuspend aufgerufen (auch beim aktivieren per shift+pause)
Revsion 490 (von Stefan Mayer): 
- SUBSCRIPT von 0 bis 9 sowie (auf Ziffernblock) + und -
  • auch bei Ziffernblock auf der 5. Ebene
- Kein Parsen über die Zwischenablage mehr
- Vista-kompatibel
- Compose-Taste
  • Brüche (auf Zahlenreihe und Hardware-Ziffernblock)
  • römische Zahlen
  • Ligaturen und Copyright



*/





/********************
 Verzeichnisse      *
*********************
*/
; Setzt den Pfad zu einem temporären Verzeichnis
EnvGet, WindowsEnvTempFolder, TEMP
ResourceFolder = %WindowsEnvTempFolder%\NEO2
FileCreateDir, %ResourceFolder%

; Setzt den Pfad zu den NEO-Anwendungsdateien
EnvGet, WindowsEnvAppDataFolder, APPDATA
ApplicationFolder = %WindowsEnvAppDataFolder%\NEO2
FileCreateDir, %ApplicationFolder%



/******************
 Globale Schalter *
*******************
*/

; Im folgenden gilt (soweit nicht anders angegeben) Ja = 1, Nein = 0:
; Syntaxhinweis: IniRead, Variable, InputFilename, Section, Key [, DefaultValue]


; Sollen die Bilder für die Bildschirmtastatur in die compilierte EXE-Datei miteingebunden werden? (Nachteil: grössere Dateigrösse, Vorteil: Referenz für Anfänger stets einfach verfügbar)
bildschirmTastaturEinbinden := 1

; Sollen Ebenen 1-4 ignoriert werden (kann z.B. vom dll Treiber übernommen werden)?
IniRead, ahkTreiberKombi, %ApplicationFolder%\NEO2.ini, Global, ahkTreiberKombi, 0

; Soll der Treiber im Einhandmodus betrieben werden?
IniRead, einHandNeo, %ApplicationFolder%\NEO2.ini, Global, einHandNeo, 0

; Soll der Lernmodus aktiviert werden?
IniRead, lernModus, %ApplicationFolder%\NEO2.ini, Global, lernModus, 0

; Aktivierter Mod4-Lock wird über die Rollen-LED des Keybord angezeigt (analog zu CapsLock)
IniRead, UseMod4Light, %ApplicationFolder%\NEO2.ini, Global, UseMod4Light, 1

; Soll Lang-s auf s, s auf ß und ß auf Mod3+ß gelegt (bzw. vertauscht) werden?
IniRead, LangSTastatur, %ApplicationFolder%\NEO2.ini, Global, LangSTastatur, 0



/*************************
 Recourcen-Verwaltung    *
**************************
*/


if(FileExist("ResourceFolder") <> false) {
	; Versuche, alle möglicherweise in die EXE eingebundenen Dateien zu extrahieren 
	FileInstall, neo.ico, %ResourceFolder%\neo.ico, 1
	FileInstall, neo_disabled.ico, %ResourceFolder%\neo_disabled.ico, 1
	iconBenutzen = 1
	if (bildschirmTastaturEinbinden==1) {
		FileInstall, ebene1.png, %ResourceFolder%\ebene1.png, 1
		FileInstall, ebene2.png, %ResourceFolder%\ebene2.png, 1
		FileInstall, ebene3.png, %ResourceFolder%\ebene3.png, 1
		FileInstall, ebene4.png, %ResourceFolder%\ebene4.png, 1
		FileInstall, ebene5.png, %ResourceFolder%\ebene5.png, 1
		FileInstall, ebene6.png, %ResourceFolder%\ebene6.png, 1
		zeigeBildschirmTastatur = 1
	}
} else {
	MsgBox, "Das Verzeichnis %ResourceFolder% konnte nicht angelegt werden!" ; Diese Zeile dient nur der eventuellen Fehlersuche und sollte eigentlich niemals auftauchen.
}

; Benutze die Dateien auch dann, wenn sie eventuell im aktuellen Verzeichnis vorhanden sind 
if ( FileExist("ebene1.png") && FileExist("ebene2.png") && FileExist("ebene3.png") && FileExist("ebene4.png") && FileExist("ebene5.png") && FileExist("ebene6.png") )
  zeigeBildschirmTastatur = 1
if ( FileExist("neo.ico") && FileExist("neo_disabled.ico") )
  iconBenutzen = 1


/*************************
 lernModus Konfiguration *
 nur relevant wenn       *
 lernModus = 1           *
 Strg+Komma schaltet um  *
**************************
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


  

; aus Noras script kopiert:

Process,Priority,,High

#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann eingerückt werden, 
  ; msgbox ist trotzdem linksbündig

SetTitleMatchMode 2
SendMode Input  

name    = Neo 2.0
enable  = Aktiviere %name%
disable = Deaktiviere %name%

; Überprüfung auf deutsches Tastaturlayout 
; ----------------------------------------

regread, inputlocale, HKEY_CURRENT_USER, Keyboard Layout\Preload, 1
regread, inputlocalealias, HKEY_CURRENT_USER
     , Keyboard Layout\Substitutes, %inputlocale%
if inputlocalealias <>
   inputlocale = %inputlocalealias%
if inputlocale <> 00000407
{
   suspend   
   regread, inputlocale, HKEY_LOCAL_MACHINE
     , SYSTEM\CurrentControlSet\Control\Keyboard Layouts\%inputlocale%
     , Layout Text
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



; Menü des Systray-Icons 
; ----------------------

if (iconBenutzen)
   menu, tray, icon, %ResourceFolder%\neo.ico,,1
menu, tray, nostandard
menu, tray, add, Öffnen, open
   menu, helpmenu, add, About, about
   menu, helpmenu, add, Autohotkey-Hilfe, help
   menu, helpmenu, add
   menu, helpmenu, add, http://&autohotkey.com/, autohotkey
   menu, helpmenu, add, http://www.neo-layout.org/, neo
menu, tray, add, Hilfe, :helpmenu
menu, tray, add
menu, tray, add, %disable%, togglesuspend
menu, tray, default, %disable%
menu, tray, add
menu, tray, add, Edit, edit
menu, tray, add, Reload, reload
menu, tray, add
menu, tray, add, Nicht im Systray anzeigen, hide
menu, tray, add, %name% beenden, exitprogram
menu, tray, tip, %name%


/*
   Variablen initialisieren
*/

DeadKey = ""
CompKey = ""
PriorDeadKey = ""
PriorCompKey = ""
Ebene12 = 0
EbeneAktualisieren()


 


/*
   EinHandNeo
*/
spacepressed := 0
keypressed:= 0

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




/*
   ------------------------------------------------------
   Modifier
   ------------------------------------------------------
*/


;LShift+RShift == CapsLock (simuliert)
; Es werden nur die beiden Tastenkombinationen abgefragt,
; daher kommen LShift und RShift ungehindert bis in die
; Applikation. Dies ist aber merkwürdig, da beide Shift-
; Tasten nun /modifier keys/ werden und, wie in der AHK-
; Hilfe beschrieben, eigentlich nicht mehr bis zur App
; durchkommen sollten.

VKA1SC136 & VKA0SC02A:: ; RShift, dann LShift
VKA0SC02A & VKA1SC136:: ; LShift, dann RShift
;
; mit diesen funktioniert das automatische Übernehmen der
; gedrückten Shift-Tasten nicht, also z.B. Shift-Ins, wenn Ins
; bei gedrückter Shift-Taste {blind} gesendet wird
; *VKA1SC136::
; *VKA0SC02A::
   if (GetKeyState("VKA1SC136", "P") and GetKeyState("VKA0SC02A", "P"))
      send {blind}{capslock}
return


; Mod3+Mod3 == Mod3-Lock
; Im Gegensatz zu LShift+RShift werden die beiden Tasten
; _nicht_ zur Applikation weitergeleitet, da '#' kein
; Modifier ist und CapsLock sonst den CapsLock-Status
; beeinflusst. Dafür werden sämtliche Events dieser
; Tasten abgefangen, und nur bei gleichzeitigem Drücken
; wird der Mod3-Lock aktiviert und angezeigt.

IsMod3Locked := 0
; VKBFSC02B & VK14SC03A::
; VK14SC03A & VKBFSC02B::
*VKBFSC02B:: ; #
*VK14SC03A:: ; CapsLock
   if (GetKeyState("VKBFSC02B", "P") and GetKeyState("VK14SC03A", "P"))
   {
      if (IsMod3Locked) 
      {
         IsMod3Locked = 0
         MsgBox Mod3-Feststellung aufgebehoben
      }
      else
      {
         IsMod3Locked = 1
         MsgBox Mod3 festgestellt: Um Mod3 wieder zu lösen drücke beide Mod3 Tasten gleichzeitig 
      }
   }
return

; Mod4+Mod4 == Mod4-Lock
; Wie bei Mod3-Lock werden im Gegensatz zu LShift+RShift 
; die beiden Tasten _nicht_ zur Applikation weitergeleitet,
; und nur bei gleichzeitigem Drücken wird der Mod4-Lock
; aktiviert und angezeigt.

IsMod4Locked := 0
; VKA5SC138 & VKE2SC056:: ; AltGr, dann <
; VKE2SC056 & VKA5SC138:: ; <, dann AltGr
*VKA5SC138::
*VKE2SC056::
   if (GetKeyState("VKA5SC138", "P") and GetKeyState("VKE2SC056", "P"))
   {
      ; Mod4-Lock durch Mod4(rechts)+Mod4(links)
      if (IsMod4Locked) 
      {
         MsgBox Mod4-Feststellung aufgebehoben
         IsMod4Locked = 0
         if (UseMod4Light==1)
         {
            KeyboardLED(1,"off")
         }
      }
      else
      {
         MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen drücke beide Mod4 Tasten gleichzeitig
         IsMod4Locked = 1
         if (UseMod4Light==1)
         {
            KeyboardLED(1,"on")
         }
      }
   }
return
/*
   ------------------------------------------------------
   QWERTZ->Neo umwandlung
   ------------------------------------------------------
*/
; Reihe 1
*VKDCSC029::goto neo_tot1  ; Zirkumflex ^
*VK31SC002::goto neo_1
*VK32SC003::goto neo_2
*VK33SC004::goto neo_3
*VK34SC005::goto neo_4
*VK35SC006::goto neo_5
*VK36SC007::goto neo_6
*VK37SC008::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_7
     else
      {
        keypressed := 1
        goto %gespiegelt_7%
      }
*VK38SC009::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_8
     else
      {
        keypressed := 1
        goto %gespiegelt_8%
      }
*VK39SC00A::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_9
     else
      {
        keypressed := 1
        goto %gespiegelt_9%
      }
*VK30SC00B::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_0
     else
      {
        keypressed := 1
        goto %gespiegelt_0%
      }
*VKDBSC00C:: ; ß
  if ( not(ahkTreiberKombi) )
  {
       if( not(einHandNeo) or not(spacepressed) )
       goto neo_strich
     else
      {
        keypressed := 1
        goto %gespiegelt_strich%
      }
   }
  else
  {
     goto neo_sz   
  }
*VKDDSC00D::goto neo_tot2  ; Akut			
; Reihe 2
VK09SC00F::goto neo_tab
*VK51SC010:: ; q (x)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_x
  }
  else
  {
     goto neo_q   
  }
*VK57SC011:: ; w (v)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_v
  }
  else
  {
     goto neo_w   
  }
*VK45SC012:: ; e (l)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_l
  }
  else
  {
     goto neo_e   
  }
*VK52SC013:: ; r (c)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_c
  }
  else
  {
     goto neo_r   
  }
*VK54SC014:: ; t (w)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_w
  }
  else
  {
     goto neo_t   
  }
*VK5ASC015:: ; z (k) 
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_k
     else
      {
        keypressed := 1
        goto %gespiegelt_k%
      }
  }
  else
  {
     goto neo_z   
  }
*VK55SC016:: ; u (h)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_h
     else
      {
        keypressed := 1
        goto %gespiegelt_h%
      }
  }
  else
  {
     goto neo_u   
  }
*VK49SC017:: ; i (g)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_g
     else
      {
        keypressed := 1
        goto %gespiegelt_g%
      }
  }
  else
  {
     goto neo_i   
  }
*VK4FSC018:: ; o (f)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_f
     else
      {
        keypressed := 1
        goto %gespiegelt_f%
      }
  }
  else
  {
     goto neo_o   
  }
*VK50SC019:: ; p (q)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_q
     else
      {
        keypressed := 1
        goto %gespiegelt_q%
      }
  }
  else
  {
     goto neo_p   
  }
*VKBASC01A:: ; ü (ß)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_sz
     else
      {
        keypressed := 1
        goto %gespiegelt_sz%
      }
  }
  else
  {
     goto neo_ü   
  }
*VKBBSC01B:: ; + (tot3)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_tot3
     else
      {
        keypressed := 1
        goto %gespiegelt_tot3%
      }
  }
  else
  { } ; this should never happen

; Reihe 3
*VK41SC01E:: ; a (u)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_u
  }
  else
  {
     goto neo_a   
  }
*VK53SC01F:: ; s (i)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_i
  }
  else
  {
     goto neo_s   
  }
*VK44SC020:: ; d (a)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_a
  }
  else
  {
     goto neo_d   
  }
*VK46SC021:: ; f (e)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_e
  }
  else
  {
     goto neo_f   
  }
*VK47SC022:: ; g (o)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_o
  }
  else
  {
     goto neo_g   
  }
*VK48SC023:: ; h (s)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_s
     else
      {
        keypressed := 1
        goto %gespiegelt_s%
      }
  }
  else
  {
     goto neo_h   
  }
*VK4ASC024:: ; j (n)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_n
     else
      {
        keypressed := 1
        goto %gespiegelt_n%
      }
  }
  else
  {
     goto neo_j   
  }
*VK4BSC025:: ; k (r)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_r
     else
      {
        keypressed := 1
        goto %gespiegelt_r%
      }
  }
  else
  {
     goto neo_k   
  }
*VK4CSC026:: ; l (t)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_t
     else
      {
        keypressed := 1
        goto %gespiegelt_t%
      }
  }
  else
  {
     goto neo_l   
  }
*VKC0SC027:: ; ö (d)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_d
     else
      {
        keypressed := 1
        goto %gespiegelt_d%
      }
  }
  else
  {
     goto neo_ö   
  }
*VKDESC028:: ; ä (y)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_y
  }
  else
  {
     goto neo_ä
  }

; Reihe 4
*VK59SC02C:: ; y (ü)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ü
  }
  else
  {
     goto neo_y   
  }
*VK58SC02D:: ; x (ö)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ö
  }
  else
  {
     goto neo_x   
  }
*VK43SC02E:: ; c (ä)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ä
  }
  else
  {
     goto neo_c
  }
*VK56SC02F:: ; v (p)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_p
  }
  else
  {
     goto neo_v
  }
*VK42SC030:: ; b (z)
  if ( not(ahkTreiberKombi) )
  {
     goto neo_z
  }
  else
  {
     goto neo_b
  }
*VK4ESC031:: ; n (b)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_b
     else
      {
        keypressed := 1
        goto %gespiegelt_b%
      }
  }
  else
  {
     goto neo_n
  }
*VK4DSC032:: ; m (m)
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_m
     else
      {
        keypressed := 1
        goto %gespiegelt_m%
      }
*VKBCSC033:: ; , (,)
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_komma
     else
      {
        keypressed := 1
        goto %gespiegelt_komma%
      }
*VKBESC034:: ; . (.)
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_punkt
     else
      {
        keypressed := 1
        goto %gespiegelt_punkt%
      }
*VKBDSC035:: ; - (j)
  if ( not(ahkTreiberKombi) )
  {
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_j
     else
      {
        keypressed := 1
        goto %gespiegelt_j%
      }
  }
  else
  {
     goto neo_strich
  }

; Numpad
*VK6FSC135::goto neo_NumpadDiv
*VK6ASC037::goto neo_NumpadMult
*VK6DSC04A::goto neo_NumpadSub
*VK6BSC04E::goto neo_NumpadAdd
*VK0DSC11C::goto neo_NumpadEnter

*VK67SC047::                      ; NumPad7    (mit NumLock  und ohne Shift)
*VK24SC047::goto neo_Numpad7      ; NumPadHome (ohne Numlock oder mit Shift)

*VK68SC048::                      ; NumPad8    (mit NumLock  und ohne Shift)
*VK26SC048::goto neo_Numpad8      ; NumPadUp   (ohne Numlock oder mit Shift)

*VK69SC049::                      ; NumPad9    (mit NumLock  und ohne Shift)
*VK21SC049::goto neo_Numpad9      ; NumPadPgUp (ohne Numlock oder mit Shift)

*VK64SC04B::                      ; NumPad4    (mit NumLock  und ohne Shift)
*VK25SC04B::goto neo_Numpad4      ; NumPadLeft (ohne Numlock oder mit Shift)

*VK65SC04C::                      ; NumPad5    (mit NumLock  und ohne Shift)
*VK0CSC04C::goto neo_Numpad5      ; NumPadClear(ohne Numlock oder mit Shift)

*VK66SC04D::                      ; NumPad6    (mit NumLock  und ohne Shift)
*VK27SC04D::goto neo_Numpad6      ; NumPadRight(ohne Numlock oder mit Shift)

*VK61SC04F::                      ; NumPad1    (mit NumLock  und ohne Shift)
*VK23SC04F::goto neo_Numpad1      ; NumPadEnd  (ohne Numlock oder mit Shift)

*VK62SC050::                      ; NumPad2    (mit NumLock  und ohne Shift)
*VK28SC050::goto neo_Numpad2      ; NumPadDown (ohne Numlock oder mit Shift)

*VK63SC051::                      ; NumPad3    (mit NumLock  und ohne Shift)
*VK22SC051::goto neo_Numpad3      ; NumPadPgDn (ohne Numlock oder mit Shift)

*VK60SC052::                      ; NumPad0    (mit NumLock  und ohne Shift)
*VK2DSC052::goto neo_Numpad0      ; NumPadIns  (ohne Numlock oder mit Shift)

*VK6ESC053::                      ; NumPadDot  (mit NumLock  und ohne Shift)
*VK2ESC053::goto neo_NumpadDot    ; NumPadIns  (ohne Numlock oder mit Shift)
/*
Die eigentliche NEO-Belegung und der Hauptteil des AHK-Treibers.


   Ablauf bei toten Tasten:
   1. Ebene Aktualisieren
   2. Abhängig von der Variablen "Ebene" Zeichen ausgeben und die Variable "PriorDeadKey" setzen
   
   Ablauf bei "untoten" Tasten:
   1. Ebene Aktualisieren
   2. Abhängig von den Variablen "Ebene" und "PriorDeadKey" Zeichen ausgeben
   3. "PriorDeadKey" mit leerem String überschreiben

   ------------------------------------------------------
   Reihe 1
   ------------------------------------------------------
*/


neo_tot1:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      deadUni(0x02C6) ; circumflex, tot
      DeadKey := "c1"
   }
   else if (Ebene = 2)
   {
      deadUni(0x02C7) ; caron, tot
      DeadKey := "c2"
   }
   else if (Ebene = 3)
   {
      deadUni(0x02D8) ; brevis
      DeadKey := "c3"
   }
   else if (Ebene = 4)
   {
      deadUni(0x00B7) ; Mittenpunkt, tot
      DeadKey := "c4"
   }
   else if (Ebene = 5)
   {
      deadAsc("-")                 ; querstrich, tot
      DeadKey := "c5"
   }
   else if (Ebene = 6)
   {
      deadAsc(".")                 ; punkt darunter (colon)
      DeadKey := "c6"
   }
   CompKey := PriorCompKey
return

neo_1:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x00B9)
        or CheckDeadUni("c5",0x2081)
        or CheckComp3Uni("r_1",0x217A)       ; römisch xi
        or CheckComp3Uni("R_1",0x216A))      ; römisch XI
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}1{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}1

      if      (PriorDeadKey = "comp")
         CompKey := "1"
      else if (PriorCompKey == "r")
         CompKey := "r_1"
      else if (PriorCompKey == "R")
         CompKey := "R_1"
   }
   else if (Ebene = 2)
      send °
   else if (Ebene = 3)
      SendUnicodeChar(0x00B9) ; 2 Hochgestellte
   else if (Ebene = 4)
      SendUnicodeChar(0x2022) ; bullet
   else if (Ebene = 5)
      SendUnicodeChar(0x2640) ; Piktogramm weiblich
   else if (Ebene = 6)
      SendUnicodeChar(0x00AC) ; Nicht-Symbol
return

neo_2:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x00B2)
        or CheckDeadUni("c5",0x2082)
        or CheckCompUni("r",0x2171)      ; römisch ii
        or CheckCompUni("R",0x2161)      ; römisch II
        or CheckComp3Uni("r_1",0x217B)   ; römisch xii
        or CheckComp3Uni("R_1",0x216B))  ; römisch XII
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}2{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}2

      if (PriorDeadKey = "comp")
         CompKey := "2"
   }
   else if (Ebene = 2)
      SendUnicodeChar(0x2116) ; numero
   else if (Ebene = 3)
      SendUnicodeChar(0x00B2) ; 2 Hochgestellte
   else if (Ebene = 4)
      SendUnicodeChar(0x2023) ; aufzaehlungspfeil
   else if (Ebene = 5)
      SendUnicodeChar(0x26A5) ; Piktogramm Zwitter
   else if (Ebene = 6)
      SendUnicodeChar(0x2228) ; Logisches Oder
return

neo_3:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x00B3)
        or CheckDeadUni("c5",0x2083)
        or CheckCompUni("1",0x2153)           ; 1/3
        or CheckCompUni("2",0x2154)           ; 2/3
        or CheckCompUni("r",0x2172)           ; römisch iii
        or CheckCompUni("R",0x2162))          ; römisch III
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}3{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}3

      if (PriorDeadKey = "comp")
         CompKey := "3"
   }
   else if (Ebene = 2)
      send §
   else if (Ebene = 3)
      SendUnicodeChar(0x00B3) ; 3 Hochgestellte
   else if (Ebene = 4)
   {
       CompKey := PriorCompKey
       DeadKey := PriorDeadKey
   } ; leer
   else if (Ebene = 5)
      SendUnicodeChar(0x2642) ; Piktogramm Mann
   else if (Ebene = 6)
      SendUnicodeChar(0x2227) ; Logisches Und
return

neo_4:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2074)
        or CheckDeadUni("c5",0x2084)
        or CheckCompUni("r",0x2173)     ; römisch iv
        or CheckCompUni("R",0x2163))    ; römisch IV
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}4{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}4

      if (PriorDeadKey = "comp")
         CompKey := "4"
   }
   else if (Ebene = 2)
      SendUnicodeChar(0x00BB) ; », Double guillemot right
    else if (Ebene = 3)
      Send {blind}› ; Single guillemot right
   else if (Ebene = 4)
      Send {blind}{PgUp}    ; Prev
   else if (Ebene = 5)
      SendUnicodeChar(0x2113) ; Script small L
   else if (Ebene = 6)
      SendUnicodeChar(0x22A5) ; Senkrecht
return

neo_5:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2075)
        or CheckDeadUni("c5",0x2085)
        or CheckCompUni("1",0x2155)           ; 1/5
        or CheckCompUni("2",0x2156)           ; 2/5
        or CheckCompUni("3",0x2157)           ; 3/5
        or CheckCompUni("4",0x2158)           ; 4/5
        or CheckCompUni("r",0x2174)           ; römisch v
        or CheckCompUni("R",0x2164))          ; römisch V
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}5{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}5

      if (PriorDeadKey = "comp")
         CompKey := "5"
   }
   else if (Ebene = 2)
      SendUnicodeChar(0x00AB) ; «, Double guillemot left
   else if (Ebene = 3)
      Send {blind}‹ ; Single guillemot left
   else if (Ebene = 4)
   {
       CompKey := PriorCompKey
       DeadKey := PriorDeadKey
   } ; leer
   else if (Ebene = 5)
      SendUnicodeChar(0x2020) ; Kreuz (Dagger)
   else if (Ebene = 6)
      SendUnicodeChar(0x2221) ; Winkel
return

neo_6:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2076)
        or CheckDeadUni("c5",0x2086)
        or CheckCompUni("1",0x2159)           ; 1/6
        or CheckCompUni("5",0x215A)           ; 5/6
        or CheckCompUni("r",0x2175)           ; römisch vi
        or CheckCompUni("R",0x2165))          ; römisch VI
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}6{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}6

      if (PriorDeadKey = "comp")
         CompKey := "6"
   }
   else if (Ebene = 2)
      send €
   else if (Ebene = 3)
      send {blind}¢
   else if (Ebene = 4)
      send {blind}£
   else if (Ebene = 5)
   {
       CompKey := PriorCompKey
       DeadKey := PriorDeadKey
   } ; leer
   else if (Ebene = 6)
      SendUnicodeChar(0x2225) ; parallel
return

neo_7:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2077)
        or CheckDeadUni("c5",0x2087)
        or CheckCompUni("r",0x2176)     ; römisch vii
        or CheckCompUni("R",0x2166))    ; römisch VII
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}7{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}7

      if (PriorDeadKey = "comp")
         CompKey := "7"
   }
   else if (Ebene = 2)
      send $
   else if (Ebene = 3)
      send {blind}¥
   else if (Ebene = 4)
      send {blind}¤ 
   else if (Ebene = 5)
      SendUnicodeChar(0x03BA) ; greek small letter kappa
   else if (Ebene = 6)
      SendUnicodeChar(0x2209) ; nicht Element von 
return

neo_8:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2078)
        or CheckDeadUni("c5",0x2088)
        or CheckCompUni("1",0x215B)           ; 1/8
        or CheckCompUni("3",0x215C)           ; 3/8
        or CheckCompUni("5",0x215D)           ; 5/8
        or CheckCompUni("7",0x215E)           ; 7/8
        or CheckCompUni("r",0x2177)           ; römisch viii
        or CheckCompUni("R",0x2167))          ; römisch VIII
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}8{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}8

      if (PriorDeadKey = "comp")
         CompKey := "8"
   }
   else if (Ebene = 2)
      send „
   else if (Ebene = 3)
      send {blind}‚
   else if (Ebene = 4)
      Send {blind}{NumpadDiv}
   else if (Ebene = 5)
      SendUnicodeChar(0x27E8) ;bra (öffnende spitze klammer)
   else if (Ebene = 6)
      SendUnicodeChar(0x2204) ; es existiert nicht
return

neo_9:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2079)
        or CheckDeadUni("c5",0x2089)
        or CheckCompUni("r",0x2178)     ; römisch ix
        or CheckCompUni("R",0x2168))    ; römisch IX
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}9{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}9

      if (PriorDeadKey = "comp")
         CompKey := "9"
   }
   else if (Ebene = 2)
      send “
   else if (Ebene = 3)
      send {blind}‘
   else if (Ebene = 4)
      Send {blind}{NumpadMult}
   else if (Ebene = 5)
      SendUnicodeChar(0x27E9) ;ket (schließende spitze klammer)
   else if (Ebene = 6)
      SendUnicodeChar(0x2226) ; nicht parallel
return

neo_0:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      if !(CheckDeadUni("c1",0x2070)
        or CheckDeadUni("c5",0x2080)
        or CheckComp3Uni("r_1",0x2179)     ; römisch x
        or CheckComp3Uni("R_1",0x2169))    ; römisch X
         if (GetKeyState("CapsLock","T")) 
            send {blind}{Shift down}0{Shift up}
         else if (not(lernModus) or lernModus_std_ZahlenReihe)
            send {blind}0

      if (PriorDeadKey = "comp")
         CompKey := "0"
   }
   else if (Ebene = 2)
      send ”
   else if (Ebene = 3)
      send {blind}’
   else if (Ebene = 4)
      Send {blind}{NumpadSub}
   else if (Ebene = 5)
   {
       CompKey := PriorCompKey
       DeadKey := PriorDeadKey
   } ; leer
   else if (Ebene = 6)
      SendUnicodeChar(0x2205) ; leere Menge
return

neo_strich:
   EbeneAktualisieren()
   if (Ebene = 1)
      if (GetKeyState("CapsLock","T")) 
         send {blind}{Shift down}-{Shift up}
      else
         send {blind}- ; Bindestrich-Minus
   else if (Ebene = 2)
      SendUnicodeChar(0x2013) ; Gedankenstrich
   else if (Ebene = 3)
      SendUnicodeChar(0x2014) ; Englischer Gedankenstrich (Geviertstrich)
   else if (Ebene = 4)
   {
       CompKey := PriorCompKey
       DeadKey := PriorDeadKey
   } ; leer
   else if (Ebene = 5)
      SendUnicodeChar(0x2011) ; geschützter Bindestrich (Bindestrich ohne Zeilenumbruch)
   else if (Ebene = 6)
      SendUnicodeChar(0x00AD) ; weicher Bindestrich
return

neo_tot2:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      deadAsc("{´}{space}") ; akut, tot
      DeadKey := "a1"
   }
   else if (Ebene = 2)
   {
      deadAsc("``{space}")
      DeadKey := "a2"
   }
   else if (Ebene = 3)
   {
      deadAsc("¸") ; cedilla
      DeadKey := "a3"
   }
   else if (Ebene = 4)
   {
      deadUni(0x02D9) ; punkt oben drüber
      DeadKey := "a4"
   }
   else if (Ebene = 5)
   {
      deadUni(0x02DB) ; ogonek
      DeadKey := "a5"
   }
   else if (Ebene = 6)
   {
      deadUni(0x02DA)  ; ring obendrauf
      DeadKey := "a6"
   }
   CompKey := PriorCompKey
return


/*
   ------------------------------------------------------
   Reihe 2
   ------------------------------------------------------
*/

neo_x:
   EbeneAktualisieren()
   if (Ebene12)
      OutputChar("x","X")
   else if (Ebene = 3)
      SendUnicodeChar(0x2026) ;Ellipse
   else if (Ebene = 5)
      SendUnicodeChar(0x03BE) ;xi
   else if (Ebene = 6)
      SendUnicodeChar(0x039E)  ; Xi
return


neo_v:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("c6",0x1E7F,0x1E7E)))
      OutputChar("v","V")
   else if (Ebene = 3)
      send {blind}_
   else if (Ebene = 4)
      if (not(lernModus) or lernModus_neo_Backspace)
         Send {blind}{Backspace}
      else
      {
          CompKey := PriorCompKey
          DeadKey := PriorDeadKey
      } ; leer
   else if (Ebene = 6)
      SendUnicodeChar(0x2259) ; estimates
return



neo_l:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x013A,0x0139)
                  or CheckDeadUni12("a3",0x013C,0x013B)
                  or CheckDeadUni12("c2",0x013E,0x013D)
                  or CheckDeadUni12("c4",0x0140,0x013F)
                  or CheckDeadUni12("c6",0x1E37,0x1E36)
                  or CheckDeadUni12("t4",0x0142,0x0141)))
      OutputChar("l","L")
   else if (Ebene = 3)
      send {blind}[
   else if (Ebene = 4)
      Send {Blind}{Up}
   else if (Ebene = 5)
      SendUnicodeChar(0x03BB) ; lambda
   else if (Ebene = 6)
      SendUnicodeChar(0x039B) ; Lambda
return


neo_c:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x0107,0x0106)
                  or CheckDeadUni12("a3",0x00E7,0x00E6)
                  or CheckDeadUni12("a4",0x010B,0x010A)
                  or CheckDeadUni12("c1",0x0109,0x0108)
                  or CheckDeadUni12("c2",0x010D,0x010C)
                  or CheckCompAsc12("o","©","©")
                  or CheckCompAsc12("O","©","©")))
      OutputChar("c","C")
   else if (Ebene = 3)
      send {blind}]
   else if (Ebene = 4)
      if (not(lernModus) or lernModus_neo_Entf)
        Send {blind}{Del}
      else
      {
          CompKey := PriorCompKey
          DeadKey := PriorDeadKey
      } ; leer
   else if (Ebene = 5)
      SendUnicodeChar(0x03C7) ;chi
   else if (Ebene = 6)
      SendUnicodeChar(0x2102)  ; C (Komplexe Zahlen)
return

neo_w:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("c1",0x0175,0x0174)))
      OutputChar("w","W")
   else if (Ebene = 3)
      SendUnicodeChar(0x005E) ; untotes ^ - Unicode-Name: CIRCUMFLEX ACCENT
      ;send {^}{space} ; Funktioniert nicht unter Java-Programmen 
   else if (Ebene = 4)
      Send {blind}{Insert}
   else if (Ebene = 5)
      SendUnicodeChar(0x03C9) ; omega
   else if (Ebene = 6)
      SendUnicodeChar(0x03A9) ; Omega
return

neo_k:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a3",0x0137,0x0136)
                  or CheckDeadUni12("c6",0x1E33,0x1E32)))
      OutputChar("k","K")
   else if (Ebene = 3)
      send {blind}{!}
   else if (Ebene = 4)
      Send ¡
   else if (Ebene = 5)
      SendUnicodeChar(0x03F0) ;kappa symbol (varkappa)
   else if (Ebene = 6)
      SendUnicodeChar(0x221A) ; Wurzel
return

neo_h:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E23,0x1E22)
                  or CheckDeadUni12("c1",0x0125,0x0124)
                  or CheckDeadUni12("c5",0x0127,0x0126)
                  or CheckDeadUni12("c6",0x1E25,0x1E24)))
      OutputChar("h","H")
   else if ((Ebene = 3) and !(CheckDeadUni("c5",0x2264))) ; kleiner gleich
      send {blind}<
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2077)
                           or CheckDeadUni("c5",0x2087)))
      Send {blind}{NumPad7}
   else if (Ebene = 5)
      SendUnicodeChar(0x03C8) ;psi
   else if (Ebene = 6)
      SendUnicodeChar(0x03A8)  ; Psi
return

neo_g:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a3",0x0123,0x0122)
                  or CheckDeadUni12("a4",0x0121,0x0120)
                  or CheckDeadUni12("c1",0x011D,0x011C)
                  or CheckDeadUni12("c3",0x011F,0x011E)))
      OutputChar("g","G")
   else if ((Ebene = 3) and !(CheckDeadUni("c5",0x2265))) ; größer gleich
      send {blind}>
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2078)
                           or CheckDeadUni("c5",0x2088)))
      Send {blind}{NumPad8}
   else if (Ebene = 5)
      SendUnicodeChar(0x03B3) ;gamma
   else if (Ebene = 6)
      SendUnicodeChar(0x0393)  ; Gamma
return

neo_f:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E1F,0x1E1E)
                  or CheckDeadUni12("t4",0x0192,0x0191)))
      OutputChar("f","F")
   else if ((Ebene = 3) and !(CheckDeadUni("a6",0x2257)    ; ring equal to
                      or CheckDeadUni("c1",0x2259)    ; entspricht
                      or CheckDeadUni("c2",0x225A)    ; EQUIANGULAR TO
                      or CheckDeadUni("c5",0x2261)    ; identisch
                      or CheckDeadUni("t1",0x2245)    ; ungefähr gleich
                      or CheckDeadUni("t4",0x2260)))  ; ungleich
      send {blind}`=
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2079)
                           or CheckDeadUni("c5",0x2089)))
      Send {blind}{NumPad9}
   else if (Ebene = 5)
      SendUnicodeChar(0x03C6) ; phi
   else if (Ebene = 6)
      SendUnicodeChar(0x03A6)  ; Phi
return

neo_q:
   EbeneAktualisieren()
   if (Ebene12)
      OutputChar("q","Q")
   else if (Ebene = 3)
      send {blind}{&}
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x207A)
                           or CheckDeadUni("c5",0x208A)))
      Send {blind}{NumPadAdd}
   else if (Ebene = 5)
      SendUnicodeChar(0x03D5) ; phi symbol (varphi)
   else if (Ebene = 6)
      SendUnicodeChar(0x211A) ; Q (rationale Zahlen)
return

neo_sz:
   EbeneAktualisieren()
   if (Ebene = 1)
      if (GetKeyState("CapsLock","T"))
         SendUnicodeChar(0x1E9E) ; verssal-ß
      else if (LangSTastatur = 1)
         send {blind}s
      else
         send ß
   else if (Ebene = 2)
      if (GetKeyState("CapsLock","T"))
         if (LangSTastatur = 1)
            send {blind}s
         else
            send ß
      else
         SendUnicodeChar(0x1E9E) ; versal-ß
   else if (Ebene = 3)
      if (LangSTastatur = 1)
         send ß
      else
         SendUnicodeChar(0x017F) ; langes s
   else if (Ebene = 5)
      SendUnicodeChar(0x03C2) ; varsigma
   else if (Ebene = 6)
      SendUnicodeChar(0x2218) ; Verknüpfungsoperator
return


neo_tot3:
   EbeneAktualisieren()
   if (Ebene = 1)
   {
      deadUni(0x02DC)  ; tilde, tot 
      DeadKey := "t1"
   }
   else if (Ebene = 2)
   {
      deadUni(0x00AF)  ; macron, tot
      DeadKey := "t2"
   }
   else if (Ebene = 3)
   {
      deadUni(0x00A8)  ; diaerese
      DeadKey := "t3"
   }
   else if (Ebene = 4)
   {
      deadUni(0x002F)  ; Schrägstrich, tot
      DeadKey := "t4"
   }
   else if (Ebene = 5)
   {
      deadUni(0x02DD)  ;doppelakut
      DeadKey := "t5"
   }
   else if (Ebene = 6)
   {
      deadUni(0x02CF)  ; komma drunter, tot
      DeadKey := "t6"
   }
   
return


/*
   ------------------------------------------------------
   Reihe 3
   ------------------------------------------------------
*/

neo_u:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x00FA,0x00DA)
                  or CheckDeadUni12("a2",0x00F9,0x00D9)
                  or CheckDeadUni12("a5",0x0173,0x0172)
                  or CheckDeadUni12("a6",0x016F,0x016E)
                  or CheckDeadUni12("c1",0x00FB,0x00DB)
                  or CheckDeadUni12("c2",0x01D4,0x01D3)
                  or CheckDeadUni12("c3",0x016D,0x016C)
                  or CheckDeadUni12("t1",0x0169,0x0168)
                  or CheckDeadUni12("t2",0x016B,0x016A)
                  or CheckDeadAsc12("t3","ü","Ü")
                  or CheckDeadUni12("t5",0x0171,0x0170)))
      OutputChar("u","U")
   else if (Ebene = 3)
      send {blind}\
   else if (Ebene = 4)
      Send {blind}{Home}
   else if (Ebene = 5)
   {
       CompKey := PriorCompKey
       DeadKey := PriorDeadKey
   } ; leer
   else if (Ebene = 6)
      SendUnicodeChar(0x222E) ; contour integral
return

neo_i:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x00ED,0x00CD)
                  or CheckDeadUni12("a2",0x00EC,0x00CC)
                  or CheckDeadUni12("a4",0x012F,0x012E)
                  or CheckDeadUni12("a5",0x0131,0x0130)
                  or CheckDeadUni12("c1",0x00EE,0x00CE)
                  or CheckDeadUni12("c2",0x01D0,0x01CF)
                  or CheckDeadUni12("c3",0x012D,0x012C)
                  or CheckDeadUni12("t1",0x0129,0x0128)
                  or CheckDeadUni12("t2",0x012B,0x012A)
                  or CheckDeadAsc12("t3","ï","Ï")))
      OutputChar("i","I")
   else if (Ebene = 3)
      send {blind}`/
   else if (Ebene = 4)
      Send {Blind}{Left}
   else if (Ebene = 5    )
      SendUnicodeChar(0x03B9) ; iota
   else if (Ebene = 6)
      SendUnicodeChar(0x222B) ; integral
return

neo_a:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x00E1,0x00C1)
                  or CheckDeadUni12("a2",0x00E0,0x00C0)
                  or CheckDeadUni12("a5",0x0105,0x0104)
                  or CheckDeadAsc12("a6","å","Å")
                  or CheckDeadUni12("c1",0x00E2,0x00C2)
                  or CheckDeadUni12("c2",0x01CE,0x01CD)
                  or CheckDeadUni12("c3",0x0103,0x0102)
                  or CheckDeadUni12("t1",0x00E3,0x00C3)
                  or CheckDeadUni12("t2",0x0101,0x0100)
                  or CheckDeadAsc12("t3","ä","Ä")))
      OutputChar("a","A")
   else if (Ebene = 3)
      send {blind}{{}   ; }
   else if (Ebene = 4)
      Send {Blind}{Down}
   else if (Ebene = 5)
      SendUnicodeChar(0x03B1) ;alpha
   else if (Ebene = 6)
      SendUnicodeChar(0x2200) ;fuer alle   
return

neo_e:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x00E9,0x00C9)
                  or CheckDeadUni12("a2",0x00E8,0x00C8)
                  or CheckDeadUni12("a4",0x0117,0x0116)
                  or CheckDeadUni12("a5",0x0119,0x0118)
                  or CheckDeadUni12("c1",0x00EA,0x00CA)
                  or CheckDeadUni12("c2",0x011B,0x011A)
                  or CheckDeadUni12("c3",0x0115,0x0114)
                  or CheckDeadUni12("t2",0x0113,0x0112)
                  or CheckDeadAsc12("t3","ë","Ë")
                  or CheckCompAsc12("a","æ","Æ")
                  or CheckCompAsc12("A","Æ","Æ")
                  or CheckCompAsc12("o","œ","Œ")
                  or CheckCompAsc12("O","Œ","Œ")))
      OutputChar("e","E")
   else if (Ebene = 3)      ; {
      send {blind}{}}
   else if (Ebene = 4)
      Send {Blind}{Right}
   else if (Ebene = 5)
        SendUnicodeChar(0x03B5) ;epsilon
   else if (Ebene = 6)
        SendUnicodeChar(0x2203) ;es existiert   
return

neo_o:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x00F3,0x00D3)
                  or CheckDeadUni12("a2",0x00F2,0x00D2)
                  or CheckDeadUni12("a5",0x01EB,0x01EA)
                  or CheckDeadUni12("c1",0x00F4,0x00D4)
                  or CheckDeadUni12("c2",0x01D2,0x01D1)
                  or CheckDeadUni12("c3",0x014F,0x014E)
                  or CheckDeadUni12("t1",0x00F5,0x00D5)
                  or CheckDeadUni12("t2",0x014D,0x014C)
                  or CheckDeadAsc12("t3","ö","Ö")
                  or CheckDeadUni12("t4",0x00F8,0x00D8)
                  or CheckDeadUni12("t5",0x0151,0x0150)))
      OutputChar("o","O")
   else if (Ebene = 3)
      send {blind}*
   else if (Ebene = 4)
      Send {blind}{End}
   else if (Ebene = 5)
      SendUnicodeChar(0x03BF) ; omicron
   else if (Ebene = 6)
      SendUnicodeChar(0x2208) ; element of
return

neo_s:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x015B,0x015A)
                  or CheckDeadUni12("a3",0x015F,0x015E)
                  or CheckDeadUni12("a4",0x1E61,0x1E60)
                  or CheckDeadUni12("c1",0x015D,0x015C)
                  or CheckDeadUni12("c2",0x0161,0x0160)
                  or CheckDeadUni12("c6",0x1E63,0x1A62)))
      if (LangSTastatur = 1)
         if (GetKeyState("CapsLock","T") xor (Ebene = 1))
            SendUnicodeChar(0x017F) ; langes s
         else
            OutputChar("s","S")
      else
         OutputChar("s","S")
   else if (Ebene = 3)
      send {blind}?
   else if (Ebene = 4)
      Send ¿
   else if (Ebene = 5)
      SendUnicodeChar(0x03C3) ;sigma
   else if (Ebene = 6)
      SendUnicodeChar(0x03A3)  ; Sigma
return

neo_n:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x0144,0x0143)
                  or CheckDeadUni12("a3",0x0146,0x0145)
                  or CheckDeadUni12("a4",0x1E45,0x1E44)
                  or CheckDeadUni12("c2",0x0148,0x0147)
                  or CheckDeadUni12("t1",0x00F1,0x00D1)))
      OutputChar("n","N")
   else if (Ebene = 3)
      send {blind}(                 ; )
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2074)
                           or CheckDeadUni("c5",0x2084)))
      Send {blind}{NumPad4}
   else if (Ebene = 5)
      SendUnicodeChar(0x03BD) ; nu
   else if (Ebene = 6)
      SendUnicodeChar(0x2115) ; N (natürliche Zahlen)
return

neo_r:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x0155,0x0154)
                  or CheckDeadUni12("a3",0x0157,0x0156)
                  or CheckDeadUni12("a4",0x0E59,0x0E58)
                  or CheckDeadUni12("c2",0x0159,0x0158)
                  or CheckDeadUni12("c6",0x1E5B,0x1E5A)
                  or CheckCompAsc12("o","®","®")
                  or CheckCompAsc12("O","®","®")))
      OutputChar("r","R")
   else if (Ebene = 3)                ;(
      send {blind})
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2075)
                           or CheckDeadUni("c5",0x2085)))
      Send {blind}{NumPad5}
   else if (Ebene = 5)
      SendUnicodeChar(0x03F1) ; rho symbol (varrho)
   else if (Ebene = 6)
      SendUnicodeChar(0x211D) ; R (reelle Zahlen)
return

neo_t:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a3",0x0163,0x0162)
                  or CheckDeadUni12("a4",0x1E6B,0x1E6A)
                  or CheckDeadUni12("c2",0x0165,0x0164)
                  or CheckDeadUni12("c5",0x0167,0x0166)
                  or CheckDeadUni12("c6",0x1E6D,0x1E6C)))
      OutputChar("t","T")
   else if (Ebene = 3)
      send {blind}- ; Bis
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2076)
                           or CheckDeadUni("c5",0x2086)))
      Send {blind}{NumPad6}
   else if (Ebene = 5)
      SendUnicodeChar(0x03C4) ; tau
   else if (Ebene = 6)
      SendUnicodeChar(0x2202 ) ; partielle Ableitung
return

neo_d:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E0B,0x1E0A)
                  or CheckDeadUni12("c2",0x010F,0x010E)
                  or CheckDeadUni12("c5",0x0111,0x0110)
                  or CheckDeadUni12("c6",0x1E0D,0x1E0C)
                  or CheckDeadUni12("t4",0x00F0,0x00D0)))
      OutputChar("d","D")
   else if (Ebene = 3)
      send {blind}:
   else if (Ebene = 4)
      Send {blind}{NumPadKomma}
   else if (Ebene = 5)
      SendUnicodeChar(0x03B4) ;delta
   else if (Ebene = 6)
      SendUnicodeChar(0x0394)  ; Delta
return

neo_y:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x00FD,0x00DD)
                  or CheckDeadUni12("c1",0x0177,0x0176)
                  or CheckDeadAsc12("t3","ÿ",Ÿ)))
      OutputChar("y","Y")
   else if (Ebene = 3)
      send {blind}@
   else if (Ebene = 4)
      Send {blind}.
   else if (Ebene = 5)
      SendUnicodeChar(0x03C5) ; upsilon
   else if (Ebene = 6)
      SendUnicodeChar(0x2207) ; nabla
return

/*
   ------------------------------------------------------
   Reihe 4
   ------------------------------------------------------
*/

neo_ü:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x01D8,0x01D7)
                  or CheckDeadUni12("a2",0x01DC,0x01DB)
                  or CheckDeadUni12("c2",0x01DA,0x01D9)
                  or CheckDeadUni12("t2",0x01D6,0x01D5)))
      OutputChar("ü","Ü")
   else if (Ebene = 3)
      send {blind}{#}
   else if (Ebene = 4)
      Send {blind}{Esc}
   else if (Ebene = 5)
   {
      DeadKey := PriorDeadKey
      CompKey := PriorCompKey
   } ; leer
   else if (Ebene = 6)
      SendUnicodeChar(0x221D) ; proportional
return

neo_ö:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("t2",0x022B,0x022A)))
      OutputChar("ö","Ö")
   else if (Ebene = 3)
      send {blind}$
   else if (Ebene = 4)
      send {blind}{Tab}
   else if (Ebene = 5)
   {
      DeadKey := PriorDeadKey
      CompKey := PriorCompKey
   } ; leer
   else if (Ebene = 6)
      SendUnicodeChar(0x2111) ; Fraktur I
return

neo_ä:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("t2",0x01DF,0x01DE)))
      OutputChar("ä","Ä")
   else if (Ebene = 3)
      send {blind}|
   else if (Ebene = 4)
      Send {blind}{PgDn}    ; Next
   else if (Ebene = 5)
      SendUnicodeChar(0x03B7) ; eta
   else if (Ebene = 6)
      SendUnicodeChar(0x211C) ; altes R
return

neo_p:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E57,0x1E56)))
      OutputChar("p","P")
   else if ((Ebene = 3) and !(CheckDeadUni("t1",0x2248)))
      send {blind}~
   else if (Ebene = 4)
        Send {blind}{Enter}
   else if (Ebene = 5)
      SendUnicodeChar(0x03C0) ;pi
   else if (Ebene = 6)
      SendUnicodeChar(0x03A0)  ; Pi
return

neo_z:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a1",0x017A,0x0179)
                  or CheckDeadUni12("a4",0x017C,0x017B)
                  or CheckDeadUni12("c2",0x017E,0x017D)
                  or CheckDeadUni12("c6",0x1E93,0x1E92)))
      OutputChar("z","Z")
   else if (Ebene = 3)
      send ``{space} ; untot
   else if (Ebene = 4)
   {
      DeadKey := PriorDeadKey
      CompKey := PriorCompKey
   } ; leer
   else if (Ebene = 5)
      SendUnicodeChar(0x03B6) ;zeta 
   else if (Ebene = 6)
      SendUnicodeChar(0x2124)  ; Z (ganze Zahlen)
return

neo_b:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E03,0x1E02)))
      OutputChar("b","B")
   else if (Ebene = 3)
      send {blind}{+}
   else if (Ebene = 4)
      send {blind}:
   else if (Ebene = 5)
      SendUnicodeChar(0x03B2) ; beta
   else if (Ebene = 6)
      SendUnicodeChar(0x21D2) ; Doppel-Pfeil rechts
return

neo_m:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E41,0x1E40)
                  or CheckDeadUni12("c6",0x1E43,0x1E42)
                  or CheckCompUni12("t",0x2122,0x2122)        ; TM
                  or CheckCompUni12("T",0x2122,0x2122)        ; TM
                  or CheckCompUni12("s",0x2120,0x2120)        ; SM
                  or CheckCompUni12("S",0x2120,0x2120)))      ; SM

      OutputChar("m","M")
   else if (Ebene = 3)
      send {blind}`%
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B9)
                           or CheckDeadUni("c5",0x2081)))
      Send {blind}{NumPad1}
   else if (Ebene = 5)
      SendUnicodeChar(0x03BC) ; griechisch mu, micro wäre 0x00B5
   else if (Ebene = 6)
      SendUnicodeChar(0x21D4) ; doppelter Doppelpfeil (genau dann wenn)
return

neo_komma:
   EbeneAktualisieren()
   if (Ebene = 1)
      if (GetKeyState("CapsLock","T")) 
         send {blind}{Shift down},{Shift up}
      else
         send {blind},
   else if (Ebene = 2)
       SendUnicodeChar(0x22EE) ;  vertikale ellipse 
   else if (Ebene = 3)
      send {blind}"
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B2)
                           or CheckDeadUni("c5",0x2082)))
      Send {blind}{NumPad2}
   else if (Ebene = 5)
      SendUnicodeChar(0x03C1) ; rho
   else if (Ebene = 6)
      SendUnicodeChar(0x21D0) ; Doppelpfeil links
return

neo_punkt:
   EbeneAktualisieren()
   if (Ebene = 1)
      if (GetKeyState("CapsLock","T")) 
         send {blind}{Shift down}.{Shift up}
      else
         send {blind}.
   else if (Ebene = 2)
      SendUnicodeChar(0x2026)  ; ellipse
   else if (Ebene = 3)
      send {blind}'
   else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B3)
                           or CheckDeadUni("c5",0x2083)))
      Send {blind}{NumPad3}
   else if (Ebene = 5)
      SendUnicodeChar(0x03D1) ; theta symbol (vartheta)
   else if (Ebene = 6)
      SendUnicodeChar(0x0398)  ; Theta
return


neo_j:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("c1",0x0135,0x0134)
                  or CheckDeadUni12("c2",0x01F0,"")
                  or CheckCompUni12("i",0x0133,"")          ; ij
                  or CheckCompUni12("I","",0x0132)          ; IJ
                  or CheckCompUni12("l",0x01C9,"")          ; lj
                  or CheckCompUni12("L",0x01C8,0x01C7)      ; Lj/LJ
                  or CheckCompUni12("n",0x01CC,"")          ; nj
                  or CheckCompUni12("N",0x01CB,0x01CA)))    ; Nj/NJ
      OutputChar("j","J")
   else if (Ebene = 3)
      send {blind}`;
   else if (Ebene = 4)
      Send {blind}`;
   else if (Ebene = 5)
      SendUnicodeChar(0x03B8) ; theta
   else if (Ebene = 6)
      SendUnicodeChar(0x2261) ; identisch
return

/*
   ------------------------------------------------------
   Numpad
   ------------------------------------------------------

   folgende Tasten verhalten sich bei ein- und ausgeschaltetem
   NumLock gleich:
*/

neo_NumpadDiv:
   EbeneAktualisieren()
   if ((Ebene = 1) or (Ebene = 2))
      send {blind}{NumpadDiv}
   else if (Ebene = 3)
      send {blind}÷
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2215)   ; slash
return

neo_NumpadMult:
   EbeneAktualisieren()
   if ((Ebene = 1) or (Ebene = 2))
      send {blind}{NumpadMult}
   else if (Ebene = 3)
      send {blind}×
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x22C5)  ; cdot
return

neo_NumpadSub:
   EbeneAktualisieren()
   if (((Ebene = 1) or (Ebene = 2)) and !(CheckDeadUni("c1",0x207B)
                                       or CheckDeadUni("c5",0x208B)))
      send {blind}{NumpadSub}
   else if (Ebene = 3)
      SendUnicodeChar(0x2212) ; echtes minus
return

neo_NumpadAdd:
   EbeneAktualisieren()
   if (((Ebene = 1) or (Ebene = 2)) and !(CheckDeadUni("c1",0x207A)
                                       or CheckDeadUni("c5",0x208A)))
      send {blind}{NumpadAdd}
   else if (Ebene = 3)
      send {blind}±
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2213)   ; -+
return

neo_NumpadEnter:
   EbeneAktualisieren()
   if ((Ebene = 1) or (Ebene = 2))
      send {blind}{NumpadEnter}      
   else if (Ebene = 3)
      SendUnicodeChar(0x2260) ; neq
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2248) ; approx
return

/*
   folgende Tasten verhalten sich bei ein- und ausgeschaltetem NumLock
   unterschiedlich
*/



neo_Numpad7:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadHome}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadHome}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if (Ebene = 1)
         send {blind}{Numpad7}
      else
         send {blind){Shift up}{Numpad7}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_7"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2195)   ; Hoch-Runter-Pfeil
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x226A)  ; ll
return

neo_Numpad8:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadUp}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadUp}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if !(CheckCompUni("Num_1",0x215B) ; 1/8
        or CheckCompUni("1",0x215B)     ; 1/8
        or CheckCompUni("Num_3",0x215C) ; 3/8
        or CheckCompUni("3",0x215C)     ; 3/8
        or CheckCompUni("Num_5",0x215D) ; 3/8
        or CheckCompUni("5",0x215D)     ; 5/8
        or CheckCompUni("Num_7",0x215E) ; 7/8
        or CheckCompUni("7",0x215E))    ; 7/8
         if (Ebene = 1)
            send {blind}{Numpad8}
         else
            send {blind){Shift up}{Numpad8}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_8"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2191)     ; uparrow
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2229)    ; intersection
return

neo_Numpad9:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadPgUp}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadPgUp}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if (Ebene = 1)
         send {blind}{Numpad9}
      else
         send {blind){Shift up}{Numpad9}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_9"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2297) ; Tensorprodukt ; Vektor in die Ebene zeigend 
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x226B)  ; gg
return



neo_Numpad4:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadLeft}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadLeft}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if !(CheckCompUni("Num_1",0x00BC) ; 1/4
        or CheckCompUni("1",0x00BE)     ; 1/4
        or CheckCompUni("Num_3",0x00BE) ; 3/4
        or CheckCompUni("3",0x00BE))    ; 3/4
         if (Ebene = 1)
            send {blind}{Numpad4}
         else
            send {blind){Shift up}{Numpad4}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_4"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2190)     ; leftarrow
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2282)  ; subset of
return

neo_Numpad5:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadClear}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadClear}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if !(CheckCompUni("Num_1",0x2155) ; 1/5
        or CheckCompUni("1",0x2155)     ; 1/5
        or CheckCompUni("Num_2",0x2156) ; 2/5
        or CheckCompUni("2",0x2156)     ; 2/5
        or CheckCompUni("Num_3",0x2157) ; 3/5
        or CheckCompUni("3",0x2157)     ; 3/5
        or CheckCompUni("Num_4",0x2158) ; 4/5
        or CheckCompUni("4",0x2158))    ; 4/5
         if (Ebene = 1)
            send {blind}{Numpad5}
         else
            send {blind){Shift up}{Numpad5}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_5"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x221E) ; INFINITY
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x220B) ; enthält das Element
return

neo_Numpad6:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadRight}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadRight}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if !(CheckCompUni("Num_1",0x2159) ; 1/6
        or CheckCompUni("1",0x2159)     ; 1/6
        or CheckCompUni("Num_5",0x215A) ; 5/6
        or CheckCompUni("5",0x215A))    ; 5/6
         if (Ebene = 1)
            send {blind}{Numpad6}
         else
            send {blind){Shift up}{Numpad6}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_6"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2192)     ; rightarrow
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2283) ; superset of
return

neo_Numpad1:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadEnd}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadEnd}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if (Ebene = 1)
         send {blind}{Numpad1}
      else
         send {blind){Shift up}{Numpad1}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_1"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2194) ; Links-Rechts-Pfeil
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2264)   ; leq
return

neo_Numpad2:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadDown}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadDown}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if !(CheckCompUni("Num_1",0x00BD) ; 1/2
        or CheckCompUni("1",0x00BD))    ; 1/2
         if (Ebene = 1)
            send {blind}{Numpad2}
         else
            send {blind){Shift up}{Numpad2}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_2"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x2193)     ; downarrow
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x222A)  ; vereinigt
return

neo_Numpad3:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadPgDn}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadPgDn}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if !(CheckCompUni("Num_1",0x2153) ; 1/3
        or CheckCompUni("1",0x2154)     ; 1/3
        or CheckCompUni("Num_2",0x2154) ; 2/3
        or CheckCompUni("2",0x2154))    ; 2/3
         if (Ebene = 1)
            send {blind}{Numpad3}
         else
            send {blind){Shift up}{Numpad3}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_3"
   }
   else if (Ebene = 3)
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON
   else if ((Ebene = 4) or (Ebene = 5))
      SendUnicodeChar(0x2265)  ; geq
return

neo_Numpad0:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadIns}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadIns}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
   {
      if (Ebene = 1)
         send {blind}{Numpad0}
      else
         send {blind){Shift up}{Numpad0}{Shift down}

      if (PriorDeadKey = "comp")
         CompKey := "Num_0"
   }
   else if (Ebene = 3)
      send {blind}`%
   else if ((Ebene = 4) or (Ebene = 5))
      send ‰ 
return

neo_NumpadDot:
   EbeneAktualisieren()
   if      ((Ebene = 1) and (NumLock = 0))
      send {blind}{NumpadDel}
   else if ((Ebene = 2) and (NumLock = 1))
      send {blind}{Shift up}{NumpadDel}{Shift down}
   else if (((Ebene = 1) and (NumLock = 1)) or ((Ebene = 2) and (NumLock = 0)))
      if (Ebene = 1)
         send {blind}{NumpadDot}
      else
         send {blind){Shift up}{NumpadDot}{Shift down}
   else if (Ebene = 3)
      send {blind}.
   else if ((Ebene = 4) or (Ebene = 5))
      send `,
return


/*
   ------------------------------------------------------
   Sondertasten
   ------------------------------------------------------
*/
*space::
   if ((einHandNeo))
    spacepressed := 1
   else
    goto neo_SpaceUp
return

*space up::
   if ((einHandNeo))
   {
     if ((keypressed))
     {
       keypressed := 0
       spacepressed := 0    
     }
     else
     {
        goto neo_SpaceUp
     }
   }
   else
     { } ;do nothing
return 

neo_SpaceUp:
     EbeneAktualisieren()
     if      ((Ebene = 1) and !(CheckComp3Uni("r_1",0x2170)          ; römisch i
                             or CheckComp3Uni("R_1",0x2160)))      ; römisch I 
        Send {blind}{Space}
     else if  ((Ebene = 2) or (Ebene = 3))
        Send {blind}{Space}
     else if (Ebene = 4)
        if (PriorDeadKey = "c1")            ; circumflex
           BSSendUnicodeChar(0x2070)
        else if (PriorDeadKey = "c5")       ; toter -
           BSSendUnicodeChar(0x2080)
        else
           Send {blind}{NumPad0}
     else if (Ebene = 5)
        SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
     else if (Ebene = 6)
        SendUnicodeChar(0x202F) ; schmales Leerzeichen
     DeadKey := ""   CompKey := ""
  spacepressed := 0     
  keypressed := 0       
return

/*
   Folgende Tasten sind nur aufgeführt, um PriorDeadKey zu leeren.
   Irgendwie sieht das noch nicht schön aus. Vielleicht lässt sich dieses
   Problem irgendwie eleganter lösen...
   
   Nachtrag:
   Weil es mit Alt+Tab Probleme gab, wird hier jetzt erstmal rumgeflickschustert,
   bis eine allgemeinere Lösung gefunden wurde.
*/

*Enter::
   if (not(lernModus) or lernModus_std_Return)
   {
     send {Blind}{Enter}
     DeadKey := ""   CompKey := ""
   }
return

*Backspace::
   if (not(lernModus) or lernModus_std_Backspace)
   {
     send {Blind}{Backspace}
     DeadKey := ""   CompKey := ""
   }
return

*Del::
   if (not(lernModus) or lernModus_std_Entf)
     send {Blind}{Del}
return

*Ins::
   if (not(lernModus) or lernModus_std_Einf)
     send {Blind}{Ins}
return





/*
Auf Mod3+Tab liegt Compose.
*/

neo_tab:
   if (IsMod3Pressed()) ;#
   {
      #Include *i %a_scriptdir%\ComposeLaunch.ahk
      #Include *i %a_scriptdir%\Source\ComposeLaunch.ahk
      DeadKey := "comp"
      CompKey := ""
   }
   else
   {
      send {blind}{Tab}
      DeadKey := ""
      CompKey := ""
   }
return

*Home::
   if (not(lernModus) or lernModus_std_Pos1)
   {
     send {Blind}{Home}
     DeadKey := ""   CompKey := ""
   }
return

*End::
   if (not(lernModus) or lernModus_std_Ende)
   {
     send {Blind}{End}
     DeadKey := ""   CompKey := ""
   }
return

*PgUp::
   if (not(lernModus) or lernModus_std_PgUp)
   {
     send {Blind}{PgUp}
     DeadKey := ""   CompKey := ""
   }
return

*PgDn::
   if (not(lernModus) or lernModus_std_PgDn)
   {
     send {Blind}{PgDn}
     DeadKey := ""   CompKey := ""
   }
return

*Up::
   if (not(lernModus) or lernModus_std_Hoch)
   {
     send {Blind}{Up}
     DeadKey := ""   CompKey := ""
   }
return

*Down::
   if (not(lernModus) or lernModus_std_Runter)
   {
     send {Blind}{Down}
     DeadKey := ""   CompKey := ""
   }
return

*Left::
   if (not(lernModus) or lernModus_std_Links)
   {
     send {Blind}{Left}
     DeadKey := ""   CompKey := ""
   }
return

*Right::
   if (not(lernModus) or lernModus_std_Rechts)
   {
     send {Blind}{Right}
     DeadKey := ""   CompKey := ""
   }
return





/* 
   ------------------------------------------------------
   Methode KeyboardLED zur Steuerung der Keyboard-LEDs
   (NumLock/CapsLock/ScrollLock-Lichter)
   
   Benutzungshinweise: Man benutze
   KeyboardLED(LEDvalue,"Cmd"), wobei
   Cmd = on/off/switch,
   LEDvalue: ScrollLock=1, NumLock=2, CapsLock=4
   bzw. eine beliebige Summe dieser Werte:
   AlleAus=0, CapsLock+NumLock=6, etc.
   
   Der folgende Code wurde übernommen von:
   http://www.autohotkey.com/forum/viewtopic.php?t=10532
   
   Um eventuelle Wechselwirkungen mit dem bestehenden
   Code (insb. der Unicode-Konvertierung) auszuschießen,
   sind auch alle (Hilfsmethoden) mit dem Postfix LED
   versehen worden.
   ------------------------------------------------------
*/

KeyboardLED(LEDvalue, Cmd)  ; LEDvalue: ScrollLock=1, NumLock=2, CapsLock=4 ; Cmd = on/off/switch
{
  Static h_device
  If ! h_device ; initialise
    {
    device =\Device\KeyBoardClass0
    SetUnicodeStrLED(fn,device) 
    h_device:=NtCreateFileLED(fn,0+0x00000100+0x00000080+0x00100000,1,1,0x00000040+0x00000020,0)
    }

  VarSetCapacity( output_actual, 4, 0 )
  input_size = 4
  VarSetCapacity( input, input_size, 0 )

  If Cmd= switch  ;switches every LED according to LEDvalue
   KeyLED:= LEDvalue
  If Cmd= on  ;forces all choosen LED's to ON (LEDvalue= 0 ->LED's according to keystate)
   KeyLED:= LEDvalue | (GetKeyState("ScrollLock", "T") + 2*GetKeyState("NumLock", "T") + 4*GetKeyState("CapsLock", "T"))
  If Cmd= off  ;forces all choosen LED's to OFF (LEDvalue= 0 ->LED's according to keystate)
    {
    LEDvalue:= LEDvalue ^ 7
    KeyLED:= LEDvalue & (GetKeyState("ScrollLock", "T") + 2*GetKeyState("NumLock", "T") + 4*GetKeyState("CapsLock", "T"))
    }
  ; EncodeIntegerLED( KeyLED, 1, &input, 2 ) ;input bit pattern (KeyLED): bit 0 = scrolllock ;bit 1 = numlock ;bit 2 = capslock
  input := Chr(1) Chr(1) Chr(KeyLED)
  input := Chr(1)
  input=
  success := DllCall( "DeviceIoControl"
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

CTL_CODE_LED( p_device_type, p_function, p_method, p_access )
{
  Return, ( p_device_type << 16 ) | ( p_access << 14 ) | ( p_function << 2 ) | p_method
}


NtCreateFileLED(ByRef wfilename,desiredaccess,sharemode,createdist,flags,fattribs)
{ 
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


SetUnicodeStrLED(ByRef out, str_)
{ 
  VarSetCapacity(st1, 8, 0) 
  InsertIntegerLED(0x530025, st1) 
  VarSetCapacity(out, (StrLen(str_)+1)*2, 0) 
  DllCall("wsprintfW", "str", out, "str", st1, "str", str_, "Cdecl UInt") 
} 


ExtractIntegerLED(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4) 
; pSource is a string (buffer) whose memory area contains a raw/binary integer at pOffset. 
; The caller should pass true for pSigned to interpret the result as signed vs. unsigned. 
; pSize is the size of PSource's integer in bytes (e.g. 4 bytes for a DWORD or Int). 
; pSource must be ByRef to avoid corruption during the formal-to-actual copying process 
; (since pSource might contain valid data beyond its first binary zero). 
{ 
  Loop %pSize%  ; Build the integer by adding up its bytes. 
    result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1) 
  if (!pIsSigned OR pSize > 4 OR result < 0x80000000) 
    return result  ; Signed vs. unsigned doesn't matter in these cases. 
  ; Otherwise, convert the value (now known to be 32-bit) to its signed counterpart: 
  return -(0xFFFFFFFF - result + 1) 
} 


InsertIntegerLED(pInteger, ByRef pDest, pOffset = 0, pSize = 4) 
; The caller must ensure that pDest has sufficient capacity.  To preserve any existing contents in pDest, 
; only pSize number of bytes starting at pOffset are altered in it. 
{ 
  Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data. 
    DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF) 
}




/*
   ------------------------------------------------------
   Funktionen
   ------------------------------------------------------
*/

/*
Ebenen laut Referenz:
1. Ebene (kein Mod)      4. Ebene (Mod4)
2. Ebene (Umschalt)      5. Ebene (Umschalt+Mod3)
3. Ebene (Mod3)          6. Ebene (Mod3+Mod4)
*/

EbeneAktualisieren()
{
   global
   PriorDeadKey := DeadKey
   PriorCompKey := CompKey
   DeadKey := ""
   CompKey := ""
   Ebene12 := 0
   Modstate := IsShiftPressed() . IsMod3Pressed() . IsMod4Pressed()

   if (ahkTreiberKombi)
      if ( Modstate = "001")
         Ebene = 6      
      else
         Ebene = -1
   else 
     if      (Modstate = "000")
         Ebene = 1                 ; Ebene 1: Ohne Mod
     else if (Modstate = "100")
         Ebene = 2                 ; Ebene 2: Shift
     else if (Modstate = "010")
         Ebene = 3                 ; Ebene 3: Mod3
     else if (Modstate = "001")
         Ebene = 4                 ; Ebene 4: Mod4
     else if (Modstate = "110")
         Ebene = 5                 ; Ebene 5: Shift+Mod3
     else if (Modstate = "011")
         Ebene = 6                 ; Ebene 6: Mod3+Mod4
     else if (Modstate = "101")
         Ebene = 4                 ; Ebene 7: Shift+Mod4 impliziert Ebene 4
     else if (Modstate = "111")
         Ebene = 6                 ; Ebene 8: Shift+Mod3+Mod4 impliziert Ebene 6

   Ebene12 := ((Ebene = 1) or (Ebene = 2))

   if GetKeyState("NumLock","T")
     NumLock = 1
   else
     NumLock = 0
}



IsShiftPressed()
{
  return GetKeyState("Shift","P")
}

IsMod3Pressed()
{
   global
   if (IsMod3Locked) 
   {
       return (not ( GetKeyState("CapsLock","P") or GetKeyState("#","P") ))  ; # = SC02B
   }
   else {
      return ( GetKeyState("CapsLock","P") or GetKeyState("#","P") )  ; # = SC02B
   }
}

IsMod4Pressed()
{
   global
   if( not(einHandNeo) or not(spacepressed) )
   {
     if (IsMod4Locked) 
     {
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P")))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P"))
     }
   }
   else
   {
     if (IsMod4Locked) 
     {
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P")))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P"))
     }
   }
   
}


SendUnicodeChar(charCode)
{
   IfWinActive, ahk_class gdkWindowToplevel
   {
      StringLower, charCode, charCode
      send % "^+u" . SubStr(charCode,3) . " "
   } else {
      VarSetCapacity(ki, 28 * 2, 0)

      EncodeInteger(&ki + 0, 1)
      EncodeInteger(&ki + 6, charCode)
      EncodeInteger(&ki + 8, 4)
      EncodeInteger(&ki +28, 1)
      EncodeInteger(&ki +34, charCode)
      EncodeInteger(&ki +36, 4|2)

      DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
   }
}
/*
Über den GTK-Workaround:
Dieser basiert auf http://www.autohotkey.com/forum/topic32947.html

Der Aufruf von »SubStr(charCode,3)« geht davon aus, dass alle charCodes in Hex mit führendem „0x“ angegeben sind. Die abenteuerliche „^+u“-Konstruktion benötigt im Übrigen den Hex-Wert in Kleinschrift, was derzeit nicht bei den Zeichendefinitionen umgesetzt ist, daher zentral und weniger fehlerträchtig an dieser Stelle. Außerdem ein abschließend gesendetes Space, sonst bleibt der „eingetippte“ Unicode-Wert noch kurz sichtbar stehen, bevor er sich GTK-sei-dank in das gewünschte Zeichen verwandelt.
*/


BSSendUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

CompUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

Comp3UnicodeChar(charCode)
{
   send {bs}{bs}
   SendUnicodeChar(charCode)
}


EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}

DeadSilence = 0

deadAsc(val)
{
  global
  if (DeadSilence)
    {} ; keine Ausgabe
  else
    send % "{blind}" . val
}

deadUni(val)
{
  global
  if (DeadSilence)
    {} ; keine Ausgabe
  else
    SendUnicodeChar(val)
}

undeadAsc(val)
{
  global
  if (DeadSilence)
    send % "{blind}" . val
  else
    send % "{blind}{bs}" . val
}

undeadUni(val)
{
  global
  if (DeadSilence)
    {} ; keine ausgabe
  else
    send {bs}
  SendUnicodeChar(val)    
}

CheckDeadAsc(d,val)
{
  global
  if (PriorDeadKey == d)
  {
    undeadAsc(val)
    return 1
  }
  else
    return 0
}

CheckDeadUni(d,val)
{
  global
  if (PriorDeadKey == d)
  {
    undeadUni(val)
    return 1
  }
  else
    return 0
}

CheckDeadAsc12(d,val1,val2)
{
  global
  if (PriorDeadKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      undeadAsc(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      undeadAsc(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

CheckDeadUni12(d,val1,val2)
{
  global
  if (PriorDeadKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      undeadUni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      undeadUni(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

DeadCompose = 0

compAsc(val)
{
  global
  if (DeadCompose)
    {} ; keine Ausgabe
  else
    send % "{blind}" . val
}

compUni(val)
{
  global
  if (DeadCompose)
    {} ; keine Ausgabe
  else
    SendUnicodeChar(val)
}

uncompAsc(val)
{
  global
  if (DeadCompose)
    send % "{blind}" . val
  else
    send % "{blind}{bs}" . val
}

uncompUni(val)
{
  global
  if (DeadCompose)
    {} ; keine ausgabe
  else
    send {bs}
  SendUnicodeChar(val)    
}

uncomp3Uni(val)
{
  global
  if (DeadCompose)
    {} ; keine ausgabe
  else
    send {bs}{bs}
  SendUnicodeChar(val)    
}

CheckCompAsc(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncompAsc(val)
    return 1
  }
  else
    return 0
}

CheckCompAsc12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncompAsc(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncompAsc(val2)
      return 1
    }
    else 
      return 0
  else
    return 0
}

CheckCompUni(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncompUni(val)
    return 1
  }
  else
    return 0
}

CheckCompUni12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncompUni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncompUni(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

CheckComp3Uni(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncomp3Uni(val)
    return 1
  }
  else
    return 0
}

CheckComp3Uni12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncomp3Uni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncomp3Uni(val2)
      return 1
    }
    else
      return 0
  }
  else
    return 0
}

outputChar(val1,val2)
{
  global
  if (Ebene = 1)
    c := val1
  else
    c := val2
  send % "{blind}" . c
  if (PriorDeadKey = "comp")
    CompKey := c
}

;Tote/Untote Tasten
*F9::
  if (isMod4pressed())
    DeadSilence :=  not(DeadSilence)
  else
    send {blind}{F9}
return

;Tote/Untote Compose
*F10::
  if (isMod4pressed())
    DeadCompose :=  not(DeadCompose)
  else
    send {blind}{F10}
return

;Lang-s-Tastatur:
*F11::
  if (isMod4pressed())
    LangSTastatur := not(LangSTastatur) ; schaltet die Lang-s-Tastatur ein und aus
  else
    send {blind}{F11}
return


/*
   ------------------------------------------------------
   Methoden zum Senden von Unicode-Zeichen
   ------------------------------------------------------
*/


/************************************************************
  Alter Weg – Copy/Paste über die Zwischenablage
************************************************************/

/*
Unicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   sendplay ^v
   Clipboard := saved_clipboard
}

BSUnicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   sendplay {bs}^v
   Clipboard := saved_clipboard
}
*/


/************************************************************
  Neuer Weg – Benutzung der entsprechenden Win32-API-Methode
************************************************************/



/*
   ------------------------------------------------------
   BildschirmTastatur
   ------------------------------------------------------
*/
guiErstellt = 0
alwaysOnTop = 1

*F1::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Switch1
  else
    send {blind}{F1}
return

*F2::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Switch2
  else
    send {blind}{F2}
return

*F3::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Switch3
  else
    send {blind}{F3}
return

*F4::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Switch4
  else
    send {blind}{F4}
return

*F5::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Switch5
  else
    send {blind}{F5}
return

*F6::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Switch6
  else
    send {blind}{F6}
return

*F7::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto Show
  else
    send {blind}{F7}
return

*F8::
  if (isMod4Pressed() and zeigeBildschirmTastatur)
    goto ToggleAlwaysOnTop
  else
    send {blind}{F8}
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
 ; Ende der BildschirmTastatur


/*
   ------------------------------------------------------
   Shift+Pause "pausiert" das Script.
   ------------------------------------------------------
*/

*pause::
Suspend, Permit
   if isshiftpressed()
     goto togglesuspend
   else
     send {blind}{pause}
return

; ------------------------------------

^.::einHandNeo := not(einHandNeo)  ; Punkt
^,::lernModus := not(lernModus)    ; Komma



togglesuspend:
   if A_IsSuspended
   {
      menu, tray, rename, %enable%, %disable%
      menu, tray, tip, %name%
      if (iconBenutzen)
          menu, tray, icon, %ResourceFolder%\neo.ico,,1  
      suspend , off ; Schaltet Suspend aus -> NEO
   }
   else
   {
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
