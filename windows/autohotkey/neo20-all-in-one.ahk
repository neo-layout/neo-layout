/*
*******************************************



WICHTIGE WARNUNG:

Dies ist inzwischen eine automatisch generierte
Datei! Sie wird regelmäßig überschrieben und
sollte deshalb nicht mehr direkt bearbeitet werden!



DIE AUSFÜHRBARE DATEI AKTUALISIEREN:

Um die neo20-all-in-one.exe auf den neuesten Stand zu
bringen, reicht (wenn Autohotkey im Standardverzeichnis
installiert wurde) ein Doppelklick auf die Batch-Datei
Build-Update.bat



HINWEISE FÜR AHK-ENTWICKLER:

Anstatt dieser Datei müssen die Dateien/Module im
Source-Unterverzeichnis bearbeitet werden, etwa:
Source\Changelog-and-Todo.ahk
Source\Keys-Neo.ahk
Source\Keys-Qwert-to-Neo.ahk
Source\Methods-Layers.ahk
Source\Methods-Lights.ahk

Um die gemachten Änderungen zu testen, sollte die Datei
Source\All.ahk
verwendet werden, die alle Module einbindet und
regulär durch einen Doppelklick mit dem AHK-Interpreter
gestartet werden kann.

Der grosse Vorteil dieser Methode liegt daran, dass sich die
Zeilennummern eventueller Fehlermeldungen nicht mehr auf
die grosse "vereinigte" AHK-Datei, sondern auf die tatsäch-
lich relevanten Module beziehen, z.B.:

Error at line 64 in #include file "C:\...\autohotkey\Source\Methods-Lights.ahk"
Line Text: CTL_CODE_LED(p_device_type, p_function, p_method, p_access)
Error: Functions cannot contain functions.
The programm will exit.



AHK-LINKS

Eine kurze Einführung (Installation und Beispielscipt) findet man etwa auf
http://www.kikizas.net/en/usbapps.ahk.html

Eine alphabetische Liste aller erlaubten Kommandos findet man online unter
http://www.autohotkey.com/docs/commands.htm



*******************************************
*/

































/*
*******************************************
DU BIST GEWARNT WORDEN!
*******************************************
*/



























/*
    Titel:        NEO 2.0 beta Autohotkey-Treiber
    $Revision$
    $Date$
    Autor:        Stefan Mayer <stm (at) neo-layout.org>
    Basiert auf:  neo20-all-in-one.ahk vom 29.06.2007
        
    TODO:         - ausgiebig testen... (besonders Vollständigkeit bei Deadkeys)
                  - Bessere Lösung für das leeren von PriorDeadKey finden, damit die Sondertasten
                    nicht mehr abgefangen werden müssen.
                  - Testen ob die Capslocklösung (siehe *1:: ebene 1) auch für Numpad gebraucht wird
                  - Sind Ebenen vom Touchpad noch richtig?
                  - Die Bildschirmtastatur mit Mod4 deaktiviert den Mod4-Lock
    
    Ideen:        - Symbol ändern (Neo-Logo abwarten)
                  - bei Ebene 4 rechte Hand (Numpad) z.B. Numpad5 statt 5 senden

    CHANGEHISTORY:

                  Revision 624(von Martin Roppelt):
                  - Lang-s-Tastatur (ein- und auszuschalten durch Mod4+ß)
                  Revision 616 (von Dennis Heidsiek):
                  - Der nicht funktionierende Mod5-Lock-Fix wurde wieder entfernt, da
                    er sogar neue Fehler produzierte.
                  Revision 615 (von Dennis Heidsiek):
                  - Erfolgloser Versuch, den Mod4-Lock wiederherzustellen
                    (durch eine Tilde vor den Scancodes der Bildschirmtastatur).
                  - Rechtschreibfehler korrigiert.
                  - Zwei AHK-Links eingefügt.
                  Revision 609 (von Dennis Heidsiek):
                  - Vorläufiger Abschluss der AHK-Modularisierung.
                  - Bessere Testmöglichkeit »All.ahk« für AHK-Entwickler hinzugefügt, bei der
                    sich die Zeilenangaben in Fehlermeldungen auf die tatsächlichen Module und
                    nicht auf das große »vereinigte« Skript beziehen.
                  Revision 608 (von Martin Roppelt):
                  - Rechtschreibfehler korrigiert und Dateinamen aktualisiert und sortiert.
                  Revision 590 (von Dennis Heidsiek):
                  - Erste technische Vorarbeiten zur logischen Modularisierung des viel
                    zu lange gewordenen AHK-Quellcodes.
                  - Neue Batch-Datei Build-Update.bat zur einfachen Aktualisierung der EXE-Datei
                  Revision 583 (von Dennis Heidsiek):
                  - Kleinere Korrekturen (Mod3+Numpad5, Mod5+Numpad5 und Mod3+Numpad9
                    stimmen wieder mit der Referenz überein).
                  Revision 580 (von Matthias Berg):
                  - Bildschirmtastatur jetzt mit Mod4+F* statt Strg+F*, dies deaktiviert
                    jedoch leider den Mod4-Lock
                  Revision 570 (von Matthias Berg):
                  - Hotkeys für einHandNeo und lernModus durch entsprechende ScanCodes ersetzt 
                  Revision 568 (von Matthias Berg):
                  - Sonderzeichen, Umlaute, z und y durch ScanCodes ersetzt
                    * jetzt wird auch bei eingestelltem US Layout Neo verwendet.
                      (z.B. für Chinesische InputMethodEditors)
                    * rechter Mod3 geht noch nicht bei US Layout (weder ScanCode noch "\")
                  Revision 567 (von Dennis Heidsiek):
                  - Aktivierter Mod4 Lock wird jetzt über die Rollen-LED des Keybord angezeigt
                    (analog zu CapsLock), die NUM-LED behält ihr bisheriges Verhalten
                  - Neue Option im Skript: UseMod4Light
                  Revision 561 (von Matthias Berg):
                  - Ebene 4 Tab verhält sich jetzt wie das andere Tab dank "goto neo_tab"
                  Revision 560 (von Dennis Heidsiek):
                  - Neue Option im Skript: bildschirmTastaturEinbinden bindet die PNG-Bilder der
                    Bildschirmtastur mit in die exe-Datei ein, so dass sich der Benutzer nur eine Datei
                    herunterladen muss
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
                    * Kann auch Backspace und/oder Entfernen der 4. Ebene ausschalten (gut zum Lernen richtig 
                      zu schreiben)
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
                  - Ebenen 1 bis 4 ausschalten per Umschalter siehe erste Codezeile
                     nurEbenenFuenfUndSechs = 0
                  - Mod4-Lock durch Mod4+Mod4
                  - EbenenAktualisierung neu geschrieben
                  - Ebene 6 über Mod3+Mod4
                  - Ebenen (besonders Matheebene) an Referenz angepasst
                    (allerdings kaum um Ebenen 1&2 gekümmert, besonders Compose könnte noch überholt werden)
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



/******************
 Globale Schalter *
*******************
*/

; Im folgenden gilt (soweit nicht anders angegeben) Ja = 1, Nein = 0:
ahkTreiberKombi := 0             ; Sollen Ebenen 1-4 ignoriert werden? (kann z.B. vom dll Treiber übernommen werden)
einHandNeo := 0                  ; Soll der Treiber im Einhandmodus betrieben werden?
lernModus := 0                   ; Soll der Lernmodus aktiviert werden?
bildschirmTastaturEinbinden := 1 ; Sollen die Bilder für die Bildschirmtastatur in die EXE-Datei miteingebunden werden (Nachteil: grössere Dateigrösse, Vorteil: Referenz für Anfänger stets einfach verfügbar)
UseMod4Light := 1                ; Aktivierter Mod4 Lock wird über die Rollen-LED des Keybord angezeigt (analog zu CapsLock)
LangSTastatur := 0               ; Sollen Lang-s auf s, s auf ß und ß auf M3+ß gelegt werden?

Process, Priority,, High


/*************************
 Recourcen-Verwaltung    *
**************************
*/

; Versuche zuerst, eventuell in die EXE eingebundenen Dateien zu extrahieren
FileInstall, neo.ico, neo.ico, 1
FileInstall, neo_disabled.ico, neo_disabled.ico, 1

if(bildschirmTastaturEinbinden==1) {
   FileInstall, ebene1.png, ebene1.png, 1
   FileInstall, ebene2.png, ebene2.png, 1
   FileInstall, ebene3.png, ebene3.png, 1
   FileInstall, ebene4.png, ebene4.png, 1
   FileInstall, ebene5.png, ebene5.png, 1
   FileInstall, ebene6.png, ebene6.png, 1
}

; Benutze die Dateien (soweit sie vorhanden sind)
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
   menu, tray, icon, neo.ico,,1
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

Ebene = 1
PriorDeadKey := ""


 


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


; CapsLock durch Umschalt+Umschalt
;*CapsLock::return ; Nichts machen beim Capslock release event (weil es Mod3 ist)

*#::return ; Nichts machen beim # release event (weil es Mod3 ist) ; # = SC02B

;RShift wenn vorher LShift gedrückt wurde
LShift & ~RShift::  
      if GetKeyState("CapsLock","T")
      {
         setcapslockstate, off
      }
      else
      {
         setcapslockstate, on
      }
return

;LShift wenn vorher RShift gedrückt wurde
RShift & ~LShift::
      if GetKeyState("CapsLock","T")
      {
         setcapslockstate, off
      }
      else
      {
         setcapslockstate, on
      }
return

; Mod4-Lock durch Mod4+Mod4
IsMod4Locked := 0
< & *SC138::
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
return

*SC138::
 altGrPressed := 1
return  ; Damit AltGr nicht extra etwas schickt und als stiller Modifier geht.
*SC138 up::
 altGrPressed := 0
return 

; das folgende wird seltsamerweise nicht gebraucht :) oder führt zum AltGr Bug; Umschalt+‹ (Mod4) Zeigt ‹
SC138 & *<::
      if (IsMod4Locked) 
      {
         MsgBox Mod4-Feststellung aufgebehoben
         IsMod4Locked = 0
      }
      else
      {
         MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen drücke beide Mod4 Tasten gleichzeitig 
         IsMod4Locked = 1
      }
return

 
 ; Mod3-Lock durch Mod3+Mod3
IsMod3Locked := 0
SC02B & *Capslock::  ; #
      if (IsMod3Locked) 
      {
         MsgBox Mod3-Feststellung aufgebehoben
         IsMod3Locked = 0
      }
      else
      {
         MsgBox Mod3 festgestellt: Um Mod3 wieder zu lösen drücke beide Mod3 Tasten gleichzeitig 
         IsMod3Locked = 1
      }
return


*Capslock:: return
;Capslock::MsgBox hallo
/*
Capslock & *:
      if (IsMod3Locked) 
      {
         MsgBox Mod3-Feststellung aufgebehoben
         IsMod3Locked = 0
      }
      else
      {
         MsgBox Mod3 festgestellt: Um Mod3 wieder zu lösen drücke beide Mod3 Tasten gleichzeitig 
         IsMod3Locked = 1
      }
return
*/
 
/*
;  Wird nicht mehr gebraucht weil jetzt auf b (bzw. *n::)
; KP_Decimal durch Mod4+Mod4
*<::
*SC138::
   if GetKeyState("<","P") and GetKeyState("SC138","P")
   {
      send {numpaddot}
   }
return
 
*/



/*
   ------------------------------------------------------
   QWERTZ->Neo umwandlung
   ------------------------------------------------------
*/
; Reihe 1
*SC029::goto neo_tot1  ; Zirkumflex ^
*1::goto neo_1
*2::goto neo_2
*3::goto neo_3
*4::goto neo_4
*5::goto neo_5
*6::goto neo_6
*7::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_7
     else
      {
        keypressed := 1
        goto %gespiegelt_7%
      }
return
*8::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_8
     else
      {
        keypressed := 1
        goto %gespiegelt_8%
      }
return
*9::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_9
     else
      {
        keypressed := 1
        goto %gespiegelt_9%
      }
return
*0::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_0
     else
      {
        keypressed := 1
        goto %gespiegelt_0%
      }
return
*SC00C::  ; ß
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
*SC00D::goto neo_tot2  ; Akut			
; Reihe 2
*Tab::goto neo_tab
*q::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_x
  }
  else
  {
     goto neo_q   
  }
*w::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_v
  }
  else
  {
     goto neo_w   
  }
*e::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_l
  }
  else
  {
     goto neo_e   
  }
*r::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_c
  }
  else
  {
     goto neo_r   
  }
*t::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_w
  }
  else
  {
     goto neo_t   
  }
*SC015::  ; z 
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
*u::
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
*i::
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
*o::
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
*p::
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
*SC01A:: ; ü
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
*SC01B::  ; +
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
*a::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_u
  }
  else
  {
     goto neo_a   
  }
*s::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_i
  }
  else
  {
     goto neo_s   
  }
*d::goto neo_a
  if ( not(ahkTreiberKombi) )
  {
     goto neo_a
  }
  else
  {
     goto neo_d   
  }
*f::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_e
  }
  else
  {
     goto neo_f   
  }
*g::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_o
  }
  else
  {
     goto neo_g   
  }
*h::
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
*j::
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
*k::
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
*l::
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
*SC027::  ; ö
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
*SC028::  ; ä
  if ( not(ahkTreiberKombi) )
  {
     goto neo_y
  }
  else
  {
     goto neo_ä
  }
; Reihe 4
*SC02C::  ; y
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ü
  }
  else
  {
     goto neo_y   
  }
*x::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ö
  }
  else
  {
     goto neo_x   
  }
*c::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_ä
  }
  else
  {
     goto neo_c
  }
*v::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_p
  }
  else
  {
     goto neo_v
  }
*b::
  if ( not(ahkTreiberKombi) )
  {
     goto neo_z
  }
  else
  {
     goto neo_b
  }
*n::
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
*m::
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_m
     else
      {
        keypressed := 1
        goto %gespiegelt_m%
      }
return
*SC033::  ; Komma ,
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_komma
     else
      {
        keypressed := 1
        goto %gespiegelt_komma%
      }
return
*SC034::  ; Punkt .
     if( not(einHandNeo) or not(spacepressed) )
       goto neo_punkt
     else
      {
        keypressed := 1
        goto %gespiegelt_punkt%
      }
return
*SC035::  ; Minus -
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
*NumpadDiv::goto neo_NumpadDiv
*NumpadMult::goto neo_NumpadMult
*NumpadSub::goto neo_NumpadSub
*NumpadAdd::goto neo_NumpadAdd
*NumpadEnter::goto neo_NumpadEnter
*Numpad7::goto neo_Numpad7
*Numpad8::goto neo_Numpad8
*Numpad9::goto neo_Numpad9
*Numpad4::goto neo_Numpad4
*Numpad5::goto neo_Numpad5
*Numpad6::goto neo_Numpad6
*Numpad1::goto neo_Numpad1
*Numpad2::goto neo_Numpad2
*Numpad3::goto neo_Numpad3
*Numpad0::goto neo_Numpad0
*NumpadDot::goto neo_NumpadDot
*NumpadHome::goto neo_NumpadHome
*NumpadUp::goto neo_NumpadUp
*NumpadPgUp::goto neo_NumpadPgUp
*NumpadLeft::goto neo_NumpadLeft
*NumpadClear::goto neo_NumpadClear
*NumpadRight::goto neo_NumpadRight
*NumpadEnd::goto neo_NumpadEnd
*NumpadDown::goto neo_NumpadDown
*NumpadPgDn::goto neo_NumpadPgDn
*NumpadIns::goto neo_NumpadIns
*NumpadDel::goto neo_NumpadDel



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
   if Ebene = 1
   {
      SendUnicodeChar(0x02C6) ; circumflex, tot
      PriorDeadKey := "c1"
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x02C7) ; caron, tot
      PriorDeadKey := "c2"
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x02D8) ; brevis
      PriorDeadKey := "c3"
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x00B7) ; Mittenpunkt, tot
      PriorDeadKey := "c5"
   }
   else if Ebene = 5
   {
      send -                  ; querstrich, tot
      PriorDeadKey := "c4"
   }
   else if Ebene = 6
   {
      Send .                  ; punkt darunter (colon)
      PriorDeadKey := "c6"
   }
return

neo_1:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex 1
         BSSendUnicodeChar(0x00B9)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2081)
      else if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x217A)          ; römisch xi
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x216A)          ; römisch XI
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}1
           }
           else
           {
              send 1
           }   
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
                send {blind}1
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "1"
      else if (CompKey = "r_small")
         CompKey := "r_small_1"
      else if (CompKey = "r_capital")
         CompKey := "r_capital_1"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send °
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x00B9) ; 2 Hochgestellte
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x2022) ; bullet
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x2640) ; Piktogramm weiblich
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x00AC) ; Nicht-Symbol
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_2:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x00B2)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2082)
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2171)          ; römisch ii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2161)          ; römisch II
      else if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x217B)          ; römisch xii
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x216B)          ; römisch XII
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}2
           }
           else
           {
              send 2
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
                send {blind}2
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "2"
      else
         CompKey := ""         
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x2116) ; numero
      CompKey := ""
   }
   else if Ebene = 3
   {    
      SendUnicodeChar(0x00B2) ; 2 Hochgestellte
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x2023) ; aufzaehlungspfeil
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x26A5) ; Piktogramm Zwitter
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2228) ; Logisches Oder
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_3:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x00B3)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2083)
      else if (CompKey = "1")
         CompUnicodeChar(0x2153)          ; 1/3
      else if (CompKey = "2")
         CompUnicodeChar(0x2154)          ; 2/3
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2172)          ; römisch iii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2162)          ; römisch III
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}3
           }
           else
           {
               send 3
           }    
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {           
              send {blind}3
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "3"
      else
         CompKey := ""         
   }
   else if Ebene = 2
   {
      send §
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x00B3) ; 3 Hochgestellte
      CompKey := ""
   }
   else if Ebene = 4
   { } ; leer
   else if Ebene = 5
   {
      SendUnicodeChar(0x2642) ; Piktogramm Mann
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2227) ; Logisches Und
      CompKey := ""
   }   
   PriorDeadKey := ""
return

neo_4:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2074)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2084)         
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2173)          ; römisch iv
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2163)          ; römisch IV
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}4
           }
           else
           {
              send 4
           }
               
         }
         else
         {
           if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
           {
               send {blind}4
           }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "4"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send »
      CompKey := ""
   }
    else if Ebene = 3
   {
      send ›
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send {PgUp}    ; Prev
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x2113) ; Script small L
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x22A5) ; Senkrecht
      CompKey := ""
   }   
   PriorDeadKey := ""
return

neo_5:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2075)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2085)
      else if (CompKey = "1")
         CompUnicodeChar(0x2155)          ; 1/5
      else if (CompKey = "2")
         CompUnicodeChar(0x2156)          ; 2/5
      else if (CompKey = "3")
         CompUnicodeChar(0x2157)          ; 3/5
      else if (CompKey = "4")
         CompUnicodeChar(0x2158)          ; 4/5
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2174)          ; römisch v
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2164)          ; römisch V
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}5
           }
           else
           {
              send 5
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
               send {blind}5
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "5"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send «
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ‹
      CompKey := ""
   }
   else if Ebene = 4
   { } ; leer
   else if Ebene = 5
   {
      SendUnicodeChar(0x2020) ; Kreuz (Dagger)
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2221) ; Winkel
      CompKey := ""
   }   
   PriorDeadKey := ""
return

neo_6:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2076)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2086)         
      else if (CompKey = "1")
         CompUnicodeChar(0x2159)          ; 1/6
      else if (CompKey = "5")
         CompUnicodeChar(0x215A)          ; 5/6
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2175)          ; römisch vi
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2165)          ; römisch VI
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}6
           }
           else
           {
              send 6
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
              send {blind}6
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "6"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send €
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ¢
      CompKey := ""
   }
   else if Ebene = 4
   {
      send £
      CompKey := ""
   }
   else if Ebene = 5
   {  } ; leer
   else if Ebene = 6
   {
      SendUnicodeChar(0x2225) ; parallel
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_7:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2077)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2087)
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2176)          ; römisch vii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2166)          ; römisch VII
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}7
           }
           else
           {
              send 7
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
               send {blind}7
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "7"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send $
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ¥
      CompKey := ""
   }
   else if Ebene = 4
   {
      send ¤ 
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03BA) ; greek small letter kappa
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2209) ; nicht Element von 
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_8:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2078)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2088)
      else if (CompKey = "1")
         CompUnicodeChar(0x215B)          ; 1/8
      else if (CompKey = "3")
         CompUnicodeChar(0x215C)          ; 3/8
      else if (CompKey = "5")
         CompUnicodeChar(0x215D)          ; 5/8
      else if (CompKey = "7")
         CompUnicodeChar(0x215E)          ; 7/8
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2177)          ; römisch viii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2167)          ; römisch VIII
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}8
           }
           else
           {
              send 8
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
              send {blind}8
            }   
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "8"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send „
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ‚
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send /
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x27E8) ;bra (öffnende spitze klammer)
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2204) ; es existiert nicht
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_9:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2079)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2089)
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2178)          ; römisch ix
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2168)          ; römisch IX
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}9
           }
           else
           {
              send 9
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
              send {blind}9
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "9"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send “
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ‘
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send *
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x27E9) ;ket (schließende spitze klammer)
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2226) ; nicht parallel
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_0:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2070)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2080)         
      else if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x2179)          ; römisch x
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x2169)          ; römisch X
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}0
           }
           else
           {
              send 0
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
               send {blind}0
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "0"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send ”
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ’
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send -
      CompKey := ""
   }
   else if Ebene = 5
   {  } ; leer
   else if Ebene = 6
   {
      SendUnicodeChar(0x2205) ; leere Menge
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_strich:
   EbeneAktualisieren()
   if Ebene = 1
        {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}-
           }
           else
           {
              send -
           }
               
         }
         else {
           send {blind}-   ;Bindestrich
         }
       }
   else if Ebene = 2
      SendUnicodeChar(0x2013) ; Gedankenstrich
   else if Ebene = 3
      SendUnicodeChar(0x2014) ; Englische Gedankenstrich
   else if Ebene = 4
     { } ; leer ...  SendUnicodeChar(0x254C) 
   else if Ebene = 5
      SendUnicodeChar(0x2011) ; geschützter Bindestrich
   else if Ebene = 6
      SendUnicodeChar(0x00AD) ; weicher Trennstrich
   PriorDeadKey := ""   CompKey := ""
return

neo_tot2:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {´}{space} ; akut, tot
      PriorDeadKey := "a1"
   }
   else if Ebene = 2
   {
      send ``{space}
      PriorDeadKey := "a2"
   }
   else if Ebene = 3
   {
      send ¸ ; cedilla
      PriorDeadKey := "a3"
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x02D9) ; punkt oben drüber
      PriorDeadKey := "a5"
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x02DB) ; ogonek
      PriorDeadKey := "a4"
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x02DA)  ; ring obendrauf
      PriorDeadKey := "a6"
   }
return


/*
   ------------------------------------------------------
   Reihe 2
   ------------------------------------------------------
*/

neo_x:
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}x
   else if Ebene = 2
      sendinput {blind}X
   else if Ebene = 3
      SendUnicodeChar(0x2026) ;Ellipse
   else if Ebene = 5
      SendUnicodeChar(0x03BE) ;xi
   else if Ebene = 6
      SendUnicodeChar(0x039E)  ; Xi
   PriorDeadKey := ""   CompKey := ""
return


neo_v:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c6")      ; punkt darunter 
         BSSendUnicodeChar(0x1E7F)
      else
         sendinput {blind}v
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c6")      ; punkt darunter
         BSSendUnicodeChar(0x1E7E)
      else 
         sendinput {blind}V
   }
   else if Ebene = 3
      send _
   else if Ebene = 4
      if ( not(lernModus) or (lernModus_neo_Backspace) )
      {
         Send {Backspace}
      }
      else 
      {} ; leer
   else if Ebene = 6
      SendUnicodeChar(0x2259) ; estimates
   PriorDeadKey := ""   CompKey := ""
return



neo_l:
   EbeneAktualisieren()
   if Ebene = 1
   { 
      if (PriorDeadKey = "t5")       ; Schrägstrich
         BSSendUnicodeChar(0x0142)
      else if (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x013A)
      else if (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x013E)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x013C)
      else if (PriorDeadKey = "c5")  ; Mittenpunkt
         BSSendUnicodeChar(0x0140)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E37)
      else 
         sendinput {blind}l
      if (PriorDeadKey = "comp")            ; compose
         CompKey := "l_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x0139)
      else if (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x013D)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x013B)
      else if (PriorDeadKey = "t5")  ; Schrägstrich 
         BSSendUnicodeChar(0x0141)
      else if (PriorDeadKey = "c5")  ; Mittenpunkt 
         BSSendUnicodeChar(0x013F)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E36)
      else 
         sendinput {blind}L
      if (PriorDeadKey = "comp")            ; compose
         CompKey := "l_capital"
      else CompKey := ""
   }      
   else if Ebene = 3
   {
      send [
      CompKey := ""
   }
   else if Ebene = 4
   {
      Sendinput {Blind}{Up}
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03BB) ; lambda
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x039B) ; Lambda
      CompKey := ""
   }
   PriorDeadKey := ""
return


neo_c:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0109)
      else if (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x010D)
      else if (PriorDeadKey = "a1")      ; akut
         BSSendUnicodeChar(0x0107)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x00E7)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x010B)
      else if ( (CompKey = "o_small") or (CompKey = "o_capital") )
         Send {bs}©
      else
      {         
         sendinput {blind}c      
      }
      if (PriorDeadKey = "comp")
         CompKey := "c_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x0108)
      else if (PriorDeadKey = "c2")    ; caron 
         BSSendUnicodeChar(0x010C)
      else if (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0106)
      else if (PriorDeadKey = "a3")   ; cedilla 
         BSSendUnicodeChar(0x00E6)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x010A)
      else if ( (CompKey = "o_small") or (CompKey = "o_capital") )
         Send {bs}©         
      else 
         sendinput {blind}C
      if (PriorDeadKey = "comp")
         CompKey = "c_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send ]
      CompKey := ""
   }
   else if Ebene = 4
   {
      if ( not(lernModus) or (lernModus_neo_Entf) )
      {
        Send {Del}
        CompKey := ""
      }
      else 
      {} ; leer
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03C7) ;chi
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2102)  ; C (Komplexe Zahlen)
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_w:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0175)
      else
         sendinput {blind}w
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0174)
      else
         sendinput {blind}W
   }
   else if Ebene = 3
      send {^}{space} ; untot
   else if Ebene = 4
      Send {Insert}
   else if Ebene = 5
      SendUnicodeChar(0x03C9) ; omega
   else if Ebene = 6
      SendUnicodeChar(0x03A9) ; Omega
   PriorDeadKey := ""   CompKey := ""
return

neo_k:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a3")         ; cedilla
         BSSendUnicodeChar(0x0137)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E33)
      else
         sendinput {blind}k
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a3")         ; cedilla 
         BSSendUnicodeChar(0x0136)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E32)
      else
         sendinput {blind}K
   }
   else if Ebene = 3
      sendraw !
   else if Ebene = 4
      Send ¡
   else if Ebene = 5
      SendUnicodeChar(0x03F0) ;kappa symbol (varkappa)
   else if Ebene = 6
      SendUnicodeChar(0x221A) ; Wurzel
   PriorDeadKey := ""   CompKey := ""
return

neo_h:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0125)
      else if (PriorDeadKey = "c4")   ; Querstrich 
         BSSendUnicodeChar(0x0127)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E23)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E25)
      else sendinput {blind}h
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0124)
      else if (PriorDeadKey = "c4")   ; Querstrich
         BSSendUnicodeChar(0x0126)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E22)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E24)
      else sendinput {blind}H
   }
   else if Ebene = 3
   {
      if (PriorDeadKey = "c4")    ; Querstrich
         BSSendUnicodeChar(0x2264) ; kleiner gleich
      else
         send {blind}<
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2077)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2087)
      else
         Send 7
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C8) ;psi
   else if Ebene = 6
      SendUnicodeChar(0x03A8)  ; Psi
   PriorDeadKey := ""   CompKey := ""
return

neo_g:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x011D)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x011F)
      else if (PriorDeadKey = "a3")   ; cedilla
         BSSendUnicodeChar(0x0123)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x0121)
      else sendinput {blind}g
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x011C)
      else if (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x011E)
      else if (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0122)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0120)
      else sendinput {blind}G
   }
   else if Ebene = 3
   {
      if (PriorDeadKey = "c4")    ; Querstrich
         SendUnicodeChar(0x2265) ; größer gleich
      else
         send >
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2078)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2088)
      else
         Send 8
   }
   else if Ebene = 5
      SendUnicodeChar(0x03B3) ;gamma
   else if Ebene = 6
      SendUnicodeChar(0x0393)  ; Gamma
   PriorDeadKey := ""   CompKey := ""
return

neo_f:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t5")      ; durchgestrichen
         BSSendUnicodeChar(0x0192)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E1F)
      else sendinput {blind}f
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t5")       ; durchgestrichen
         BSSendUnicodeChar(0x0191)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E1E)
      else sendinput {blind}F
   } 
   else if Ebene = 3
   {
      if (PriorDeadKey = "c1")            ; circumflex 
         BSSendUnicodeChar(0x2259)   ; entspricht
      else if (PriorDeadKey = "t1")       ; tilde 
         BSSendUnicodeChar(0x2245)   ; ungefähr gleich
      else if (PriorDeadKey = "t5")       ; Schrägstrich 
         BSSendUnicodeChar(0x2260)   ; ungleich
      else if (PriorDeadKey = "c4")       ; Querstrich
         BSSendUnicodeChar(0x2261)   ; identisch
      else if (PriorDeadKey = "c2")       ; caron 
         BSSendUnicodeChar(0x225A)   ; EQUIANGULAR TO
      else if (PriorDeadKey = "a6")       ; ring drüber 
         BSSendUnicodeChar(0x2257)   ; ring equal to
      else
         send `=
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2079)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2089)
      else
         Send 9
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C6) ; phi
   else if Ebene = 6
      SendUnicodeChar(0x03A6)  ; Phi
   PriorDeadKey := ""   CompKey := ""
return

neo_q:
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}q
   else if Ebene = 2
      sendinput {blind}Q
   else if Ebene = 3
      send {&}
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x207A)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208A)
      else
         Send {+}
   }
   else if Ebene = 5
      SendUnicodeChar(0x03D5) ; phi symbol (varphi)
   else if Ebene = 6
      SendUnicodeChar(0x211A) ; Q (rationale Zahlen)
   PriorDeadKey := ""   CompKey := ""
return

neo_sz:
   EbeneAktualisieren()
   if Ebene = 1
      if GetKeyState("CapsLock","T")
      {
         SendUnicodeChar(0x1E9E) ; verssal-ß
      }
      else
      {
         if (LangSTastatur = 1)
         {
            sendinput {blind}s
         }
         else
         {
            send ß
         }
      }
   else if Ebene = 2
      if GetKeyState("CapsLock","T")
      {
         if (LangSTastatur = 1)
         {
            sendinput {blind}s
         }
         else
         {
            send ß
         }
      }
      else
      {
         SendUnicodeChar(0x1E9E) ; versal-ß
      }
   else if Ebene = 3
   {
      if (LangSTastatur = 1)
         send ß
      else
         SendUnicodeChar(0x017F) ; langes s
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C2) ; varsigma
   else if Ebene = 6
      SendUnicodeChar(0x2218) ; Verknüpfungsoperator
   PriorDeadKey := ""   CompKey := ""
return


neo_tot3:
   EbeneAktualisieren()
   if Ebene = 1
   {
      SendUnicodeChar(0x02DC)    ; tilde, tot 
      PriorDeadKey := "t1"
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x00AF)  ; macron, tot
      PriorDeadKey := "t2"
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x00A8)   ; Diaerese
      PriorDeadKey := "t3"
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x002F)  ; Schrägstrich, tot
      PriorDeadKey := "t5"
   }
   else if Ebene = 5
   {
      send "        ;doppelakut
      PriorDeadKey := "t4"
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x02CF)  ; komma drunter, tot
      PriorDeadKey := "t6"
   }
return


/*
   ------------------------------------------------------
   Reihe 3
   ------------------------------------------------------
*/

neo_u:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")       ; circumflex
         BSSendUnicodeChar(0x00FB)
      else if (PriorDeadKey = "a1")  ; akut 
         BSSendUnicodeChar(0x00FA)
      else if (PriorDeadKey = "a2")  ; grave
         BSSendUnicodeChar(0x00F9)
      else if (PriorDeadKey = "t3")  ; Diaerese
         Send, {bs}ü
      else if (PriorDeadKey = "t4")  ; doppelakut 
         BSSendUnicodeChar(0x0171)
      else if (PriorDeadKey = "c3")  ; brevis
         BSSendUnicodeChar(0x016D)
      else if (PriorDeadKey = "t2")  ; macron
         BSSendUnicodeChar(0x016B)
      else if (PriorDeadKey = "a4")  ; ogonek
         BSSendUnicodeChar(0x0173)
      else if (PriorDeadKey = "a6")  ; Ring
         BSSendUnicodeChar(0x016F)
      else if (PriorDeadKey = "t1")  ; tilde
         BSSendUnicodeChar(0x0169)
      else if (PriorDeadKey = "c2")  ; caron
         BSSendUnicodeChar(0x01D4)
      else
         sendinput {blind}u
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00DB)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00DA)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00D9)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}Ü
      else if (PriorDeadKey = "a6")   ; Ring
         BSSendUnicodeChar(0x016E)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x016C)
      else if (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0170)
      else if (PriorDeadKey = "c2")   ; caron 
         BSSendUnicodeChar(0x01D3)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x016A)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0172)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x0168)
      else
         sendinput {blind}U
   }
   else if Ebene = 3
      send \
   else if Ebene = 4
      Send {blind}{Home}
   else if Ebene = 5    
   {  } ; leer
   else if Ebene = 6
      SendUnicodeChar(0x222E) ; contour integral
   PriorDeadKey := ""   CompKey := ""
return

neo_i:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00EE)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00ED)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00EC)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ï
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x012B)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x012D)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x012F)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x0129)
      else if (PriorDeadKey = "a5")   ; (ohne) punkt darüber 
         BSSendUnicodeChar(0x0131)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D0)
      else 
         sendinput {blind}i
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "i_small"
      else 
         CompKey := ""
   }
   else if Ebene = 2
   {   
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00CE)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00CD)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00CC)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}Ï
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x012A)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x012C)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x012E)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x0128)
      else if (PriorDeadKey = "a5")   ; punkt darüber 
         BSSendUnicodeChar(0x0130)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01CF)
      else 
         sendinput {blind}I
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "i_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send `/
      CompKey := ""
   }
   else if Ebene = 4
   {
      Sendinput {Blind}{Left}
      CompKey := ""
   }
   else if Ebene = 5    
   {
      SendUnicodeChar(0x03B9) ; iota
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x222B) ; integral
      CompKey := ""
   }
      PriorDeadKey := ""
return

neo_a:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00E2)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00E1)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00E0)
      else if (PriorDeadKey = "t3")   ; Diaerese
         send {bs}ä
      else if (PriorDeadKey = "a6")   ; Ring 
         Send {bs}å
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00E3)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0105)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0101)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x0103)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01CE)
      else
         sendinput {blind}a
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "a_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00C2)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00C1)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00C0)
      else if (PriorDeadKey = "t3")   ; Diaerese
         send {bs}Ä
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00C3)
      else if (PriorDeadKey = "a6")   ; Ring 
         Send {bs}Å
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0100)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x0102)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0104)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01CD)
      else
         sendinput {blind}A
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "a_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      sendraw {
      CompKey := ""
   }
   else if Ebene = 4
   {
      Sendinput {Blind}{Down}
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03B1) ;alpha
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2200) ;fuer alle   
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_e:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00EA)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00E9)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00E8)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ë
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0119)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0113)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x0115)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x011B)
      else if (PriorDeadKey = "a5")   ; punkt darüber 
         BSSendUnicodeChar(0x0117)
      else if (CompKey = "a_small")   ; compose
      {
         Send {bs}æ
         CompKey := ""
      }
      else if (CompKey = "o_small")   ; compose
      {
         Send {bs}œ
         CompKey := ""
      }      
      else
         sendinput {blind}e
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00CA)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00C9)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00C8)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}Ë
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x011A)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0112)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x0114)
      else if (PriorDeadKey = "a4")   ; ogonek 
         BSSendUnicodeChar(0x0118)
      else if (PriorDeadKey = "a5")   ; punkt darüber 
         BSSendUnicodeChar(0x0116)
      else if (CompKey = "a_capital") ; compose
      {
         Send {bs}Æ
         CompKey := ""
      }
      else if (CompKey = "o_capital")        ; compose
      {
         Send {bs}Œ
         CompKey := ""
      }      
      else 
         sendinput {blind}E
   }
   else if Ebene = 3
      sendraw }
   else if Ebene = 4
      Sendinput {Blind}{Right}
   else if Ebene = 5
        SendUnicodeChar(0x03B5) ;epsilon
   else if Ebene = 6
        SendUnicodeChar(0x2203) ;es existiert   
   PriorDeadKey := ""   CompKey := ""
return

neo_o:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00F4)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00F3)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00F2)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ö
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00F5)
      else if (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0151)
      else if (PriorDeadKey = "t5")   ; Schrägstrich
         BSSendUnicodeChar(0x00F8)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x014D)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x014F)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x01EB)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D2)                      
      else
         sendinput {blind}o
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "o_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00D4)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00D3)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00D2)
      else if (PriorDeadKey = "t5")   ; Schrägstrich
         BSSendUnicodeChar(0x00D8)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00D5)
      else if (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0150)
      else if (PriorDeadKey = "t3")   ; Diaerese
         send {bs}Ö
      else if (PriorDeadKey = "t2")   ; macron 
         BSSendUnicodeChar(0x014C)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x014E)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x01EA)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D1)    
      else
         sendinput {blind}O
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "o_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send *
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send {blind}{End}
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03BF) ; omicron
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2208) ; element of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_s:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x015D)
      else if (PriorDeadKey = "a1") ; akut 
         BSSendUnicodeChar(0x015B)
      else if (PriorDeadKey = "c2") ; caron
         BSSendUnicodeChar(0x0161)
      else if (PriorDeadKey = "a3") ; cedilla
         BSSendUnicodeChar(0x015F)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E61)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E63)
      else
      {
         if (LangSTastatur = 1)
         {
            if GetKeyState("CapsLock","T")
               sendinput {blind}s
            else
               SendUnicodeChar(0x017F) ; langes s
         }
         else
            sendinput {blind}s
      }
      if (PriorDeadKey = "comp")
         CompKey := "s_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x015C)
      else if (PriorDeadKey = "c2") ; caron
         BSSendUnicodeChar(0x0160)
      else if (PriorDeadKey = "a1") ; akut 
         BSSendUnicodeChar(0x015A)
      else if (PriorDeadKey = "a3") ; cedilla 
         BSSendUnicodeChar(0x015E)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E60)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E62)
      else
      {
         if GetKeyState("CapsLock","T") && (LangSTastatur = 1)
            SendUnicodeChar(0x017F)
         else 
            sendinput {blind}S
      }
      if (PriorDeadKey = "comp")
         CompKey := "s_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send ?
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send ¿
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03C3) ;sigma
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x03A3)  ; Sigma
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_n:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a1")          ; akut
         BSSendUnicodeChar(0x0144)
      else if (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x00F1)
      else if (PriorDeadKey = "c2")    ; caron
         BSSendUnicodeChar(0x0148)
      else if (PriorDeadKey = "a3")   ; cedilla
         BSSendUnicodeChar(0x0146)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E45)
      else
         sendinput {blind}n
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c2")         ; caron
         BSSendUnicodeChar(0x0147)
      else if (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x00D1)
      else if (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0143)
      else if (PriorDeadKey = "a3")   ; cedilla 
         BSSendUnicodeChar(0x0145)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E44)
      else
         sendinput {blind}N
   }
   else if Ebene = 3
      send (
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2074)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2084)
      else
         Send 4
   }
   else if Ebene = 5
      SendUnicodeChar(0x03BD) ; nu
   else if Ebene = 6
      SendUnicodeChar(0x2115) ; N (natürliche Zahlen)
   PriorDeadKey := ""   CompKey := ""
return

neo_r:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x0155)
      else if (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x0159)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x0157)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0E59)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E5B)
      else 
         sendinput {blind}r
      if (PriorDeadKey = "comp")
         CompKey := "r_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c2")          ; caron
         BSSendUnicodeChar(0x0158)
      else if (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x0154)
      else if (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0156)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E58)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E5A)
      else 
         sendinput {blind}R
      if (PriorDeadKey = "comp")
         CompKey := "r_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send )
      CompKey := ""
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2075)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2085)
      else
         Send 5
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03F1) ; rho symbol (varrho)
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x211D) ; R (reelle Zahlen)
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_t:
     EbeneAktualisieren()
     if Ebene = 1
     {
        if (PriorDeadKey = "c2")          ; caron 
           BSSendUnicodeChar(0x0165)
        else if (PriorDeadKey = "a3")    ; cedilla
           BSSendUnicodeChar(0x0163)
        else if (PriorDeadKey = "c4")   ; Querstrich
           BSSendUnicodeChar(0x0167)
        else if (PriorDeadKey = "a5")  ; punkt darüber 
           BSSendUnicodeChar(0x1E6B)
        else if (PriorDeadKey = "c6") ; punkt darunter 
           BSSendUnicodeChar(0x1E6D)
        else 
           sendinput {blind}t
        if (PriorDeadKey = "comp")
           CompKey := "t_small"
        else
           CompKey := ""
     }
     else if Ebene = 2
     {
        if (PriorDeadKey = "c2")          ; caron
           BSSendUnicodeChar(0x0164)
        else if (PriorDeadKey = "a3")    ; cedilla 
           BSSendUnicodeChar(0x0162)
        else if (PriorDeadKey = "c4")   ; Querstrich
           BSSendUnicodeChar(0x0166)
        else if (PriorDeadKey = "a5")  ; punkt darüber 
           BSSendUnicodeChar(0x1E6A)
        else if (PriorDeadKey = "c6") ; punkt darunter 
           BSSendUnicodeChar(0x1E6C)
        else 
           sendinput {blind}T
        if (PriorDeadKey = "comp")
           CompKey := "t_capital"
        else
           CompKey := ""
     }
     else if Ebene = 3
     {
        send {blind}- ; Bis
        CompKey := ""
     }
     else if Ebene = 4
     {
        if (PriorDeadKey = "c1")            ; circumflex
           BSSendUnicodeChar(0x2076)
        else if (PriorDeadKey = "c4")       ; toter -
           BSSendUnicodeChar(0x2086)
        else
           Send 6
        CompKey := ""
     }
     else if Ebene = 5
     {
        SendUnicodeChar(0x03C4) ; tau
        CompKey := ""
     }
     else if Ebene = 6
     {
        SendUnicodeChar(0x2202 ) ; partielle Ableitung
        CompKey := ""
     }
     PriorDeadKey := ""
return

neo_d:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c4")        ; Querstrich
         BSSendUnicodeChar(0x0111)
      else if (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00F0)
      else if (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x010F)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E0B)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E0D)
      else 
         sendinput {blind}d
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c4")        ; Querstrich
         BSSendUnicodeChar(0x0110)
      else if (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00D0)
      else if (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x010E)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E0A)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E0D)
      else sendinput {blind}D
   }
   else if Ebene = 3
      send :
   else if Ebene = 4
     Send `,
   else if Ebene = 5
      SendUnicodeChar(0x03B4) ;delta
   else if Ebene = 6
      SendUnicodeChar(0x0394)  ; Delta
   PriorDeadKey := ""   CompKey := ""
return

neo_y:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t3")       ; Diaerese
         Send {bs}ÿ
      else if (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00FD)
      else if (PriorDeadKey = "c1")    ; circumflex
         BSSendUnicodeChar(0x0177)
      else
         sendinput {blind}y
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x00DD)
      else if (PriorDeadKey = "t3")    ; Diaerese
         Send {bs}Ÿ
      else if (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x0176)
      else
         sendinput {blind}Y
   }
   else if Ebene = 3
      send @
   else if Ebene = 4
      Send .
   else if Ebene = 5
      SendUnicodeChar(0x03C5) ; upsilon
   else if Ebene = 6
      SendUnicodeChar(0x2207) ; nabla
   PriorDeadKey := ""   CompKey := ""
return

;SC02B (#) wird zu Mod3


/*
   ------------------------------------------------------
   Reihe 4
   ------------------------------------------------------
*/

;SC056 (<) wird zu Mod4

neo_ü:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x01D6)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x01D8)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x01DC)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01DA)
      else
         sendinput {blind}ü
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x01D5)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x01D7)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x01DB)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D9)
      else
         sendinput {blind}Ü
   }
   else if Ebene = 3
      send {blind}{#}
   else if Ebene = 4
      Send {Esc}
   else if Ebene = 5
     {} ; leer
   else if Ebene = 6
      SendUnicodeChar(0x221D) ; proportional

   PriorDeadKey := ""   CompKey := ""
return

neo_ö:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x022B)
      else
         sendinput {blind}ö
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x022A)
      else
         sendinput {blind}Ö
   }
   else if Ebene = 3
      send $
   else if Ebene = 4
      goto neo_tab
   else if Ebene = 5
       {} ;leer
   else if Ebene = 6
      SendUnicodeChar(0x2111) ; Fraktur I
   PriorDeadKey := ""   CompKey := ""
return

neo_ä:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x01DF)
      else
         sendinput {blind}ä
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x001DE)
      else
         sendinput {blind}Ä
   }
   else if Ebene = 3
      send |
   else if Ebene = 4
      Send {PgDn}    ; Next
   else if Ebene = 5
      SendUnicodeChar(0x03B7) ; eta
   else if Ebene = 6
      SendUnicodeChar(0x211C) ; altes R
   PriorDeadKey := ""   CompKey := ""
return

neo_p:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E57)
      else
         sendinput {blind}p
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E56)
      else 
         sendinput {blind}P
   }
   else if Ebene = 3
   {
      if (PriorDeadKey = "t1")    ; tilde
         BSSendUnicodeChar(0x2248)
      else
         sendraw ~
   }      
   else if Ebene = 4
        Send {Enter}
   else if Ebene = 5
      SendUnicodeChar(0x03C0) ;pi
   else if Ebene = 6
      SendUnicodeChar(0x03A0)  ; Pi
   PriorDeadKey := ""   CompKey := ""
return

neo_z:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c2")         ; caron
         BSSendUnicodeChar(0x017E)
      else if (PriorDeadKey = "a1")     ; akut
         BSSendUnicodeChar(0x017A)
      else if (PriorDeadKey = "a5") ; punkt drüber
         BSSendUnicodeChar(0x017C)
      else if (PriorDeadKey = "c6") ; punkt drunter
         BSSendUnicodeChar(0x1E93)
      else 
         sendinput {blind}z
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c2")         ; caron  
         BSSendUnicodeChar(0x017D)
      else if (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0179)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x017B)
      else if (PriorDeadKey = "c6") ; punkt drunter
         BSSendUnicodeChar(0x1E92)
      else
         sendinput {blind}Z
   }
   else if Ebene = 3
      send ``{space} ; untot
   else if Ebene = 4
     {} ; leer   
   else if Ebene = 5
      SendUnicodeChar(0x03B6) ;zeta 
   else if Ebene = 6
      SendUnicodeChar(0x2124)  ; Z (ganze Zahlen)
   PriorDeadKey := ""   CompKey := ""
return

neo_b:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E03)
      else 
         sendinput {blind}b
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E02)
      else 
         sendinput {blind}B
   }
   else if Ebene = 3
      send {blind}{+}
   else if Ebene = 4
      send :
   else if Ebene = 5
      SendUnicodeChar(0x03B2) ; beta
   else if Ebene = 6
      SendUnicodeChar(0x21D2) ; Doppel-Pfeil rechts
   PriorDeadKey := ""   CompKey := ""
return

neo_m:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E41)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E43)
      else if ( (CompKey = "t_small") or (CompKey = "t_capital") )       ; compose
         CompUnicodeChar(0x2122)          ; TM
      else if ( (CompKey = "s_small") or (CompKey = "s_capital") )       ; compose
         CompUnicodeChar(0x2120)          ; SM
      else
         sendinput {blind}m
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E40)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E42)
      else if ( (CompKey = "t_capital") or (CompKey = "t_small") )       ; compose
         CompUnicodeChar(0x2122)          ; TM
      else if ( (CompKey = "s_capital") or (CompKey = "s_small") )       ; compose
         CompUnicodeChar(0x2120)          ; SM
      else 
         sendinput {blind}M
   }
   else if Ebene = 3
      send `%
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B9)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2081)
      else
         Send 1
   }
   else if Ebene = 5
      SendUnicodeChar(0x03BC) ; griechisch mu, micro wäre 0x00B5
   else if Ebene = 6
      SendUnicodeChar(0x21D4) ; doppelter Doppelpfeil (genau dann wenn)
   PriorDeadKey := ""   CompKey := ""
return

neo_komma:
   EbeneAktualisieren()
   if Ebene = 1
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind},
           }
           else
           {
              send `,
           }
               
         }
         else
         {
           send {blind},
         }
       }
   else if Ebene = 2
       SendUnicodeChar(0x22EE) ;  vertikale ellipse 
   else if Ebene = 3
      send "
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B2)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2082)
      else
         Send 2
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C1) ; rho
   else if Ebene = 6
      SendUnicodeChar(0x21D0) ; Doppelpfeil links
   PriorDeadKey := ""   CompKey := ""
return

neo_punkt:
   EbeneAktualisieren()
   if Ebene = 1
        {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}.
           }
           else
           {
              send .
           }
               
         }
         else {
           send {blind}.
         }
       }
  else if Ebene = 2
      SendUnicodeChar(0x2026)  ; ellipse
   else if Ebene = 3
      send '
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B3)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2083)
      else
         Send 3
   }
   else if Ebene = 5
      SendUnicodeChar(0x03D1) ; theta symbol (vartheta)
   else if Ebene = 6
      SendUnicodeChar(0x0398)  ; Theta
   PriorDeadKey := ""   CompKey := ""
return


neo_j:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0135)
      else if (PriorDeadKey = "c2")      ; caron
         BSSendUnicodeChar(0x01F0)
      else if (CompKey = "i_small")        ; compose
         CompUnicodeChar(0x0133)          ; ij
      else if (CompKey = "l_small")        ; compose
         CompUnicodeChar(0x01C9)          ; lj
      else if (CompKey = "l_capital")       ; compose
         CompUnicodeChar(0x01C8)          ; Lj
      else
         sendinput {blind}j
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x0134)
      else if (CompKey = "i_capital")        ; compose
         CompUnicodeChar(0x0132)          ; IJ
      else if (CompKey = "l_capital")        ; compose
         CompUnicodeChar(0x01C7)          ; LJ
      else
         sendinput {blind}J
   }
   else if Ebene = 3
      send `;
   else if Ebene = 4
     Send `;
   else if Ebene = 5
      SendUnicodeChar(0x03B8) ; theta
   else if Ebene = 6
      SendUnicodeChar(0x2261) ; identisch
   PriorDeadKey := ""   CompKey := ""
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
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadDiv}
   else if Ebene = 3
      send ÷
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2215)   ; slash
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadMult:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadMult}
   else if Ebene = 3
      send ×
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x22C5)  ; cdot
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadSub:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207B)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208B)         
      else
         send {blind}{NumpadSub}
   }
   else if Ebene = 3
      SendUnicodeChar(0x2212) ; echtes minus
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadAdd:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207A)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208A)         
      else
         send {blind}{NumpadAdd}
   }
   else if Ebene = 3
      send ±
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2213)   ; -+
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadEnter:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadEnter}      
   else if Ebene = 3
      SendUnicodeChar(0x2260) ; neq
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2248) ; approx
   PriorDeadKey := ""   CompKey := ""
return

/*
   folgende Tasten verhalten sich bei ein- und ausgeschaltetem NumLock
   unterschiedlich:

   bei NumLock ein
*/



neo_Numpad7:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad7}
      if (PriorDeadKey = "comp")
         CompKey := "Num_7"
      else
         CompKey := ""       
   }
   else if Ebene = 2
   {
      send {NumpadHome}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2195)   ; Hoch-Runter-Pfeil
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226A)  ; ll
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad8:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x215B)       ; 1/8
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x215C)       ; 3/8
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215D)       ; 5/8
      else if (CompKey = "Num_7")
         CompUnicodeChar(0x215E)       ; 7/8
      else
         send {blind}{Numpad8}
      if (PriorDeadKey = "comp")
         CompKey := "Num_8"
      else
         CompKey := "" 
   }
   else if Ebene = 2
   {
      send {NumpadUp}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2191)     ; uparrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2229)    ; intersection
      CompKey := ""
   }
   PriorDeadKey := ""   CompKey := ""
return

neo_Numpad9:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad9}
      if (PriorDeadKey = "comp")
         CompKey := "Num_9"
      else
         CompKey := "" 
   }
   else if Ebene = 2
   {
      send {NumpadPgUp}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2297) ; Tensorprodukt ; Vektor in die Ebene zeigend 
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226B)  ; gg
      CompKey := ""
   }
   PriorDeadKey := ""
return



neo_Numpad4:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BC)       ; 1/4
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x00BE)       ; 3/4
      else
         send {blind}{Numpad4}
      if (PriorDeadKey = "comp")
         CompKey := "Num_4"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadLeft}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2190)     ; leftarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2282)  ; subset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad5:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2155)       ; 1/5
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2156)       ; 2/5
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x2157)       ; 3/5
      else if (CompKey = "Num_4")
         CompUnicodeChar(0x2158)       ; 4/5
      else
         send {blind}{Numpad5}
      if (PriorDeadKey = "comp")
         CompKey := "Num_5"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadClear}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x221E) ; INFINITY
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x220B) ; enthält das Element
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad6:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2159)       ; 1/6
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215A)       ; 5/6
      else
         send {blind}{Numpad6}
      if (PriorDeadKey = "comp")
         CompKey := "Num_6"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadRight}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2192)     ; rightarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2283) ; superset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad1:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad1}
      if (PriorDeadKey = "comp")
         CompKey := "Num_1"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadEnd}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2194) ; Links-Rechts-Pfeil
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2264)   ; leq
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad2:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BD)       ; 1/2
      else
         send {blind}{Numpad2}
      if (PriorDeadKey = "comp")
         CompKey := "Num_2"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadDown}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2193)     ; downarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x222A)  ; vereinigt
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad3:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2153)       ; 1/3
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2154)       ; 2/3
      else
         send {blind}{Numpad3}
      if (PriorDeadKey = "comp")
         CompKey := "Num_3"
      else
         CompKey := ""
   }
   else if Ebene = 2
      send {NumpadPgDn}
   else if Ebene = 3
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2265)  ; geq
   PriorDeadKey := ""   CompKey := ""
return

neo_Numpad0:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad0}
      if (PriorDeadKey = "comp")
         CompKey := "Num_0"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadIns}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send `%
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send ‰ 
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadDot:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDot}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadDel}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send .
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send `,
      CompKey := ""
   }
   PriorDeadKey := ""
return

/*
   bei NumLock aus
*/

neo_NumpadHome:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadHome}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad7}
      if (PriorDeadKey = "comp")
         CompKey := "Num_7"
      else
         CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226A)  ; ll
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadUp:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadUp}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x215B)       ; 1/8
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x215C)       ; 3/8
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215D)       ; 5/8
      else if (CompKey = "Num_7")
         CompUnicodeChar(0x215E)       ; 7/8
      else
         send {Numpad8}
      if (PriorDeadKey = "comp")
         CompKey := "Num_8"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2191)     ; uparrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2229)    ; intersection
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadPgUp:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadPgUp}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad9}
      if (PriorDeadKey = "comp")
         CompKey := "Num_9"
      else
         CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {

      SendUnicodeChar(0x226B)  ; gg
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadLeft:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadLeft}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BC)       ; 1/4
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x00BE)       ; 3/4
      else
         send {Numpad4}
      if (PriorDeadKey = "comp")
         CompKey := "Num_4"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2190)     ; leftarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2282)  ; subset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadClear:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadClear}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2155)       ; 1/5
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2156)       ; 2/5
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x2157)       ; 3/5
      else if (CompKey = "Num_4")
         CompUnicodeChar(0x2158)       ; 4/5
      else
         send {Numpad5}
      if (PriorDeadKey = "comp")
         CompKey := "Num_5"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send †
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x220A) ; small element of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadRight:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadRight}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2159)       ; 1/6
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215A)       ; 5/6
      else
         send {Numpad6}
      if (PriorDeadKey = "comp")
         CompKey := "Num_6"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2192)     ; rightarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2283) ; superset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadEnd:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadEnd}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad1}
      if (PriorDeadKey = "comp")
         CompKey := "Num_1"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x21CB) ; LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2264)   ; leq
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadDown:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDown}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BD)       ; 1/2
      else
         send {Numpad2}
      if (PriorDeadKey = "comp")
         CompKey := "Num_2"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2193)     ; downarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x222A)  ; vereinigt
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadPgDn:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadPgDn}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2153)       ; 1/3
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2154)       ; 2/3
      else
         send {Numpad3}
      if (PriorDeadKey = "comp")
         CompKey := "Num_3"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON   
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2265)  ; geq
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadIns:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadIns}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad0}
      if (PriorDeadKey = "comp")
         CompKey := "Num_0"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send `%
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send ‰ 
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadDel:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDel}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadDot}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send .
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send `,
      CompKey := ""
   }
   PriorDeadKey := ""
return


/*
   ------------------------------------------------------
   Sondertasten
   ------------------------------------------------------
*/
*space::
   if (einHandNeo)
    spacepressed := 1
   else
    goto neo_SpaceUp
return

*space up::
   if (einHandNeo)
   {
     if (keypressed)
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
     if Ebene = 1
     {
        if (CompKey = "r_small_1")
           Comp3UnicodeChar(0x2170)          ; römisch i
        else if (CompKey = "r_capital_1")
           Comp3UnicodeChar(0x2160)          ; römisch I
        else
           Send {blind}{Space}
     }
     if  Ebene  =  2
        Send  {blind}{Space}
     if Ebene = 3
        Send {blind}{Space}
     if Ebene = 4
     {
        if (PriorDeadKey = "c1")            ; circumflex
           BSSendUnicodeChar(0x2070)
        else if (PriorDeadKey = "c4")       ; toter -
           BSSendUnicodeChar(0x2080)
        else
           Send 0
     }
     else if Ebene = 5
        SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
     else if Ebene = 6
        SendUnicodeChar(0x202F) ; schmales Leerzeichen
     PriorDeadKey := ""   CompKey := ""
  spacepressed := 0     
  keypressed := 0       
return

/*
*Space::
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x2170)          ; römisch i
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x2160)          ; römisch I
      else
         Send {blind}{Space}
   }
   if  Ebene  =  2
      Send  {blind}{Space}
   if Ebene = 3
      Send {blind}{Space}
   if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2070)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2080)
      else
         Send 0
   }
   else if Ebene = 5
      SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
   else if Ebene = 6
      SendUnicodeChar(0x202F) ; schmales Leerzeichen
   PriorDeadKey := ""   CompKey := ""
return
*/
/*
   Folgende Tasten sind nur aufgeführt, um PriorDeadKey zu leeren.
   Irgendwie sieht das noch nicht schön aus. Vielleicht lässt sich dieses
   Problem irgendwie eleganter lösen...
   
   Nachtrag:
   Weil es mit Alt+Tab Probleme gab, wird hier jetzt erstmal rumgeflickschustert,
   bis eine allgemeinere Lösung gefunden wurde.
*/

*Enter::
   if ( not(lernModus) or (lernModus_std_Return) )
   {
     sendinput {Blind}{Enter}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Backspace::
   if ( not(lernModus) or (lernModus_std_Backspace) )
   {
     sendinput {Blind}{Backspace}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Del::
   if ( not(lernModus) or (lernModus_std_Entf) )
   {
     sendinput {Blind}{Del}
   }
return

*Ins::
   if ( not(lernModus) or (lernModus_std_Einf) )
   {
     sendinput {Blind}{Ins}
   }
return





/*
Auf Mod3+Tab liegt Compose. AltTab funktioniert, jedoch ShiftAltTab nicht.
Wenigstens kommt es jetzt nicht mehr zu komischen Ergebnissen, wenn man Tab 
nach einem DeadKey drückt...
*/

neo_tab:
   if ( GetKeyState("SC038","P") )
   {
    Send,{Blind}{AltDown}{tab}
    
/*
     if (isShiftPressed())
     {
      Send,{ShiftDown}{AltDown}{tab}
     }
     else
     {       
;       msgbox alt+tab
        Send,{AltDown}{tab}
      ; SC038 & Tab::AltTab            ; http://de.autohotkey.com/docs/Hotkeys.htm#AltTabDetail
     }
*/
   }
   else if (IsMod3Pressed()) ;#
   {
      #Include *i %a_scriptdir%\ComposeLaunch.ahk
      #Include *i %a_scriptdir%\Source\ComposeLaunch.ahk
      PriorDeadKey := "comp"
      CompKey := ""
   }
   else
   {
      send {blind}{Tab}
      PriorDeadKey := ""
      CompKey := ""
   }
return

*SC038 up::
   PriorDeadKey := ""   CompKey := ""
   send {blind}{AltUp}
return
   
*SC038 down::                    ; LAlt, damit AltTab funktioniert
    Send,{Blind}{AltDown}
   PriorDeadKey := ""   CompKey := ""
return

*Home::
   if ( not(lernModus) or (lernModus_std_Pos1) )
   {
     sendinput {Blind}{Home}
     PriorDeadKey := ""   CompKey := ""
   }
return

*End::
   if ( not(lernModus) or (lernModus_std_Ende) )
   {
     sendinput {Blind}{End}
     PriorDeadKey := ""   CompKey := ""
   }
return

*PgUp::
   if ( not(lernModus) or (lernModus_std_PgUp) )
   {
     sendinput {Blind}{PgUp}
     PriorDeadKey := ""   CompKey := ""
   }
return

*PgDn::
   if ( not(lernModus) or (lernModus_std_PgDn) )
   {
     sendinput {Blind}{PgDn}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Up::
   if ( not(lernModus) or (lernModus_std_Hoch) )
   {
     sendinput {Blind}{Up}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Down::
   if ( not(lernModus) or (lernModus_std_Runter) )
   {
     sendinput {Blind}{Down}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Left::
   if ( not(lernModus) or (lernModus_std_Links) )
   {
     sendinput {Blind}{Left}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Right::
   if ( not(lernModus) or (lernModus_std_Rechts) )
   {
     sendinput {Blind}{Right}
     PriorDeadKey := ""   CompKey := ""
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
   if (ahkTreiberKombi)
   {
      if ( IsMod4Pressed() and not(IsShiftPressed()) and not(IsMod3Pressed()))
      {
         Ebene = 6      
      }
      else
      {
        Ebene = -1
      }  
   }
   else 
   {   
     if ( IsShiftPressed() )
     {  ; Umschalt
        if ( IsMod3Pressed() )
            { ; Umschalt UND Mod3 
            if ( IsMod4Pressed() )
            {  ; Umschalt UND Mod3 UND Mod4 
               ; Ebene 8 impliziert Ebene 6
               Ebene = 6
             }
            else
            { ; Umschald UND Mod3 NICHT Mod4
                Ebene = 5                  
            }
        }
        else 
        {  ; Umschalt NICHT Mod3
            if ( IsMod4Pressed() )
            {  ; Umschalt UND Mod4 NICHT Mod3
               ; Ebene 7 impliziert Ebene 4 
                Ebene = 4
            }
            else
            { ; Umschalt NICHT Mod3 NICHT Mod4
               Ebene = 2    
            }
         }   
     }
     else
     { ; NICHT Umschalt
        if ( IsMod3Pressed() )
        { ; Mod3 NICHT Umschalt 
           if ( IsMod4Pressed() )
           {  ; Mod3 UND Mod4 NICHT Umschalt
               Ebene = 6
           }
           else
           { ; Mod3 NICHT Mod4 NICHT Umschalt
               Ebene = 3    
           }
        }
        else 
        {  ; NICHT Umschalt NICHT Mod3
           if ( IsMod4Pressed() )
           {  ; Mod4 NICHT Umschalt NICHT Mod3 
               Ebene = 4
           }
           else
           { ; NICHT Umschalt NICHT Mod3 NICHT Mod4
               Ebene = 1
           }
        }   
      }
   }
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
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or altGrPressed ))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P") or altGrPressed )
     }
   }
   else
   {
     if (IsMod4Locked) 
     {
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P")  or altGrPressed ))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P") or altGrPressed )
     }
   }
   
}


/*************************
  Alte Methoden
*************************/

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

IsModifierPressed()
{
   if (GetKeyState("LControl","P") or GetKeyState("RControl","P") or GetKeyState("LAlt","P") or GetKeyState("RAltl","P") or GetKeyState("LWin","P") or GetKeyState("RWin","P") or GetKeyState("LShift","P") or GetKeyState("RShift","P") or GetKeyState("AltGr","P") ) 
    {
       return 1
    }
    else
    {
       return 0
    }
}

SendUnicodeChar(charCode)
{
   VarSetCapacity(ki, 28 * 2, 0)

   EncodeInteger(&ki + 0, 1)
   EncodeInteger(&ki + 6, charCode)
   EncodeInteger(&ki + 8, 4)
   EncodeInteger(&ki +28, 1)
   EncodeInteger(&ki +34, charCode)
   EncodeInteger(&ki +36, 4|2)

   DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
}

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
   send {bs}
   send {bs}
   SendUnicodeChar(charCode)
}


EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}


;Lang-s-Tastatur:
{
SC056 & *Esc::
LangSTastatur := not(LangSTastatur) ; schaltet die Lang-s-Tastatur ein und aus
;if (LangSTastatur) SoundBeep ;auskommentieren, um Warnton zu erzeugen
return
}


/* 
   ------------------------------------------------------
   BildschirmTastatur
   ------------------------------------------------------
*/
guiErstellt = 0
alwaysOnTop = 1
aktuellesBild = ebene1.png 
SC056 & *F1::
SC138 & *F1::
{
  if (zeigeBildschirmTastatur)
    goto Switch1
  return
}
SC056 & *F2::
SC138 & *F2::
{
  if (zeigeBildschirmTastatur)
    goto Switch2
  return
}
SC056 & *F3::
SC138 & *F3::
{
  if (zeigeBildschirmTastatur)
    goto Switch3
  return
}
SC056 & *F4::
SC138 & *F4::
{
  if (zeigeBildschirmTastatur)
    goto Switch4
  return
}
SC056 & *F5::
SC138 & *F5::
{
  if (zeigeBildschirmTastatur)
    goto Switch5
  return
}
SC056 & *F6::
SC138 & *F6::
{
  if (zeigeBildschirmTastatur)
    goto Switch6
  return
}
SC056 & *F7::
SC138 & *F7::
{
  if (zeigeBildschirmTastatur)
    goto Show
  return
}
SC056 & *F8::
SC138 & *F8::
{
  if (zeigeBildschirmTastatur)
    goto ToggleAlwaysOnTop
  return
}
Switch1:
  if (guiErstellt) 
  {
     if (Image == "ebene1.png")
        goto Close
     else
     {
       Image = ebene1.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene1.png
    goto Show    
  }
Return

Switch2:
  if (guiErstellt) 
  {
     if (Image == "ebene2.png")
        goto Close
     else
     {
       Image = ebene2.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene2.png
    goto Show    
  }
Return

Switch3:
  if (guiErstellt) 
  {
     if (Image == "ebene3.png")
        goto Close
     else
     {
       Image = ebene3.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene3.png
    goto Show    
  }
Return

Switch4:
  if (guiErstellt) 
  {
     if (Image == "ebene4.png")
        goto Close
     else
     {
       Image = ebene4.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene4.png
    goto Show    
  }
Return

Switch5:
  if (guiErstellt) 
  {
     if (Image == "ebene5.png")
        goto Close
     else
     {
       Image = ebene5.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene5.png
    goto Show    
  }
Return

Switch6:
  if (guiErstellt) 
  {
     if (Image == "ebene6.png")
        goto Close
     else
     {
       Image = ebene6.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene6.png
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
      Image = ebene1.png 
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
    SetTimer, Refresh
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

+pause::
Suspend, Permit
   goto togglesuspend
return

; ------------------------------------

^SC034::einHandNeo := not(einHandNeo)  ; Punkt
^SC033::lernModus := not(lernModus)    ; Komma



togglesuspend:
   if A_IsSuspended
   {
      menu, tray, rename, %enable%, %disable%
      menu, tray, tip, %name%
      if (iconBenutzen)
          menu, tray, icon, neo.ico,,1  
      suspend , off ; Schaltet Suspend aus -> NEO
   }
   else
   {
      menu, tray, rename, %disable%, %enable%
      menu, tray, tip, %name% : Deaktiviert
      if (iconBenutzen)
         menu, tray, icon, neo_disabled.ico,,1
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