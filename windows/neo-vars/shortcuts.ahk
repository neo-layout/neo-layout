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
CSU0009 := "tab"
CSU001B := "esc"
CSU0020 := "space"
DNCSU005E := "{^}{space}"
DNCSU0060 := "{``}{space}"
DNCSU007D := "{}}"                 ; "{} down}" geht nicht, warum auch immer
DNCSU00B4 := "{´}{space}"
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

CSU000D := "Enter"
CSS_Esc := "Esc"
CSU0008 := "Backspace"
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
CSS_F10 := "F10"
CSS_F11 := "F11"

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

Comp := ""
