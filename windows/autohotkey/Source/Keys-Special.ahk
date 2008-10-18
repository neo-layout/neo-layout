neo_punkt:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar(".", "period")
  else if (Ebene = 2)
    SendUnicodeChar("0x2026", "ellipsis") ; Ellipse
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
    SendUnicodeChar(0x22EE, "U22EE") ; vertikale Ellipse
  else if (Ebene = 3)
    OutputChar(Chr(34), "quotedbl")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B2)
                          or CheckDeadUni("c5",0x2082)))
    OutputChar("{Numpad2}", "KP_2")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C1, "Greek_rho") ; rho
  else if (Ebene = 6)
    SendUnicodeChar(0x21D0, "U21D0") ; Doppelpfeil links
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
  if (IsMod3Pressed()) { ; Compose!
    DeadKey := "comp"
    CompKey := ""
  } else {
    OutputChar("{Tab}","Tab")
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

