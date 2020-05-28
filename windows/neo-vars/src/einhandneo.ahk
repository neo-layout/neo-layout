; -*- encoding: utf-8 -*-

IniRead,einHandNeo,%ini%,Global,einHandNeo,0
If (einHandNeo)
  CharProc___EH1()

CP3F10 := "P___EHt"
CP5TAB := "P__M2LT"

CharProc___EHt() {
  global
  ; Einhandmodus togglen
  einHandNeo := !(einHandNeo)
  if (einHandNeo) {
    CharProc___EH1()
    if (zeigeModusBox)
      TrayTip,NEO-Einhandmodus,Der NEO-Einhand-Modus wurde aktiviert. Zum Deaktivieren Mod3+F10 drücken.,10,1
  } else {
    CharProc___EH0()
    if (zeigeModusBox)
      TrayTip,NEO-Einhand-Modus,Der Einhandmodus wurde deaktiviert.,10,1
  }
}

CharProc___EH1() {
  global
  ; Einhand-NEO aktivieren
  ; Funktionstasten
  TKEH_F7  := "F6"              ; F7  -> F6
  TKEH_F8  := "F5"              ; F8  -> F5
  TKEH_F9  := "F4"              ; F9  -> F4
  TKEH_F10 := "F3"              ; F10 -> F3
  TKEH_F11 := "F2"              ; F11 -> F2
  TKEH_F12 := "F1"              ; F12 -> F1
  ; Reihe 1
  TKEH_VK37SC008 := "VK36SC007" ; 7 -> 6
  TKEH_VK38SC009 := "VK35SC006" ; 8 -> 5
  TKEH_VK39SC00A := "VK34SC005" ; 9 -> 4
  TKEH_VK30SC00B := "VK33SC004" ; 0 -> 3
  TKEH_VKDBSC00C := "VK32SC003" ; ß -> 2
  TKEH_VKDDSC00D := "VK31SC002" ; tot2 -> 1
  ; Reihe 2
  TKEH_VK5ASC015 := "VK54SC014" ; k -> w
  TKEH_VK55SC016 := "VK52SC013" ; h -> c
  TKEH_VK49SC017 := "VK45SC012" ; g -> l
  TKEH_VK4FSC018 := "VK57SC011" ; f -> v
  TKEH_VK50SC019 := "VK51SC010" ; q -> x
  TKEH_VKBASC01A := "tab"       ; ß -> tab
  TKEH_VKBBSC01B := "VKDCSC029" ; tot3 -> tot1
  ; Reihe 3
  TKEH_VK48SC023 := "VK47SC022" ; s -> o
  TKEH_VK4ASC024 := "VK46SC021" ; n -> e
  TKEH_VK4BSC025 := "VK44SC020" ; r -> a
  TKEH_VK4CSC026 := "VK53SC01F" ; t -> i
  TKEH_VKC0SC027 := "VK41SC01E" ; d -> u
  ; Reihe 4
  TKEH_VK4ESC031 := "VK42SC030" ; b -> z
  TKEH_VK4DSC032 := "VK56SC02F" ; m -> p
  TKEH_VKBCSC033 := "VK43SC02E" ; , -> ä
  TKEH_VKBESC034 := "VK58SC02D" ; . -> ö
  TKEH_VKBDSC035 := "VK59SC02C" ; j -> ü
  ; Modify Space
  ED1("space","P__EHSd")
  GUISYM("P__EHSd","EH")
  ED("EHSpace",0,"U000020","U000020","U000020","S__N__0","U0000A0","U00202F")

  TransformProc    := "Einhand"
  TransformBSTProc := "Einhand"
}

CharProc___EH0() {
  global
  ; Einhand-NEO deaktivieren
  ; Funktionstasten
  TKEH_F7  := ""       ; F7
  TKEH_F8  := ""       ; F8
  TKEH_F9  := ""       ; F9
  TKEH_F10 := ""       ; F10
  TKEH_F11 := ""       ; F11
  TKEH_F12 := ""       ; F12
  ; Reihe 1
  TKEH_VK37SC008 := "" ; 7
  TKEH_VK38SC009 := "" ; 8
  TKEH_VK39SC00A := "" ; 9
  TKEH_VK30SC00B := "" ; 0
  TKEH_VKDBSC00C := "" ; ß
  TKEH_VKDDSC00D := "" ; tot2
  ; Reihe 2
  TKEH_VK5ASC015 := "" ; k
  TKEH_VK55SC016 := "" ; h
  TKEH_VK49SC017 := "" ; g
  TKEH_VK4FSC018 := "" ; f
  TKEH_VK50SC019 := "" ; q
  TKEH_VKBASC01A := "" ; ß
  TKEH_VKBBSC01B := "" ; tot3
  ; Reihe 3
  TKEH_VK48SC023 := "" ; s
  TKEH_VK4ASC024 := "" ; n
  TKEH_VK4BSC025 := "" ; r
  TKEH_VK4CSC026 := "" ; t
  TKEH_VKC0SC027 := "" ; d
  ; Reihe 4
  TKEH_VK4ESC031 := "" ; b
  TKEH_VK4DSC032 := "" ; m
  TKEH_VKBCSC033 := "" ; ,
  TKEH_VKBESC034 := "" ; .
  TKEH_VKBDSC035 := "" ; j
  ED("space",0,"U000020","U000020","U000020","S__N__0","U0000A0","U00202F")
  GUISYM("P__EHSd","")

  TransformProc    := ""
  TransformBSTProc := ""
}

CharProc__EHSd() {
  global
  ; Space im Einhandmodus gedrückt
  PRspace := "P__EHSu"
  if (!EHSpacePressed) {
    EHSpacePressed := 1
    Check_BSTUpdate(1)
  }
}

CharProc__EHSu() {
  global
  ; Space im Einhandmodus losgelassen
  if (!EHKeyPressed) {
    AllStar("*EHSpace")
    AllStar("*EHSpace up")
  }
  EHKeyPressed := 0
  EHSpacePressed := 0
  Check_BSTUpdate(1)
}

CharProc__M2LT() {
  global
  ; Mod2Lock Toggle
  ToggleMod2Lock()
  %EbeneAktualisieren%()
}

TransformEinhand(PhysKey) {
  global
  if (EHSpacePressed and (TKEH_%PhysKey% != "")) {
    EHKeyPressed := 1
    return TKEH_%PhysKey%
  }
  return PhysKey
}

TransformBSTEinhand(PhysKey) {
  global
  if (EHSpacePressed and (TKEH_%PhysKey% != "")) {
    return TKEH_%PhysKey%
  }
  return PhysKey
}
