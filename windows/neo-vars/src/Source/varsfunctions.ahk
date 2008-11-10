#NoEnv

AllStar(This_HotKey) {
  global
  PhysKey := This_HotKey
  if (SubStr(PhysKey,1,1) == "*")
    PhysKey := SubStr(PhysKey,2)
  if (SubStr(PhysKey,-2) == " up") {
    PhysKey := SubStr(PhysKey,1,StrLen(PhysKey)-3)
    IsDown := 0
  } else
    IsDown := 1
  ActKey := TransformKey(PhysKey)
  if ((striktesMod2Lock == 0) && (NOC%ActKey% == 1))
    Ebene := EbeneNC
  if (Ebene7 and (CP7%ActKey% != ""))
    Char := CP7%ActKey%
  else if (Ebene8 and (CP8%ActKey% != ""))
    Char := CP8%ActKey%
  else
    Char := CP%Ebene%%ActKey%
  if (IsPressHooked == 1) {
    if (IsDown == 1)
      PressHookProc(PressHookRoutine, PhysKey, ActKey, Char)
  } else if (IsDown == 1)
    CharStarDown(PhysKey, ActKey, Char)
  else
    CharStarUp(PhysKey)
}

CharStarDown(PhysKey, ActKey, char) {
  global
  wasNonShiftKeyPressed := 1
  if (PP%PhysKey% != "")
    CompNew := PP%PhysKey%           ; Von Tastaturwiederholung
  else
    CompNew := Comp . char           ; Hängen wir mal das neue Zeichen zum Compositum an

  if (CD%CompNew% != "") {           ; Compose hat getroffen: wird geschickt, Compose gelöscht
    tosend := CD%CompNew%
    PP%PhysKey% := CompNew
    Comp := ""
  } else if (CM%CompNew% == 1) {     ; Compose muss sich noch was merken: Jetzt noch nichts schicken.
    tosend := ""
    PP%PhysKey% := ""
    Comp := CompNew
  } else if (Comp == "") {           ; noch kein Zeichen in der Compose-Queue: Ein einzelnes Zeichen wird geschickt
    tosend := char
    PP%PhysKey% := char
  } else {                           ; Compose hat verfehlt: nichts schicken, auch aktuelles Zeichen nicht schicken
    tosend := ""
    PP%PhysKey% := ""
    Comp := ""
  }



  if (strlen(tosend) > 5) {          ; Ausgabe mehrerer Zeichen
    if (PR%PhysKey% != "") {         ; Eventuell vergessenen Key-Release aufräumen
      CharOutUp(PR%PhysKey%)
      PR%PhysKey% := ""
    }

    loop {
      if (SubStr(tosend,1,1)=="P") {
        CharProc(SubStr(tosend,2,4))
      } else {
        CharOut(SubStr(tosend,1,5))
      }
      tosend := SubStr(tosend,6)
      if (tosend == "") 
        break                ; erledigt
    }
  } else if (tosend != "") {
    if (SubStr(tosend,1,1)=="P") {
      if (PR%PhysKey% != "") {
        CharOutUp(PR%PhysKey%)
        PR%PhysKey% := ""
      }
      CharProc(SubStr(tosend,2))
    } else {
      if ((PR%PhysKey% != "") and (PR%PhysKey% != tosend))
        CharOutUp(PR%PhysKey%)
      PR%PhysKey% := tosend
      CharOutDown(tosend)
    }
  } else if (PR%PhysKey% != "") {
    CharOutUp(PR%PhysKey%)
    PR%PhysKey% := ""
  }
}

CharStarUp(PhysKey) {
  global
  if (PR%PhysKey% != "") {
    tosend := PR%PhysKey%
    PR%PhysKey% := ""
    if (SubStr(tosend,1,1)=="P")
      CharProc(SubStr(tosend,2))
    else
      CharOutUp(tosend)
  }
  PP%PhysKey% := ""
}


CharOut(char) {
  global
  if (DNCS%char% != "")
    SendBlindShiftFixed(DNCS%char% . UPCS%char%)
  else if (CS%char% != "")
    SendBlindShiftFixed("{" . CS%char% . "}")
  else
    SendUnicodeChar("0x" . SubStr(char,2))
}

CharOutDown(char) {
  global
  if (DNCS%char% != "")
    SendBlindShiftFixed(DNCS%char%)
  else if (CS%char% != "")
    SendBlindShiftFixed("{" . CS%char% . " down}")
  else
    SendUnicodeCharDown("0x" . SubStr(char,2))
}

CharOutUp(char) {
  global
  if (DNCS%char% != "") {
    if (UPCS%char% != "")
      SendBlindShiftFixed(UPCS%char%)
  } else if (CS%char% != "")
    SendBlindShiftFixed("{" . CS%char% . " up}")
  else
    SendUnicodeCharUp("0x" . SubStr(char,2))
}

SendBlindShiftFixed(theseq) {
  global
  if (UNSH%char%)
    if (IsShiftLPressed)
      if (IsShiftRPressed)
        send % "{blind}{RShift Up}{Shift Up}" . theseq . "{Shift Down}{RShift Down}"
      else
        send % "{blind}{Shift Up}" . theseq . "{Shift Down}"
    else
      if (IsShiftRPressed)
        send % "{blind}{RShift Up}" . theseq . "{RShift Down}"
      else
        send % "{blind}" . theseq
  else
    send % "{blind}" . theseq
}

CharProc(subroutine) {
  global
  if (subroutine == "_Rom") {
    ; starte groß geschriebene römische Zahlen
    IsPressHooked := 1
    PressHookRoutine := "Roman"
    RomanSum := 0
  } else if (subroutine == "_rom") {
    ; starte klein geschriebene römische Zahlen
    IsPressHooked := 1
    PressHookRoutine := "roman"
    RomanSum := 0
  } else if (subroutine == "_Uni") {
    ; starte Unicode-Hex-in-Zeichen-Umwandlung
    IsPressHooked := 1
    PressHookRoutine := "Uni"
    UniSum := ""
  } else if (subroutine == "DUni") {
    ; starte Unicode-Zeichen-in-Hex-Umwandlung
    IsPressHooked := 1
    PressHookRoutine := "DUni"
  }  else if (subroutine == "Rlod") {
    ; Neustart des AHK-Skripts
    reload
  } else if (subroutine == "LnSt") {
    ;Lang-s-Tastatur: Toggle
    LangSTastatur := !(LangSTastatur)
    if (LangSTastatur)
      CharProc("LnS1")
    else
      CharProc("LnS0")
  } else if (subroutine == "LnS1") {
    ; Lange-s-Tastatur aktivieren
    ED("VKBASC01A",1,"U0073","U1E9E","U00DF",""     ,"U03C2","U2218") ; ß
    ED("VK48SC023",1,"U017F","U0053","U003F","U00BF","U03C3","U03A3") ; s
    KeyboardLED(2,"on")
  } else if (subroutine == "LnS0") {
    ; Lange-s-Tastatur deaktivieren
    ED("VKBASC01A",1,"U00DF","U1E9E","U017F",""     ,"U03C2","U2218") ; ß
    ED("VK48SC023",1,"U0073","U0053","U003F","U00BF","U03C3","U03A3") ; s
    KeyboardLED(2,"off")
  } else if (subroutine == "_VMt") {
    ; VM-Tastaturbelegungsvariante togglen
    ; Belegungsvariante VM
    isVM := !(isVM)
    if (isVM) {
      CharProc("_VM1")
      MsgBox,Willkommen bei der NEO-VM-Belegungsvariante! Zum Deaktivieren, Mod4+F12 drücken
    } else {
      CharProc("_VM0")
      MsgBox,NEO-VM-Belegungsvariante deaktiviert
    }
  } else if (subroutine == "_VM1") {
    ; VM-Tastaturbelegungsvariante aktivieren
    ED("VK51SC010",1,"U0079","U0059","U2026","U22EE","U03C5","U2207") ; y
    ED("VK57SC011",1,"U006F","U004F","U005F","U0008","U03BF","U2208") ; o
    ED("VK45SC012",1,"U0061","U0041","U005B","S__Up","U03B1","U2200") ; a
    ED("VK52SC013",1,"U0070","U0050","U005D","S_Del","U03C0","U03A0") ; p
    ED("VK41SC01E",1,"U0069","U0049","U005C","SHome","U03B9","U222B") ; i
    ED("VK53SC01F",1,"U0075","U0055","U002F","SLeft","P_Uni","U222E") ; u
    ED("VK44SC020",1,"U0065","U0045","U007B","SDown","U03B5","U2203") ; e
    ED("VK46SC021",1,"U0063","U0043","U007D","SRght","U03C7","U2102") ; c
    ED("VK47SC022",1,"U006C","U004C","U002A","S_End","U03BB","U039B") ; l
    ED("VKDESC028",1,"U0078","U0058","U0040","U002E","U03BE","U039E") ; x
    ED("VK56SC02F",1,"U0076","U0056","U007E","U000D",""     ,"U2259") ; v
  } else if (subroutine == "_VM0") {
    ; VM-Tastaturbelegungsvariante deaktivieren
    ED("VK51SC010",1,"U0078","U0058","U2026","U22EE","U03BE","U039E") ; x
    ED("VK57SC011",1,"U0076","U0056","U005F","U0008",""     ,"U2259") ; v
    ED("VK45SC012",1,"U006C","U004C","U005B","S__Up","U03BB","U039B") ; l
    ED("VK52SC013",1,"U0063","U0043","U005D","S_Del","U03C7","U2102") ; c
    ED("VK41SC01E",1,"U0075","U0055","U005C","SHome","P_Uni","U222E") ; u
    ED("VK53SC01F",1,"U0069","U0049","U002F","SLeft","U03B9","U222B") ; i
    ED("VK44SC020",1,"U0061","U0041","U007B","SDown","U03B1","U2200") ; a
    ED("VK46SC021",1,"U0065","U0045","U007D","SRght","U03B5","U2203") ; e
    ED("VK47SC022",1,"U006F","U004F","U002A","S_End","U03BF","U2208") ; o
    ED("VKDESC028",1,"U0079","U0059","U0040","U002E","U03C5","U2207") ; y
    ED("VK56SC02F",1,"U0070","U0050","U007E","U000D","U03C0","U03A0") ; p
  } else if (subroutine == "_EHt") {
    ; Einhandmodus togglen
    einHandNeo := !(einHandNeo)
    if (einHandNeo) {
      CharProc("_EH1")
      MsgBox,Willkommen beim NEO-Einhand-Modus! Zum Deaktivieren, Mod4+F10 drücken
    } else {
      CharProc("_EH0")
      MsgBox,NEO-Einhand-Modus deaktiviert
    }
  } else if (subroutine == "_EH1") {
    ; Einhand-NEO aktivieren
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
    ED1("space","PEHSd")
    ED("EHSpace",0,"U0020","U0020","U0020","SN__0","U00A0","U202F")
  } else if (subroutine == "_EH0") {
    ; Einhand-NEO deaktivieren
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
    ED("space",0,"U0020","U0020","U0020","SN__0","U00A0","U202F")
  } else if (subroutine == "EHSd") {
    ; Space im Einhandmodus gedrückt
    EHSpacePressed := 1
    PRspace := "PEHSu"
  } else if (subroutine == "EHSu") {
    ; Space im Einhandmodus losgelassen
    if (!EHKeyPressed) {
      AllStar("*EHSpace")
      AllStar("*EHSpace up")
    }
    EHKeyPressed := 0
    EHSpacePressed := 0
  } else if (subroutine == "_LMt") {
    ; Lernmodus togglen
    lernModus := !(lernModus)
    if (lernModus) {
      CharProc("_LM1")
      MsgBox,Willkommen im NEO-Lernmodus! Zum Deaktivieren, Mod4+F9 drücken
    } else {
      CharProc("_LM0")
      MsgBox,NEO-Lernmodus deaktiviert
    }
  } else if (subroutine == "_LM1") {
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
  } else if (subroutine == "_LM0") {
    ; Lernmodus deaktivieren
    ED1("enter"    ,"U000D")
    ED1("backspace","U0008")
    ED1("pgup"     ,"SPgUp")
    ED1("pgdn"     ,"SPgDn")
    ED1("ins"      ,"S_Ins")
    ED1("del"      ,"S_Del")
    ED1("home"     ,"SHome")
    ED1("end"      ,"S_End")
    ED1("up"       ,"S__Up")
    ED1("down"     ,"SDown")
    ED1("left"     ,"SLeft")
    ED1("right"    ,"SRght")
    CP4VK57SC011 := "U0008"
    CP4VK52SC013 := "S_Del"
  }
}

PressHookProc(HookRoutine, PhysKey, ActKey, Char) {
  global
  if ((HookRoutine == "Roman") or (HookRoutine == "roman")) {
    if ((Char == "U0030") or (Char == "SN__0"))
      RomanSum := 10*RomanSum
    else if ((Char == "U0031") or (Char == "SN__1"))
      RomanSum := 10*RomanSum + 1
    else if ((Char == "U0032") or (Char == "SN__2"))
      RomanSum := 10*RomanSum + 2
    else if ((Char == "U0033") or (Char == "SN__3"))
      RomanSum := 10*RomanSum + 3
    else if ((Char == "U0034") or (Char == "SN__4"))
      RomanSum := 10*RomanSum + 4
    else if ((Char == "U0035") or (Char == "SN__5"))
      RomanSum := 10*RomanSum + 5
    else if ((Char == "U0036") or (Char == "SN__6"))
      RomanSum := 10*RomanSum + 6
    else if ((Char == "U0037") or (Char == "SN__7"))
      RomanSum := 10*RomanSum + 7
    else if ((Char == "U0038") or (Char == "SN__8"))
      RomanSum := 10*RomanSum + 8
    else if ((Char == "U0039") or (Char == "SN__9"))
      RomanSum := 10*RomanSum + 9
    else if ((Char == "U000D") or (Char == "U0020")) {
      RomanSum := mod(RomanSum,400000)
      RomanStr := ""
      RomanPos := 0
      if (HookRoutine == "Roman")
        loop {
          RomanDigit := mod(RomanSum,10)
          RomanSum := RomanSum//10
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U2160","U2169","U216D","U216F","U2182","U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U2160U2160","U2169U2169","U216DU216D","U216FU216F","U2182U2182","U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U2160U2160U2160","U2169U2169U2169","U216DU216DU216D","U216FU216FU216F","U2182U2182U2182","U2188U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U2160U2164","U2169U216C","U216DU216E","U2180U2181","U2182U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U2164","U216C","U216E","U2181","U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U2164U2160","U216CU2169","U216EU216D","U2181U2180","U2187U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U2164U2160U2160","U216CU2169U2169","U216EU216DU216D","U2181U2180U2180","U2187U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U2164U2160U2160U2160","U216CU2169U2169U2169","U216EU216DU216DU216D","U2181U2180U2180U2180","U2187U2182U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U2160U2169","U2169U216D","U216DU216F","U2180U2182","U2182U2188","") . RomanStr
          if (RomanSum == 0)
            break
          RomanPos := RomanPos + 1
        }
      else
        loop {
          RomanDigit := mod(RomanSum,10)
          RomanSum := RomanSum//10
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U2170","U2179","U217D","U217F","U2182","U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U2170U2170","U2179U2179","U217DU217D","U217FU217F","U2182U2182","U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U2170U2170U2170","U2179U2179U2179","U217DU217DU217D","U217FU217FU217F","U2182U2182U2182","U2188U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U2170U2174","U2179U217C","U217DU217E","U2180U2181","U2182U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U2174","U217C","U217E","U2181","U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U2174U2170","U217CU2179","U217EU217D","U2181U2180","U2187U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U2174U2170U2170","U217CU2179U2179","U217EU217DU217D","U2181U2180U2180","U2187U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U2174U2170U2170U2170","U217CU2179U2179U2179","U217EU217DU217DU217D","U2181U2180U2180U2180","U2187U2182U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U2178","U2179U217D","U217DU217F","U2180U2182","U2182U2188","") . RomanStr
          if (RomanSum == 0)
            break
          RomanPos := RomanPos + 1
        }
      loop {
        if (RomanStr == "") 
          break ; erledigt
        CharOut(SubStr(RomanStr,1,5))
        RomanStr := SubStr(RomanStr,6)
      }
      IsPressHooked := 0
    } else
      IsPressHooked := 0
  } else if (HookRoutine == "Uni") {
    if ((Char == "U0030") or (Char == "SN__0"))
      UniSum := UniSum . "0"
    else if ((Char == "U0031") or (Char == "SN__1"))
      UniSum := UniSum . "1"
    else if ((Char == "U0032") or (Char == "SN__2"))
      UniSum := UniSum . "2"
    else if ((Char == "U0033") or (Char == "SN__3"))
      UniSum := UniSum . "3"
    else if ((Char == "U0034") or (Char == "SN__4"))
      UniSum := UniSum . "4"
    else if ((Char == "U0035") or (Char == "SN__5"))
      UniSum := UniSum . "5"
    else if ((Char == "U0036") or (Char == "SN__6"))
      UniSum := UniSum . "6"
    else if ((Char == "U0037") or (Char == "SN__7"))
      UniSum := UniSum . "7"
    else if ((Char == "U0038") or (Char == "SN__8"))
      UniSum := UniSum . "8"
    else if ((Char == "U0039") or (Char == "SN__9"))
      UniSum := UniSum . "9"
    else if ((Char == "U0041") or (Char == "U0061"))
      UniSum := UniSum . "A"
    else if ((Char == "U0042") or (Char == "U0062"))
      UniSum := UniSum . "B"
    else if ((Char == "U0043") or (Char == "U0063"))
      UniSum := UniSum . "C"
    else if ((Char == "U0044") or (Char == "U0064"))
      UniSum := UniSum . "D"
    else if ((Char == "U0045") or (Char == "U0065"))
      UniSum := UniSum . "E"
    else if ((Char == "U0046") or (Char == "U0066"))
      UniSum := UniSum . "F"
    else if ((Char == "U000D") or (Char == "U0020")) {
      UniSum := "U" . SubStr("0000" . UniSum, -3)
      PP%PhysKey% := UniSum
      PR%PhysKey% := UniSum
      CharOutDown(UniSum)
      IsPressHooked := 0
    } else
      IsPressHooked := 0
  } else if (HookRoutine == "DUni") {
    OutStr := EncodeUni(Char)
    loop {
      if (OutStr == "") 
        break ; erledigt
      CharOut(SubStr(OutStr,1,5))
      OutStr := SubStr(OutStr,6)
    }
    IsPressHooked := 0
  } else
    IsPressHooked := 0
}

GenRomanDigit(Pos, DigitIs, DigitTest, str0, str1, str2, str3, str4, str5) {
  res := ""
  if (DigitIs == DigitTest)
    res := str%Pos%
  return res
}

EncodeUni(str) {
SetFormat, Integer, hex
;  MsgBox % Asc(SubStr(str,1,1)) . Asc(SubStr(str,2,1))
  result := ""
  loop {
    char := SubStr(str,1,1)
    str  := SubStr(str,2)
    if (asc(char) < 0x80)
      result := result . "U00" . SubStr(asc(char),3)
    else if (asc(char) < 0xC0) {
      ; error
    } else if (asc(char) < 0xE0) {
       char2 := Substr(str,1,1)
       str   := SubStr(str,2)
       if ((asc(char2) < 0x80) or (asc(char2) > 0xBF)) {
         ; error
       } else {
         result := result . "U" . SubStr("0000" . SubStr((((asc(char) & 0x1F) << 6) + (asc(char2) & 0x3F)),3),-3)
       }
    } else if (asc(char) < 0xF8) {
       char2 := SubStr(str,1,1)
       char3 := SubStr(str,2,1)
       str   := SubStr(str,3)
;       MsgBox % "chars: " . char . ", " . char2 . ", " . char3 . ", str: " . str
       if ((asc(char2) < 0x80) or (asc(char2) > 0xBF)
           or (asc(char3) < 0x80) or (asc(char3) > 0xBF)) {
         ; error
       } else {
;         MsgBox % asc(char) . asc(char2) . asc(char3)
;         MsgBox % (((asc(char) & 0x0F) << 12) + ((asc(char2) & 0x3F) << 6) + (asc(char3) & 0x3F))
         result := result . "U" . SubStr("0000" . SubStr((((asc(char) & 0x0F) << 12) + ((asc(char2) & 0x3F) << 6) + (asc(char3) & 0x3F)),3),-3)
       }
    }
    if (str == "")
      break
  }
  SetFormat, Integer, d
  StringUpper,result,result
  return result
}

TransformKey(PhysKey) {
  global
  if (einHandNeo and EHSpacePressed and (TKEH_%PhysKey% != "")) {
    EHKeyPressed := 1
    return TKEH_%PhysKey%
  }
  return PhysKey
}
