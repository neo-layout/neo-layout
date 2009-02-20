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
; DNCSU005E := "{^}{space}"
; DNCSU0060 := "{``}{space}"
; DNCSU00B4 := "{´}{space}"

CSU005E := ""
CSU0060 := ""
CSU00B4 := ""

DNCSU007D := "{}}"                 ; "{} down}" geht nicht, warum auch immer
; CSU007D := ""

/**** die meisten der folgenden Shortcuts werden von AHK zwar verarbeitet,
 **** von dort aber nur als ALT+Numpad verschickt und daher nicht für alle
 **** Programme nutzbar, also auskommentiert und als Unicode-Zeichen
 **** geschickt.
*/
CSU20AC := chr(128)   ; €
; CSU201A := chr(130) ; ‚
; CSU0192 := chr(131) ; ƒ
; CSU201E := chr(132) ; „
; CSU2026 := chr(133) ; …
; CSU2020 := chr(134) ; †
; CSU2021 := chr(135) ; ‡
; CSU02C6 := chr(136) ; ˆ
; CSU2030 := chr(137) ; ‰
; CSU0160 := chr(138) ; Š
; CSU2039 := chr(139) ; ‹
; CSU0152 := chr(140) ; Œ
; CSU017D := chr(142) ; Ž
; CSU2018 := chr(145) ; ‘
; CSU2019 := chr(146) ; ’
; CSU201C := chr(147) ; “
; CSU201D := chr(148) ; ”
; CSU2022 := chr(149) ; •
; CSU2013 := chr(150) ; –
; CSU2014 := chr(151) ; —
; CSU02DC := chr(152) ; ˜
; CSU2122 := chr(153) ; ™
; CSU0161 := chr(154) ; š
; CSU203A := chr(155) ; ›
; CSU0153 := chr(156) ; œ
; CSU017E := chr(158) ; ž
; CSU0178 := chr(159) ; Ÿ
CSU00A7 := chr(167)   ; §
CSU00B0 := chr(176)   ; °
CSU00B2 := chr(178)   ; ²
CSU00B3 := chr(179)   ; ³
; CSU00B4 := chr(180)   ; ´
CSU00B5 := chr(181)   ; µ
CSU00C4 := chr(196)   ; Ä
CSU00D6 := chr(214)   ; Ö
CSU00DC := chr(220)   ; Ü
CSU00DF := chr(223)   ; ß
CSU00E4 := chr(228)   ; ä
CSU00F6 := chr(246)   ; ö
CSU00FC := chr(252)   ; ü
CSU00FF := chr(255)   ; ÿ

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
  Für alle Zeichen, die durch Tastendrücke ohne Shift-Taste zustande kommen,
  muss eine gegebenenfalls gedrückte Shift-Taste vor dem Senden temporär
  gelöst werden. Dafür werden für sämtliche relevante Zeichen die passenden
  UNSHU.... Variablen gesetzt.
*/
; Reihe 1
UNSHU005E := 1 ; ^
UNSHU0031 := 1 ; 1
UNSHU0032 := 1 ; 2
UNSHU0033 := 1 ; 3
UNSHU0034 := 1 ; 4
UNSHU0035 := 1 ; 5
UNSHU0036 := 1 ; 6
UNSHU0037 := 1 ; 7
UNSHU0038 := 1 ; 8
UNSHU0039 := 1 ; 9
UNSHU0030 := 1 ; 0
UNSHU00DF := 1 ; ß
UNSHU00B4 := 1 ; ´
; Alphabet
UNSHU0061 := 1 ; a
UNSHU0062 := 1 ; b
UNSHU0063 := 1 ; c
UNSHU0064 := 1 ; d
UNSHU0065 := 1 ; e
UNSHU0066 := 1 ; f
UNSHU0067 := 1 ; g
UNSHU0068 := 1 ; h
UNSHU0069 := 1 ; i
UNSHU006A := 1 ; j
UNSHU006B := 1 ; k
UNSHU006C := 1 ; l
UNSHU006D := 1 ; m
UNSHU006E := 1 ; n
UNSHU006F := 1 ; o
UNSHU0070 := 1 ; p
UNSHU0071 := 1 ; q
UNSHU0072 := 1 ; r
UNSHU0073 := 1 ; s
UNSHU0074 := 1 ; t
UNSHU0075 := 1 ; u
UNSHU0076 := 1 ; v
UNSHU0077 := 1 ; w
UNSHU0078 := 1 ; x
UNSHU0079 := 1 ; y
UNSHU007A := 1 ; z
UNSHU00E4 := 1 ; ä
UNSHU00F6 := 1 ; ö
UNSHU00FC := 1 ; ü
; Rest
UNSHU002B := 1 ; +
UNSHU0023 := 1 ; #
UNSHU003C := 1 ; <
UNSHU002C := 1 ; ,
UNSHU002E := 1 ; .
UNSHU002D := 1 ; -
; AltGr
UNSHU00B2 := 1 ; ²
UNSHU00B3 := 1 ; ³
UNSHU007B := 1 ; {
UNSHU005B := 1 ; [
UNSHU005D := 1 ; ]
UNSHU007D := 1 ; }
UNSHU005C := 1 ; \
UNSHU0040 := 1 ; @
UNSHU20AC := 1 ; Euro
UNSHU007E := 1 ; ~
UNSHU007C := 1 ; |
UNSHU00B5 := 1 ; µ

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