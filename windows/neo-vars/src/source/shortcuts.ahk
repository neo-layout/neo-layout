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
  CSU00%s1% := chr(char)
  char += 1
  if (char = 0x7E)
    break
}
SetFormat, integer, d

; #### weitere Shortcuts
CSU0008 := "Backspace"
CSU0009 := "tab"
CSU000D := "Enter"
CSU001B := "esc"
CSU0020 := "space"

/**** die folgenden Shortcuts ersetzen die automatische Wahl entsprechender
 **** down- und up-Sendezeichen, da die Zeichenerzeugung entweder aufwändiger
 **** ist (wie bei den diversen toten Zeichen) oder schlicht mit AHK nicht
 **** geht (wie das Key-Repeat der schließenden Klammer).
*/
DNCSU007D := "{}}"                 ; "{} down}" geht nicht, warum auch immer
; CSU007D := ""


CSSSh_L := "LShift"
CSSSh_R := "RShift"
CSSCaps := "CapsLock"
CSS_Del := "Delete"
CSS_Ins := "Insert"
CSS__Up := "Up"
CSSDown := "Down"
CSSRght := "Right"
CSSLeft := "Left"
CSSPgUp := "PgUp"
CSSPgDn := "PgDn"
CSSHome := "Home"
CSS_End := "End"
CSS__F1 := "F1"
CSS__F2 := "F2"
CSS__F3 := "F3"
CSS__F4 := "F4"
CSS__F5 := "F5"
CSS__F6 := "F6"
CSS__F7 := "F7"
CSS__F8 := "F8"
CSS__F9 := "F9"
CSS_F10 := "F10"
CSS_F11 := "F11"
CSS_F12 := "F12"

CSSN__0 := "Numpad0"
CSSN__1 := "Numpad1"
CSSN__2 := "Numpad2"
CSSN__3 := "Numpad3"

CSSN__4 := "Numpad4"
CSSN__5 := "Numpad5"
CSSN__6 := "Numpad6"

CSSN__7 := "Numpad7"
CSSN__8 := "Numpad8"
CSSN__9 := "Numpad9"

CSSNDiv := "NumpadDiv"
CSSNMul := "NumpadMult"
CSSNSub := "NumpadSub"
CSSNAdd := "NumpadAdd"
CSSNDot := "NumpadDot"
CSSNEnt := "NumpadEnter"

CSSNDel := "NumpadDel"
CSSNIns := "NumpadIns"
CSSN_Up := "NumpadUp"
CSSN_Dn := "NumpadDown"
CSSN_Ri := "NumpadRight"
CSSN_Le := "NumpadLeft"
CSSNPUp := "NumpadPgUp"
CSSNPDn := "NumpadPgDn"
CSSNHom := "NumpadHome"
CSSNEnd := "NumpadEnd"
CSSNClr := "NumpadClear"

CSSL_M2 := "LShift"
CSSR_M2 := "RShift"

/*
  Jetzt noch ein paar Verschönerungsabkürzungen
*/
CBS__M2 := "Shift+"
CBS__M3 := "Mod3+"
CBS__M4 := "Mod4+"
CBS__M5 := "Mod5=Shift+Mod3+"
CBS__M6 := "Mod6=Mod3+Mod4+"
CBS__M7 := "Mod7=Shift+Mod4+"
CBS__M8 := "Mod8=Shift+Mod3+Mod4+"

CBSComp := "Compose"
CBTAcut := "Akut"
CBTgrav := "Gravis"
CBTcedi := "Cedille"
CBTabdt := "Punkt darüber"
CBTogon := "Ogonek"
CBTcflx := "Zircumflex"
CBTcron := "Hatschek"
CBTbrve := "Breve"
CBTbldt := "Punkt darunter"
CBTtlde := "Tilde"
CBTmcrn := "Makron"
CBTdrss := "Trema"
CBTdbac := "Doppelakut"
CBTstrk := "Schrägstrich"

CBU005E := "^"
CBU0060 := "``"
CBU00B4 := "´"
CBCP1VK90SC145 := "Ntab"