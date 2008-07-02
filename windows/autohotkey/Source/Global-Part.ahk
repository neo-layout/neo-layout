
/******************
 Globale Schalter *
*******************
*/

; Im folgenden gilt (soweit nicht anders angegeben) Ja = 1, Nein = 0:
ahkTreiberKombi := 0 ; Sollen Ebenen 1-4 ignoriert werden? (kann z.B. vom dll Treiber übernommen werden)
einHandNeo := 0 ; Soll der Treiber im Einhandmodus betrieben werden?
lernModus := 0 ; Soll der Lernmodus aktiviert werden?
bildschirmTastaturEinbinden := 1 ; Sollen die Bilder für die Bildschirmtastatur in die EXE-Datei miteingebunden werden (Nachteil: grössere Dateigrösse, Vorteil: Referenz für Anfanger stets einfach verfügbar)
UseMod4Light := 1 ; Aktivierter Mod4 Lock wird über die Rollen-LED des Keybord angezeigt (analog zu CapsLock)

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




