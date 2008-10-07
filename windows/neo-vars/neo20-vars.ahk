/*
CM* == 1: Await more compose chars after this sequence? 
CD*     : Replace compose sequence by this character
CPx*    : Key press for * in Ebene x
CPNx*   : Key press for numpad * in Ebene x
CS*     : shortcut to output instead of *
PP*     : repeat code for key *
PR*     : release code for key *
*/

; ein wenig COMPOSE
#Include %a_scriptdir%\en_us.ahk
#Include %a_scriptdir%\neocomp.ahk
CMSCompU002D := 1
CDSCompU002DSLeft := "U2190"
CDSCompU002DS__Up := "U2191"
CDSCompU002DSRght := "U2192"
CDSCompU002DSDown := "U2193"
CDSCompU002DSHome := "U2196"
CDSCompU002DSPgUp := "U2197"
CDSCompU002DSPgDn := "U2198"
CDSCompU002DS_End := "U2199"
CMSCompU003D := 1
CDSCompU003DSLeft := "U21D0"
CDSCompU003DS__Up := "U21D1"
CDSCompU003DSRght := "U21D2"
CDSCompU003DSDown := "U21D3"
CDSCompU003DSHome := "U21D6"
CDSCompU003DSPgUp := "U21D7"
CDSCompU003DSPgDn := "U21D8"
CDSCompU003DS_End := "U21D9"
CDSCompSComp := "U266B"
CDSCompSEntr := "U240D"
CDSCompSNEnt := "U2318"

ED(pos,e1,e2,e3,e4,e5,e6,e7="",e8="") {
  global
  if (e1 != "") 
    CP1%pos% := e1
  if (e2 != "") 
    CP2%pos% := e2
  if (e3 != "") 
    CP3%pos% := e3
  if (e4 != "") 
    CP4%pos% := e4
  if (e5 != "") 
    CP5%pos% := e5
  if (e6 != "") 
    CP6%pos% := e6
  if (e7 != "") 
    CP7%pos% := e7
  if (e8 != "") 
    CP8%pos% := e8
}

EDN(pos1,pos2,e1,e2,e3,e4,e5,e6) {
  global
  CPN%pos1% := 1
  CPN%pos2% := 1
  ED(pos1 . "N1",e1,e2,e3,e4,e5,e6)
  ED(pos2 . "N1",e1,e2,e3,e4,e5,e6)
  ;ED(pos1 . "N0",e4,e4,e3,e1,e5,e6)
  ;ED(pos2 . "N0",e4,e4,e3,e1,e5,e6)
}

ED1(pos,e1) {
 ED(pos,e1,e1,e1,e1,e1,e1)
}

/*
******************************************************
*** HIER KOMMT NEO!
******************************************************
*/
; Reihe 1
ED("VKDCSC029","TC__1","TC__2","TC__3","TC__4","TC__5","TC__6","U0302","U0306") ; circumflex
ED("VK31SC002","U0031","U00B0","U00B9","U2022","U2640","U00AC") ; 1
ED("VK32SC003","U0032","U2116","U00B2","U2023","U26A5","U2228") ; 2
ED("VK33SC004","U0033","U00A7","U00B3",""     ,"U2642","U2227") ; 3
ED("VK34SC005","U0034","U00BB","U203A","SPgUp","U2113","U22A5") ; 4
ED("VK35SC006","U0035","U00AB","U2039",""     ,"U2020","U2221") ; 5
ED("VK36SC007","U0036","U20AC","U00A2","U00A3",""     ,"U2225") ; 6
ED("VK37SC008","U0037","U0024","U00A5","U00A4","U03BA","U2209") ; 7
ED("VK38SC009","U0038","U201E","U201A","SNDiv","U27E8","U2204") ; 8
ED("VK39SC00A","U0039","U201C","U2018","SNMul","U27E9","U2226") ; 9
ED("VK30SC00B","U0030","U201D","U2019","SNSub",""     ,"U2205") ; 0
ED("VKDBSC00C","U002D","U2013","U2014",""     ,"U2011","U00AD") ; -
ED("VKDDSC00D","TA__1","TA__2","TA__3","TA__4","TA__5","TA__6") ; akut
; Reihe 2
ED("VK51SC010","U0078","U0058","U2026","U22EE","U03BE","U039E") ; x
ED("VK57SC011","U0076","U0056","U005F","SBack",""     ,"U2259") ; v
ED("VK45SC012","U006C","U004C","U005B","S__Up","U03BB","U039B") ; l
ED("VK52SC013","U0063","U0043","U005D","S_Del","U03C7","U2102") ; c
ED("VK54SC014","U0077","U0057","U005E","S_Ins","U03C9","U03A9") ; w
ED("VK5ASC015","U006B","U004B","U0021","U00A1","U03F0","U221A") ; k
ED("VK55SC016","U0068","U0048","U003C","SN__7","U03C8","U03A8") ; h
ED("VK49SC017","U0067","U0047","U003E","SN__8","U03B3","U0393") ; g
ED("VK4FSC018","U0066","U0046","U003D","SN__9","U03C6","U03A6") ; f
ED("VK50SC019","U0071","U0051","U0026","SNAdd","U03D5","U211A") ; q
ED("VKBASC01A","U00DF","U1E9E","U017F",""     ,"U03C2","U2218") ; ß
ED("VKBBSC01B","TT__1","TT__2","TT__3","TT__4","TT__5","TT__6","U0308") ; tilde
; Reihe 3
ED("VK41SC01E","U0075","U0055","U005C","SHome",""     ,"U222E") ; u
ED("VK53SC01F","U0069","U0049","U002F","SLeft","U03B9","U222B") ; i
ED("VK44SC020","U0061","U0041","U007B","SDown","U03B1","U2200") ; a
ED("VK46SC021","U0065","U0045","U007D","SRght","U03B5","U2203") ; e
ED("VK47SC022","U006F","U004F","U002A","S_End","U03BF","U2208") ; o
ED("VK48SC023","U0073","U0053","U003F","U00BF","U03C3","U03A3","U017F") ; s
ED("VK4ASC024","U006E","U004E","U0028","SN__4","U03BD","U2115") ; n
ED("VK4BSC025","U0072","U0052","U0029","SN__5","U03F1","U211D") ; r
ED("VK4CSC026","U0074","U0054","U002D","SN__6","U03C4","U2202") ; t
ED("VKC0SC027","U0064","U0044","U003A","SNDot","U03B4","U0394") ; d
ED("VKDESC028","U0079","U0059","U0040","U002E","U03C5","U2207") ; y
; Reihe 4
ED("VK59SC02C","U00FC","U00DC","U0023","S_Esc",""     ,"U221D") ; ü
ED("VK58SC02D","U00F6","U00D6","U0024","S_Tab",""     ,"U2111") ; ö
ED("VK43SC02E","U00E4","U00C4","U007C","SPgDn","U03B7","U211C") ; ä
ED("VK56SC02F","U0070","U0050","U007E","SEntr","U03C0","U03A0") ; p
ED("VK42SC030","U007A","U005A","U0060","U003B","U03B6","U2124") ; z
ED("VK4ESC031","U0062","U0042","U002B","U003A","U03B2","U21D2") ; b
ED("VK4DSC032","U006D","U004D","U0025","SN__1","U03BC","U21D4") ; m
ED("VKBCSC033","U002C","U22EE","U0022","SN__2","U03C1","U21D0") ; ,
ED("VKBESC034","U002E","U2026","U0027","SN__3","U03D1","U0398") ; .
ED("VKBDSC035","U006A","U004A","U003B","SNEnt","U03B8","U2261") ; j
; Numpad
ED("VK90SC145","U0009","U0009","U003D","U2260","U2248","U2261") ; NumLock
ED("VK6FSC135","SNDiv","SNDiv","U00F7","U2300","U2223","U2044") ; NumpadDiv
ED("VK6ASC037","SNMul","SNMul","U22C5","U2299","U00D7","U2297") ; NumpadMult
ED("VK6DSC04A","SNSub","SNSub","U2212","U2296","U2216","U2238") ; NumpadSub
ED("VK6BSC04E","SNAdd","SNAdd","U00B1","U2295","U2213","U2214") ; NumpadAdd

EDN("VK67SC047","VK24SC047","SN__7","U2714","U2195","SNHom","U230A","U2308") ; Numpad7, NumpadHome
EDN("VK68SC048","VK26SC048","SN__8","U2718","U2191","SN_Up","U2229","U22C2") ; Numpad8, NumpadUp
EDN("VK69SC049","VK21SC049","SN__9","U2020","U22D7","SNPUp","U230B","U2309") ; Numpad9, NumpadPgUp

EDN("VK64SC04B","VK25SC04B","SN__4","U2663","U2190","SN_Le","U2282","U2286") ; Numpad4, NumpadLeft
EDN("VK65SC04C","VK0CSC04C","SN__5","U20AC","U221E","SNClr","U22B6","U22B7") ; Numpad5, NumpadClear
EDN("VK66SC04D","VK27SC04D","SN__6","U00A6","U2192","SN_Ri","U2283","U2286") ; Numpad6, NumpadRight

EDN("VK61SC04F","VK23SC04F","SN__1","U2226","U2194","SNEnd","U226A","U2264") ; Numpad1, NumpadEnd
EDN("VK62SC050","VK28SC050","SN__2","U2265","U2192","SN_Dn","U222A","U22C3") ; Numpad2, NumpadDown
EDN("VK63SC051","VK22SC051","SN__3","U2660","U21CC","SNPDn","U226B","U226B") ; Numpad3, NumpadPgDn

EDN("VK60SC052","VK2DSC052","SN__0","U2423","U0025","SNIns","U2030","U25A1") ; Numpad0, NumpadIns
EDN("VK6ESC053","VK2ESC053","SNDot","U002E","U002C","SNDel","U2032","U2033") ; NumpadDot, NumpadDel


; other chars
ED("space","U0020","U0020","U0020","SN__0","U00A0","U202F")
ED("esc"  ,"U001B","U001B","U001B","PRlod","U001B","U001B")
ED("tab"  ,"U0009","U0009","SComp","U0009","U0009","U0009")
ED("F10"  ,"S_F10","S_F10","S_F10","P_VMt","S_F10","S_F10")
ED("F11"  ,"S_F11","S_F11","S_F11","PLnSt","S_F11","S_F11")
ED1("enter"    ,"SEntr")
ED1("backspace","SBack")
ED1("del"      ,"S_Del")
ED1("ins"      ,"S_Ins")
ED1("home"     ,"SHome")
ED1("end"      ,"S_End")
ED1("pgup"     ,"SPgUp")
ED1("pgdn"     ,"SPgDn")
ED1("up"       ,"S__Up")
ED1("down"     ,"SDown")
ED1("left"     ,"SLeft")
ED1("right"    ,"SRght")
ED1("numpadenter","SNEnt")

SetFormat, integer, hex
char := 0x20
loop {
  s1 := SubStr(char,3)
  if ((char < 0x80) or (char > 0x9F))
    CSU00%s1% := chr(char)
  char += 1
  if (char = 255)
    break
}
SetFormat, integer, d


CSU0009 := "tab"
CSU001B := "esc"
CSU0020 := "space"
DNCSU005E := "{^}{space}"
DNCSU0060 := "{``}{space}"
DNCSU007D := "{}}"                 ; "{} down}" geht nicht, warum auch immer
DNCSU00B4 := "{´}{space}"
CSU20AC := "€"
CSU201A := chr(130)
CSU0192 := chr(131)
CSU201E := chr(132)
CSU2026 := chr(133)
; CSU2020 := chr(134)
CSU2021 := chr(135)
CSU02C6 := chr(136)
CSU2030 := chr(137)
CSU0160 := chr(138)
CSU2039 := chr(139)
CSU0152 := chr(140)
CSU017D := chr(142)
CSU2018 := chr(145)
CSU2019 := chr(146)
CSU201C := chr(147)
CSU201D := chr(148)
CSU2022 := chr(149)
CSU2013 := chr(150)
CSU2014 := chr(151)
CSU02DC := chr(152)
CSU2122 := chr(153)
CSU0161 := chr(154)
CSU203A := chr(155)
CSU0153 := chr(156)
CSU017E := chr(158)
CSU0178 := chr(159)

CSSEntr := "Enter"
CSS_Esc := "Esc"
CSSSpce := "Space"
CSS_Tab := "Tab"
CSSBack := "Backspace"
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

#Include %a_scriptdir%\recycle.ahk

AllStar(This_HotKey) {
  global
  PhysKey := This_HotKey
  EbeneAktualisieren()
  if (SubStr(PhysKey,1,1) == "*")
    PhysKey := SubStr(PhysKey,2)
  if (SubStr(PhysKey,-2) == " up") {
    PhysKey := SubStr(PhysKey,1,StrLen(PhysKey)-3)
    IsDown := 0
  } else
    IsDown := 1
  ActKey := Transform(PhysKey)
  if (CPN%ActKey% = 1)
    ActKey := ActKey . "N" . NumLock
  if (Ebene7 and (CP7%ActKey% != ""))
    Char := CP7%ActKey%
  else if (Ebene8 and (CP8%ActKey% != ""))
    Char := CP8%ActKey%
  else
    Char := CP%Ebene%%ActKey%
  if (SubStr(Char,1,1) == "P") {
    if (IsDown == 1)
      CharProc(SubStr(Char,2))
  } else if (IsDown == 1)
    CharStarDown(PhysKey, ActKey, Char)
  else
    CharStarUp(PhysKey)
}

CharStarDown(PhysKey, ActKey, char) {
  global
  CompEntry := Comp
  if (PP%PhysKey% != "")
    Comp := PP%PhysKey%     ; resulting from key repeat
  else
    Comp := Comp . char  ; normal compositum

  tosend := ""
  PP%PhysKey% := ""
  PR%PhysKey% := ""

  if (CD%Comp% != "") {
    tosend := CD%Comp%
    PP%PhysKey% := Comp
    Comp := ""
  } else if (CM%Comp% != 1) {
    Comp := ""
    if (CompEntry == "") {
      tosend := char
      PP%PhysKey% := char
    }
  }

  if (strlen(tosend) > 5) { ; multiple chars
    PR%PhysKey% := ""
    loop {
      if (tosend == "") 
        break                ; erledigt
      CharOut(SubStr(tosend,1,5))
      tosend := SubStr(tosend,6)
    }
  } else if (tosend != "") {
    PR%PhysKey% := tosend
    CharOutDown(tosend)
  }
}

CharStarUp(PhysKey) {
  global
  if (PR%PhysKey% != "")
    CharOutUp(PR%PhysKey%)     ; resulting from key repeat

  PR%PhysKey% := ""
  PP%PhysKey% := ""
}


CharOut(char) {
  global
  if (DNCS%char% != "") {
    seq := DNCS%char% . UPCS%char%
    if GetKeyState("Shift","P") and isMod2Locked
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else if (CS%char% != "") {
    seq := "{" . CS%char% . "}"
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U20AC")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else
    SendUnicodeChar("0x" . SubStr(char,2))
}

CharOutDown(char) {
  global
  if (DNCS%char% != "") {
    seq := DNCS%char%
    if GetKeyState("Shift","P") and isMod2Locked
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else if (CS%char% != "") {
    seq := CS%char%
    seq := "{". seq . " down}"
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U20AC")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else
    SendUnicodeCharDown("0x" . SubStr(char,2))
}

CharOutUp(char) {
  global
  if (DNCS%char% != "") {
    seq := UPCS%char%
    if GetKeyState("Shift","P") and isMod2Locked
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else if (CS%char% != "") {
    seq := CS%char%
    seq := "{". seq . " up}"
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U20AC")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else
    SendUnicodeCharUp("0x" . SubStr(char,2))
}

CharProc(subroutine) {
  global
  if (subroutine == "Rlod")
    reload
  else if (subroutine == "LnSt") {
    ;Lang-s-Tastatur:
    LangSTastatur := !(LangSTastatur)
    if (LangSTastatur)
      CharProc("LnS1")
    else
      CharProc("LnS0")
  } else if (subroutine == "LnS1") {
    ED("VKBASC01A","U0073","U1E9E","U00DF",""     ,"U03C2","U2218") ; ß
    ED("VK48SC023","U017F","U0053","U003F","U00BF","U03C3","U03A3","U0073") ; s
    KeyboardLED(2,"on")
  } else if (subroutine == "LnS0") {
    ED("VKBASC01A","U00DF","U1E9E","U017F",""     ,"U03C2","U2218") ; ß
    ED("VK48SC023","U0073","U0053","U003F","U00BF","U03C3","U03A3","U017F") ; s
    KeyboardLED(2,"off")
  } else if (subroutine == "_VMt") {
    ; Belegungsvariante VM
    isVM := !(isVM)
    if (isVM)
      CharProc("_VM1")
    else
      CharProc("_VM0")
  } else if (subroutine == "_VM1") {
    ED("VK51SC010","U0079","U0059","U2026","U22EE","U03C5","U2207") ; y
    ED("VK57SC011","U006F","U004F","U005F","SBack","U03BF","U2208") ; o
    ED("VK45SC012","U0061","U0041","U005B","S__Up","U03B1","U2200") ; a
    ED("VK52SC013","U0070","U0050","U005D","S_Del","U03C0","U03A0") ; p
    ED("VK41SC01E","U0069","U0049","U005C","SHome","U03B9","U222B") ; i
    ED("VK53SC01F","U0075","U0055","U002F","SLeft",""     ,"U222E") ; u
    ED("VK44SC020","U0065","U0045","U007B","SDown","U03B5","U2203") ; e
    ED("VK46SC021","U0063","U0043","U007D","SRght","U03C7","U2102") ; c
    ED("VK47SC022","U006C","U004C","U002A","S_End","U03BB","U039B") ; l
    ED("VKDESC028","U0078","U0058","U0040","U002E","U03BE","U039E") ; x
    ED("VK56SC02F","U0076","U0056","U007E","SEntr",""     ,"U2259") ; v
  } else if (subroutine == "_VM0") {
    ED("VK51SC010","U0078","U0058","U2026","U22EE","U03BE","U039E") ; x
    ED("VK57SC011","U0076","U0056","U005F","SBack",""     ,"U2259") ; v
    ED("VK45SC012","U006C","U004C","U005B","S__Up","U03BB","U039B") ; l
    ED("VK52SC013","U0063","U0043","U005D","S_Del","U03C7","U2102") ; c
    ED("VK41SC01E","U0075","U0055","U005C","SHome",""     ,"U222E") ; u
    ED("VK53SC01F","U0069","U0049","U002F","SLeft","U03B9","U222B") ; i
    ED("VK44SC020","U0061","U0041","U007B","SDown","U03B1","U2200") ; a
    ED("VK46SC021","U0065","U0045","U007D","SRght","U03B5","U2203") ; e
    ED("VK47SC022","U006F","U004F","U002A","S_End","U03BF","U2208") ; o
    ED("VKDESC028","U0079","U0059","U0040","U002E","U03C5","U2207") ; y
    ED("VK56SC02F","U0070","U0050","U007E","SEntr","U03C0","U03A0") ; p
  }
}

Transform(key) {
  global
  return key
}

