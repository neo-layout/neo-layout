; äüö

thekeys() {
;   KeyCode       Ebene1  Ebene2  Ebene3  Ebene4  Ebene5  Ebene6  Ebene7* Ebene8*
; Reihe 1
EDS("029",0,"Tcflx","Ttlde","Tobrg","Tcron","Tbrve","Tmcrn") ; circumflex
EDS("002",0,"U0031","U00B0","U00B9","U00AA","U2081","U00AC") ; 1
EDS("003",0,"U0032","U00A7","U00B2","U00BA","U2082","U2228") ; 2
EDS("004",0,"U0033","U2113","U00B3","U2116","U2083","U2227") ; 3
EDS("005",0,"U0034","U00BB","U203A","SPgUp","U2640","U22A5") ; 4
EDS("006",0,"U0035","U00AB","U2039","U00B7","U2642","U2221") ; 5
EDS("007",0,"U0036","U0024","U00A2","U00A3","U26A5","U2225") ; 6
EDS("008",0,"U0037","U20AC","U00A5","U00A4","U03BA","U2192") ; 7
EDS("009",0,"U0038","U201E","U201A",""     ,"U27E8","U221E") ; 8
EDS("00A",0,"U0039","U201C","U2018","SNDiv","U27E9","U220B") ; 9
EDS("00B",0,"U0030","U201D","U2019","SNMul","U2080","U2205") ; 0
EDS("00C",0,"U002D","U2014",""     ,"SNSub","U2011","U00AD") ; -
EDS("00D",0,"Tgrav",""     ,"Tdrss","Tdgrv","U1FFE",""     ) ; grave
; Reihe 2
EDS("010",1,"U0078","U0058","U2026","U22EE","U03BE","U039E") ; x
EDS("011",1,"U0076","U0056","U005F","U0008",""     ,"U222E") ; v
EDS("012",1,"U006C","U004C","U005B","S__Up","U03BB","U039B") ; l
EDS("013",1,"U0063","U0043","U005D","S_Del","U03C7","U2102") ; c
EDS("014",1,"U0077","U0057","U005E","S_Ins","U03C9","U03A9") ; w
EDS("015",1,"U006B","U004B","U0021","U00A1","U03F0","U221A") ; k
EDS("016",1,"U0068","U0048","U003C","SN__7","U03C8","U03A8") ; h
EDS("017",1,"U0067","U0047","U003E","SN__8","U03B3","U0393") ; g
EDS("018",1,"U0066","U0046","U003D","SN__9","U03C6","U03A6") ; f
EDS("019",1,"U0071","U0051","U0026","SNAdd","U03D5","U211A") ; q
EDS("01A",1,"U00DF","U1E9E","U017F",""     ,"U03C2","U2218") ; ß
EDS("01B",0,"Tacut","Tcedi","Tstrk","Tdbac","U1FBF","Tabdt") ; acute
; Reihe 3
EDS("01E",1,"U0075","U0055","U005C","SHome",""     ,"U00B5") ; u
EDS("01F",1,"U0069","U0049","U002F","SLeft","U03B9","U222B") ; i
EDS("020",1,"U0061","U0041","U007B","SDown","U03B1","U2200") ; a
EDS("021",1,"U0065","U0045","U007D","SRght","U03B5","U2203") ; e
EDS("022",1,"U006F","U004F","U002A","S_End","U03BF","U2208") ; o
EDS("023",1,"U0073","U0053","U003F","U00BF","U03C3","U03A3") ; s
EDS("024",1,"U006E","U004E","U0028","SN__4","U03BD","U2115") ; n
EDS("025",1,"U0072","U0052","U0029","SN__5","U03F1","U211D") ; r
EDS("026",1,"U0074","U0054","U002D","SN__6","U03C4","U2202") ; t
EDS("027",1,"U0064","U0044","U003A","SNDot","U03B4","U0394") ; d
EDS("028",1,"U0079","U0059","U0040","U002E","U03C5","U2207") ; y
; Reihe 4
EDS("02C",1,"U00FC","U00DC","U0023","U001B",""     ,"U221C") ; ü
EDS("02D",1,"U00F6","U00D6","U0024","U0009","U03F5","U2111") ; ö
EDS("02E",1,"U00E4","U00C4","U007C","SPgDn","U03B7","U2135") ; ä
EDS("02F",1,"U0070","U0050","U007E","U000D","U03C0","U03A0") ; p
EDS("030",1,"U007A","U005A","U0060",""     ,"U03B6","U2124") ; z
EDS("031",1,"U0062","U0042","U002B","U003A","U03B2","U21D0") ; b
EDS("032",1,"U006D","U004D","U0025","SN__1","U03BC","U21D4") ; m
EDS("033",0,"U002C","U2013","U0022","SN__2","U03C1","U21D2") ; ,
EDS("034",0,"U002E","U2022","U0027","SN__3","U03D1","U0398") ; .
EDS("035",1,"U006A","U004A","U003B","U003B","U03B8","U221D") ; j

; Numpad
ED("VK90SC145",0,"U0009","U0009","U003D","U2260","U2248","U2261") ; NumLock
ED("VK6FSC135",0,"SNDiv","SNDiv","U00F7","U2300","U2223","U2044") ; NumpadDiv
ED("VK6ASC037",0,"SNMul","SNMul","U22C5","U00D7","U2299","U2297") ; NumpadMult
ED("VK6DSC04A",0,"SNSub","SNSub","U2212","U2216","U2296","U2238") ; NumpadSub
ED("VK6BSC04E",0,"SNAdd","SNAdd","U00B1","U2213","U2295","U2214") ; NumpadAdd

EDN("VK67SC047","VK24SC047",0,"SN__7","U2714","U2195","SNHom","U226A","U2308") ; Numpad7, NumpadHome
EDN("VK68SC048","VK26SC048",0,"SN__8","U2718","U2191","SN_Up","U2229","U22C2") ; Numpad8, NumpadUp
EDN("VK69SC049","VK21SC049",0,"SN__9","U2020","U20D7","SNPUp","U226B","U2309") ; Numpad9, NumpadPgUp

EDN("VK64SC04B","VK25SC04B",0,"SN__4","U2663","U2190","SN_Le","U2282","U2286") ; Numpad4, NumpadLeft
EDN("VK65SC04C","VK0CSC04C",0,"SN__5","U20AC","U00A6","SNClr","U22B6","U22B7") ; Numpad5, NumpadClear
EDN("VK66SC04D","VK27SC04D",0,"SN__6","U2023","U2192","SN_Ri","U2283","U2287") ; Numpad6, NumpadRight

EDN("VK61SC04F","VK23SC04F",0,"SN__1","U2666","U2194","SNEnd","U2264","U230A") ; Numpad1, NumpadEnd
EDN("VK62SC050","VK28SC050",0,"SN__2","U2665","U2193","SN_Dn","U222A","U22C3") ; Numpad2, NumpadDown
EDN("VK63SC051","VK22SC051",0,"SN__3","U2660","U21CC","SNPDn","U2265","U230B") ; Numpad3, NumpadPgDn

EDN("VK60SC052","VK2DSC052",0,"SN__0","U2423","U0025","SNIns","U2030","U25A1") ; Numpad0, NumpadIns
EDN("VK6ESC053","VK2ESC053",0,"SNDot","U002E","U002C","SNDel","U2032","U2033") ; NumpadDot, NumpadDel

; other keys
ED("space",0,"U0020","U0020","U0020","SN__0","U00A0","U202F")
ED("esc"  ,0,"U001B","U001B","PRlod","U001B","U001B","U001B")
ED("tab"  ,0,"U0009","U0009","SComp","U0009","U0009","U0009")
ED("F1"   ,0,"S__F1","S__F1",""     ,"S__F1",""     ,"")
ED("F2"   ,0,"S__F2","S__F2",""     ,"S__F2",""     ,"")
ED("F3"   ,0,"S__F3","S__F3",""     ,"S__F3",""     ,"")
ED("F4"   ,0,"S__F4","S__F4",""     ,"S__F4",""     ,"")
ED("F5"   ,0,"S__F5","S__F5",""     ,"S__F5",""     ,"")
ED("F6"   ,0,"S__F6","S__F6",""     ,"S__F6",""     ,"")
ED("F7"   ,0,"S__F7","S__F7",""     ,"S__F7",""     ,"")
ED("F8"   ,0,"S__F8","S__F8",""     ,"S__F8",""     ,"")
ED("F9"   ,0,"S__F9","S__F9",""     ,"S__F9",""     ,"")
ED("F10"  ,0,"S_F10","S_F10",""     ,"S_F10",""     ,"")
ED("F11"  ,0,"S_F11","S_F11",""     ,"S_F11",""     ,"")
ED("F12"  ,0,"S_F12","S_F12",""     ,"S_F12",""     ,"")
ED("enter",0,"U000D","U000D","U000D","SNEnt","U000D","U000D")
ED1("backspace","U0008")
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

; Die Modifier
ED1S("02A","PM2LD") ; Mod2L (ShiftL)
ED1S("136","PM2RD") ; Mod2R (ShiftR)
ED1S("03A","PM3LD") ; Mod3L (CapsLock)
ED1S("02B","PM3RD") ; Mod3R (#')
ED1S("056","PM4LD") ; Mod4L (<>)
ED1S("138","PM4RD") ; Mod4R (AltGr)
}

SetKeyPos(pos,char) {
  global
  current := %pos%
  if (current != "")
    StringReplace,CRK%current%,CRK%current%,% " " . pos . " ",% " "
  if (SubStr(CRK%char%,0) != " ")
    CRK%char% .= " "
  CRK%char% .= pos . " "
  %pos% := char
}

ED(pos,caps,e1,e2,e3,e4,e5,e6,e7="",e8="") {
  global
  if (caps == 0)
    NOC%pos% := 1
  else {
    if (e1 != "")
      UNSH%e1% := 1 ; unshift wenn caps lock + Shift?
  }
  SetKeyPos("CP1" . pos,e1)
  SetKeyPos("CP2" . pos,e2)
  SetKeyPos("CP3" . pos,e3)
  SetKeyPos("CP4" . pos,e4)
  SetKeyPos("CP5" . pos,e5)
  SetKeyPos("CP6" . pos,e6)
  SetKeyPos("CP7" . pos,e7)
  SetKeyPos("CP8" . pos,e8)
}

EDN(pos1,pos2,caps,e1,e2,e3,e4,e5,e6) {
  ED(pos1,caps,e1,e2,e3,e4,e5,e6)
  ED(pos2,caps,e1,e2,e3,e4,e5,e6)
}

EDS(scpos,caps,e1,e2,e3,e4,e5,e6,e7="",e8="") {
  global
  ED(vksc%scpos%,caps,e1,e2,e3,e4,e5,e6,e7,e8)
}

ED1(pos,e1) {
 ED(pos,0,e1,e1,e1,e1,e1,e1)
}

ED1S(scpos,e1) {
 EDS(scpos,0,e1,e1,e1,e1,e1,e1)
}

Comp := ""

; RegisterAndHookSC
RSC(sc,vk) {
  global
  vksc%sc% := "VK" . vk . "SC" . sc
  dnkey := "*" . vksc%sc%
  upkey := dnkey . " up"
  Hotkey,% dnkey,allstarhook
  Hotkey,% upkey,allstarhook
}

Layout00000407() {
  global
; Reihe 1
  RSC("029","DC")
  RSC("002","31")
  RSC("003","32")
  RSC("004","33")
  RSC("005","34")
  RSC("006","35")
  RSC("007","36")
  RSC("008","37")
  RSC("009","38")
  RSC("00A","39")
  RSC("00B","30")
  RSC("00C","DB")
  RSC("00D","DD")
; Reihe 2
  RSC("010","51")
  RSC("011","57")
  RSC("012","45")
  RSC("013","52")
  RSC("014","54")
  RSC("015","5A")
  RSC("016","55")
  RSC("017","49")
  RSC("018","4F")
  RSC("019","50")
  RSC("01A","BA")
  RSC("01B","BB")
  RSC("00D","DD")
; Reihe 3
  RSC("01E","41")
  RSC("01F","53")
  RSC("020","44")
  RSC("021","46")
  RSC("022","47")
  RSC("023","48")
  RSC("024","4A")
  RSC("025","4B")
  RSC("026","4C")
  RSC("027","C0")
  RSC("028","DE")
; Reihe 4
  RSC("02C","59")
  RSC("02D","58")
  RSC("02E","43")
  RSC("02F","56")
  RSC("030","42")
  RSC("031","4E")
  RSC("032","4D")
  RSC("033","BC")
  RSC("034","BE")
  RSC("035","BD")
; Modifier
  RSC("02A","A0") ; M2L
  RSC("136","A1") ; M2R
  RSC("03A","14") ; M3L
  RSC("02B","BF") ; M3R
  RSC("056","E2") ; M4L
  RSC("138","A5") ; M4R

  /**** die meisten der folgenden Shortcuts werden von AHK zwar verarbeitet,
   **** von dort aber nur als ALT+Numpad verschickt und daher nicht für alle
   **** Programme nutzbar, also auskommentiert und als Unicode-Zeichen
   **** geschickt.
  */
  ; DNCSU005E := "{^}{space}"
  ; DNCSU0060 := "{``}{space}"
  ; DNCSU00B4 := "{´}{space}"

  CSU005E := ""
  CSU0060 := ""
  CSU00B4 := ""

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
}

Layout00000807() {
  global
; Reihe 1
  RSC("029","BF")
  RSC("002","31")
  RSC("003","32")
  RSC("004","33")
  RSC("005","34")
  RSC("006","35")
  RSC("007","36")
  RSC("008","37")
  RSC("009","38")
  RSC("00A","39")
  RSC("00B","30")
  RSC("00C","DB")
  RSC("00D","DD")
; Reihe 2
  RSC("010","51")
  RSC("011","57")
  RSC("012","45")
  RSC("013","52")
  RSC("014","54")
  RSC("015","5A")
  RSC("016","55")
  RSC("017","49")
  RSC("018","4F")
  RSC("019","50")
  RSC("01A","BA")
  RSC("01B","C0")
  RSC("00D","DD")
; Reihe 3
  RSC("01E","41")
  RSC("01F","53")
  RSC("020","44")
  RSC("021","46")
  RSC("022","47")
  RSC("023","48")
  RSC("024","4A")
  RSC("025","4B")
  RSC("026","4C")
  RSC("027","DE")
  RSC("028","DC")
; Reihe 4
  RSC("02C","59")
  RSC("02D","58")
  RSC("02E","43")
  RSC("02F","56")
  RSC("030","42")
  RSC("031","4E")
  RSC("032","4D")
  RSC("033","BC")
  RSC("034","BE")
  RSC("035","BD")
; Modifier
  RSC("02A","A0") ; M2L
  RSC("136","A1") ; M2R
  RSC("03A","14") ; M3L
  RSC("02B","DF") ; M3R
  RSC("056","E2") ; M4L
  RSC("138","A5") ; M4R

  /**** die meisten der folgenden Shortcuts werden von AHK zwar verarbeitet,
   **** von dort aber nur als ALT+Numpad verschickt und daher nicht für alle
   **** Programme nutzbar, also auskommentiert und als Unicode-Zeichen
   **** geschickt.
  */
  ; DNCSU005E := "{^}{space}"
  ; DNCSU0060 := "{``}{space}"
  ; DNCSU00B4 := "{´}{space}"

  CSU005E := ""
  CSU0060 := ""
  CSU00B4 := ""

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
  ; CSU00B2 := chr(178)   ; ²
  ; CSU00B3 := chr(179)   ; ³
  ; CSU00B4 := chr(180)   ; ´
  ; CSU00B5 := chr(181)   ; µ
  ; CSU00C4 := chr(196)   ; Ä
  ; CSU00D6 := chr(214)   ; Ö
  ; CSU00DC := chr(220)   ; Ü
  ; CSU00DF := chr(223)   ; ß
  CSU00E0 := chr(224)   ; à
  CSU00E4 := chr(228)   ; ä
  CSU00E8 := chr(232)   ; è
  CSU00E9 := chr(233)   ; é
  CSU00F6 := chr(246)   ; ö
  CSU00FC := chr(252)   ; ü
  ; CSU00FF := chr(255)   ; ÿ

  /*
    Für alle Zeichen, die durch Tastendrücke ohne Shift-Taste zustande kommen,
    muss eine gegebenenfalls gedrückte Shift-Taste vor dem Senden temporär
    gelöst werden. Dafür werden für sämtliche relevante Zeichen die passenden
    UNSHU.... Variablen gesetzt.
  */
  ; Reihe 1
  UNSHU00A7 := 1 ; §
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
  UNSHU0027 := 1 ; '
  UNSHU005E := 1 ; ^
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
  UNSHU00A8 := 1 ; ¨
  UNSHU0024 := 1 ; $
  UNSHU003C := 1 ; <
  UNSHU002C := 1 ; ,
  UNSHU002E := 1 ; .
  UNSHU002D := 1 ; -
  ; AltGr
  UNSHU00A6 := 1 ; ¦
  UNSHU0040 := 1 ; @
  UNSHU0023 := 1 ; #
  UNSHU00AC := 1 ; ¬
  UNSHU007C := 1 ; |
  UNSHU00A2 := 1 ; ¢
  UNSHU00B4 := 1 ; ´
  UNSHU007E := 1 ; ~
  UNSHU20AC := 1 ; Euro
  UNSHU005B := 1 ; [
  UNSHU005D := 1 ; ]
  UNSHU007B := 1 ; {
  UNSHU007D := 1 ; }
  UNSHU005C := 1 ; \
}

ActivateLayOut(layout) {
  Layout%layout%()
}
