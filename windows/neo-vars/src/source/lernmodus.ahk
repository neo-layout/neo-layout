; -*- encoding: utf-8 -*-

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
lernModus_neo_Backspace := 1
lernModus_neo_Entf := 1

CP3F9 := "P___LMt"
IniRead,lernModus,%ini%,Global,lernModus,0
If (lernModus)
  CharProc___LM1()


CharProc___LMt() {
  global
  ; Lernmodus togglen
  lernModus := !(lernModus)
  if (lernModus) {
    CharProc___LM1()
    if (zeigeModusBox)
      TrayTip,NEO-Lernmodus,NEO-Lernmodus wurde aktiviert. Zum Deaktivieren`, Mod3+F9 drücken.,10,1
  } else {
    CharProc___LM0()
    if (zeigeModusBox)
      TrayTip,NEO-Lernmodus,Lernmodus wurde deaktiviert.,10,1
  }
}

CharProc___LM1() {
  global
  ; Lernmodus aktivieren
  if (!lernModus_std_Return)
    ED1("enter","")
  if (!lernModus_std_Backspace)
    ED1("backspace","")
  if (!lernModus_std_PgUp)
    ED1("pgup","")
  if (!lernModus_std_PgDn)
    ED1("pgdn","")
  if (!lernModus_std_Einf)
    ED1("ins","")
  if (!lernModus_std_Entf)
    ED1("del","")
  if (!lernModus_std_Pos0)
    ED1("home","")
  if (!lernModus_std_Ende)
    ED1("end","")
  if (!lernModus_std_Hoch)
    ED1("up","")
  if (!lernModus_std_Runter)
    ED1("down","")
  if (!lernModus_std_Links)
    ED1("left","")
  if (!lernModus_std_Rechts)
    ED1("right","")
  if (!lernModus_neo_Backspace)
    CP4VK57SC011 := "" ; Ebene 4 unter v (QWERTZ: w)
  if (!lernModus_neo_Entf)
    CP4VK52SC013 := "" ; Ebene 4 unter c (QWERTZ: r)
}

CharProc___LM0() {
  global
  ; Lernmodus deaktivieren
  ED1("enter"    ,"U00000D")
  ED1("backspace","U000008")
  ED1("pgup"     ,"S__PgUp")
  ED1("pgdn"     ,"S__PgDn")
  ED1("ins"      ,"S___Ins")
  ED1("del"      ,"S___Del")
  ED1("home"     ,"S__Home")
  ED1("end"      ,"S___End")
  ED1("up"       ,"S____Up")
  ED1("down"     ,"S__Down")
  ED1("left"     ,"S__Left")
  ED1("right"    ,"S__Rght")
  CP4VK57SC011 := "U000008"
  CP4VK52SC013 := "S___Del"
}
