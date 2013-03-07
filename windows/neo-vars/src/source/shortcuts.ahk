; -*- encoding: utf-8 -*-

/* SHORTCUTS
   Da in diesem AHK-Skript sämtliche Tastendrücke zur weiteren Verarbeitung
   in Unicode- und Spezialzeichen umgewandelt werden, müssen sie für eine
   effiziente Tasten-Ausgabe, wo möglich, zurück gewandelt werden. Dazu
   dienen Shortcuts: Soll beispielsweise das Unicode-Zeichen U0061 (kleines
   a) ausgegeben werden, muss dieses durch "send {a}" ersetzt werden. Die
   dafür notwendigen Rückwandlungskonstanten werden hier, teilweise
   automatisiert, definiert und im entsprechenden Unterprogramm zur Anwendung
   gebracht.
*/

; ###### Shortcuts für alle ASCII-Zeichen (0x21 bis 0x7E)
SetFormat, integer, hex
char := 0x21
loop {
  s1 := SubStr(char,3)
  CSU0000%s1% := chr(char)
  char += 1
  if (char = 0x7E)
    break
}
SetFormat, integer, d

; #### weitere Shortcuts
CSU000008 := "Backspace"
CSU000009 := "tab"
CSU00000D := "Enter"
CSU00001B := "esc"
CSU000020 := "space"

/**** die folgenden Shortcuts ersetzen die automatische Wahl entsprechender
 **** down- und up-Sendezeichen, da die Zeichenerzeugung entweder aufwändiger
 **** ist (wie bei den diversen toten Zeichen) oder schlicht mit AHK nicht
 **** geht (wie das Key-Repeat der schließenden Klammer).
*/
DNCSU00007D := "{}}"                 ; "{} down}" geht nicht, warum auch immer
; CSU00007D := ""


CSS__Sh_L := "LShift"
CSS__Sh_R := "RShift"
CSS__Caps := "CapsLock"
CSS___Del := "Delete"
CSS___Ins := "Insert"
CSS____Up := "Up"
CSS__Down := "Down"
CSS__Rght := "Right"
CSS__Left := "Left"
CSS__PgUp := "PgUp"
CSS__PgDn := "PgDn"
CSS__Home := "Home"
CSS___End := "End"
CSS____F1 := "F1"
CSS____F2 := "F2"
CSS____F3 := "F3"
CSS____F4 := "F4"
CSS____F5 := "F5"
CSS____F6 := "F6"
CSS____F7 := "F7"
CSS____F8 := "F8"
CSS____F9 := "F9"
CSS___F10 := "F10"
CSS___F11 := "F11"
CSS___F12 := "F12"

CSS__N__0 := "Numpad0"
CSS__N__1 := "Numpad1"
CSS__N__2 := "Numpad2"
CSS__N__3 := "Numpad3"

CSS__N__4 := "Numpad4"
CSS__N__5 := "Numpad5"
CSS__N__6 := "Numpad6"

CSS__N__7 := "Numpad7"
CSS__N__8 := "Numpad8"
CSS__N__9 := "Numpad9"

CSS__NDiv := "NumpadDiv"
CSS__NMul := "NumpadMult"
CSS__NSub := "NumpadSub"
CSS__NAdd := "NumpadAdd"
CSS__NDot := "NumpadDot"
CSS__NEnt := "NumpadEnter"

CSS__NDel := "NumpadDel"
CSS__NIns := "NumpadIns"
CSS__N_Up := "NumpadUp"
CSS__N_Dn := "NumpadDown"
CSS__N_Ri := "NumpadRight"
CSS__N_Le := "NumpadLeft"
CSS__NPUp := "NumpadPgUp"
CSS__NPDn := "NumpadPgDn"
CSS__NHom := "NumpadHome"
CSS__NEnd := "NumpadEnd"
CSS__NClr := "NumpadClear"

; Numpad Navigation + Shift
CSS_SNDel := "NumpadDel"
CSS_SNIns := "NumpadIns"
CSS_SN_Up := "NumpadUp"
CSS_SN_Dn := "NumpadDown"
CSS_SN_Ri := "NumpadRight"
CSS_SN_Le := "NumpadLeft"
CSS_SNPUp := "NumpadPgUp"
CSS_SNPDn := "NumpadPgDn"
CSS_SNHom := "NumpadHome"
CSS_SNEnd := "NumpadEnd"
CSS_SNClr := "NumpadClear"
DOSHS_SNDel := 1
DOSHS_SNIns := 1
DOSHS_SN_Up := 1
DOSHS_SN_Dn := 1
DOSHS_SN_Ri := 1
DOSHS_SN_Le := 1
DOSHS_SNPUp := 1
DOSHS_SNPDn := 1
DOSHS_SNHom := 1
DOSHS_SNEnd := 1
DOSHS_SNClr := 1

CSS__L_M2 := "LShift"
CSS__R_M2 := "RShift"

/*
  Jetzt noch ein paar Verschönerungsabkürzungen
*/
CBS____M2 := "Shift+"
CBS____M3 := "Mod3+"
CBS____M4 := "Mod4+"
CBS____M5 := "Mod5=Shift+Mod3+"
CBS____M6 := "Mod6=Mod3+Mod4+"
CBS____M7 := "Mod7=Shift+Mod4+"
CBS____M8 := "Mod8=Shift+Mod3+Mod4+"

CBS__Comp := "Compose"
CBT__Acut := "Akut"
CBT__grav := "Gravis"
CBT__cedi := "Cedille"
CBT__abdt := "Punkt darüber"
CBT__ogon := "Ogonek"
CBT__cflx := "Zircumflex"
CBT__cron := "Hatschek"
CBT__brve := "Breve"
CBT__bldt := "Punkt darunter"
CBT__tlde := "Tilde"
CBT__mcrn := "Makron"
CBT__drss := "Trema"
CBT__dbac := "Doppelakut"
CBT__strk := "Schrägstrich"

CBU00005E := "^"
CBU000060 := "``"
CBU0000B4 := "´"
CBCP1VK90SC145 := "Ntab"
