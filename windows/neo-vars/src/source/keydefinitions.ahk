; -*- encoding:utf-8 -*-

thekeys() {
;   KeyCode       Ebene1  Ebene2  Ebene3  Ebene4  Ebene5  Ebene6  Ebene7* Ebene8*
; Reihe 1
EDS("029",0,"T__cflx","T__cron","T__turn","T__abdt","T__hook","T__bldt") ; circumflex
EDS("002",0,"1","°","¹","ª"      ,"₁","¬") ; 1
EDS("003",0,"2","§","²","º"      ,"₂","∨") ; 2
EDS("004",0,"3","ℓ","³","№"      ,"₃","∧") ; 3
EDS("005",0,"4","»","›","⋮"       ,"♀","⊥") ; 4
EDS("006",0,"5","«","‹","·"      ,"♂","∡") ; 5
EDS("007",0,"6","$","¢","£"      ,"⚥","∥") ; 6
EDS("008",0,"7","€","¥","¤"      ,"ϰ","→") ; 7
EDS("009",0,"8","„","‚",""       ,"⟨","∞") ; 8
EDS("00A",0,"9","“","‘","S__NDiv","⟩","∝") ; 9
EDS("00B",0,"0","”","’","S__NMul","₀","∅") ; 0
EDS("00C",0,"-","—","" ,"S__NSub","‑","­") ; -
EDS("00D",0,"T__grav","T__cedi","T__abrg","T__drss","T_dasia","T__mcrn") ; grave
; Reihe 2
EDS("010",1,"x","X","…","S__PgUp","ξ","Ξ") ; x
EDS("011",1,"v","V","_","U000008","" ,"√") ; v
EDS("012",1,"l","L","[","S____Up","λ","Λ") ; l
EDS("013",1,"c","C","]","S___Del","χ","ℂ") ; c
EDS("014",1,"w","W","^","S__PgDn","ω","Ω") ; w
EDS("015",1,"k","K","!","¡"      ,"κ","×") ; k
EDS("016",1,"h","H","<","S__N__7","ψ","Ψ") ; h
EDS("017",1,"g","G",">","S__N__8","γ","Γ") ; g
EDS("018",1,"f","F","=","S__N__9","φ","Φ") ; f
EDS("019",1,"q","Q","&","S__NAdd","ϕ","ℚ") ; q
EDS("01A",1,"ß","ẞ","ſ","−"      ,"ς","∘") ; ß
EDS("01B",0,"T__acut","T__tlde","T__strk","T__dbac","T_psili","T__brve") ; acute
; Reihe 3
EDS("01E",1,"u","U","\","S__Home","" ,"⊂") ; u
EDS("01F",1,"i","I","/","S__Left","ι","∫") ; i
EDS("020",1,"a","A","{","S__Down","α","∀") ; a
EDS("021",1,"e","E","}","S__Rght","ε","∃") ; e
EDS("022",1,"o","O","*","S___End","ο","∈") ; o
EDS("023",1,"s","S","?","¿"      ,"σ","Σ") ; s
EDS("024",1,"n","N","(","S__N__4","ν","ℕ") ; n
EDS("025",1,"r","R",")","S__N__5","ρ","ℝ") ; r
EDS("026",1,"t","T","-","S__N__6","τ","∂") ; t
EDS("027",1,"d","D",":","S__NDot","δ","Δ") ; d
EDS("028",1,"y","Y","@","."      ,"υ","∇") ; y
; Reihe 4
EDS("02C",1,"ü","Ü","#","U00001B","" ,"∪") ; ü
EDS("02D",1,"ö","Ö","$","U000009","ϵ","∩") ; ö
EDS("02E",1,"ä","Ä","|","S___Ins","η","ℵ") ; ä
EDS("02F",1,"p","P","~","U00000D","π","Π") ; p
EDS("030",1,"z","Z","``",""      ,"ζ","ℤ") ; z
EDS("031",1,"b","B","+",":"      ,"β","⇐") ; b
EDS("032",1,"m","M","%","S__N__1","μ","⇔") ; m
EDS("033",0,",","–","""","S__N__2","ϱ","⇒") ; ,
EDS("034",0,".","•","'","S__N__3","ϑ","↦") ; .
EDS("035",1,"j","J",";",";"      ,"θ","Θ") ; j

; Numpad
EDS("145",0,"U000009","U000009","=","≠","≈","≡") ; NumLock
EDS("135",0,"S__NDiv","S__NDiv","÷","⌀","∣","⁄") ; NumpadDiv
EDS("037",0,"S__NMul","S__NMul","⋅","×","⊙","⊗") ; NumpadMult
EDS("04A",0,"S__NSub","S__NSub","−","∖","⊖","∸") ; NumpadSub
EDS("04E",0,"S__NAdd","S__NAdd","±","∓","⊕","∔") ; NumpadAdd

EDNS("047",0,"S__N__7","✔","↕","S__NHom","S_SNHom","≪","⌈") ; Numpad7
EDNS("048",0,"S__N__8","✘","↑","S__N_Up","S_SN_Up","∩","⋂") ; Numpad8
EDNS("049",0,"S__N__9","†","⃗","S__NPUp","S_SNPUp","≫","⌉") ; Numpad9
EDNS("04B",0,"S__N__4","♣","←","S__N_Le","S_SN_Le","⊂","⊆") ; Numpad4
EDNS("04C",0,"S__N__5","€",":","S__NClr","S_SNClr","⊶","⊷") ; Numpad5
EDNS("04D",0,"S__N__6","‣","→","S__N_Ri","S_SN_Ri","⊃","⊇") ; Numpad6
EDNS("04F",0,"S__N__1","♦","↔","S__NEnd","S_SNEnd","≤","⌊") ; Numpad1
EDNS("050",0,"S__N__2","♥","↓","S__N_Dn","S_SN_Dn","∪","⋃") ; Numpad2
EDNS("051",0,"S__N__3","♠","⇌","S__NPDn","S_SNPDn","≥","⌋") ; Numpad3
EDNS("052",0,"S__N__0","␣","%","S__NIns","S_SNIns","‰","□") ; Numpad0
EDNS("053",0,"S__NDot",".",",","S__NDel","S_SNDel","′","″") ; NumpadDot

; other keys
ED("space",0,"U000020","U000020","U000020","S__N__0","U0000A0","U00202F")
ED("esc"  ,0,"U00001B","U00001B","P__Rlod","U00001B","U00001B","U00001B")
ED("tab"  ,0,"U000009","U000009","S__Comp","U000009","U000009","U000009")
ED("F1"   ,0,"S____F1","S____F1",""       ,"S____F1",""       ,"")
ED("F2"   ,0,"S____F2","S____F2",""       ,"S____F2",""       ,"")
ED("F3"   ,0,"S____F3","S____F3",""       ,"S____F3",""       ,"")
ED("F4"   ,0,"S____F4","S____F4",""       ,"S____F4",""       ,"")
ED("F5"   ,0,"S____F5","S____F5",""       ,"S____F5",""       ,"")
ED("F6"   ,0,"S____F6","S____F6",""       ,"S____F6",""       ,"")
ED("F7"   ,0,"S____F7","S____F7",""       ,"S____F7",""       ,"")
ED("F8"   ,0,"S____F8","S____F8",""       ,"S____F8",""       ,"")
ED("F9"   ,0,"S____F9","S____F9",""       ,"S____F9",""       ,"")
ED("F10"  ,0,"S___F10","S___F10",""       ,"S___F10",""       ,"")
ED("F11"  ,0,"S___F11","S___F11",""       ,"S___F11",""       ,"")
ED("F12"  ,0,"S___F12","S___F12",""       ,"S___F12",""       ,"")
ED("enter",0,"U00000D","U00000D","U00000D","S__NEnt","U00000D","U00000D")
ED1("backspace","U000008")
ED1("del"      ,"S___Del")
ED1("ins"      ,"S___Ins")
ED1("home"     ,"S__Home")
ED1("end"      ,"S___End")
ED1("pgup"     ,"S__PgUp")
ED1("pgdn"     ,"S__PgDn")
ED1("up"       ,"S____Up")
ED1("down"     ,"S__Down")
ED1("left"     ,"S__Left")
ED1("right"    ,"S__Rght")
ED1("numpadenter","S__NEnt")

; Die Modifier
ED1S("02A","P__M2LD") ; Mod2L (ShiftL)
ED1S("136","P__M2RD") ; Mod2R (ShiftR)
ED1S("03A","P__M3LD") ; Mod3L (CapsLock)
ED1S("02B","P__M3RD") ; Mod3R (#')
ED1S("056","P__M4LD") ; Mod4L (<>)
ED1S("138","P__M4RD") ; Mod4R (AltGr)
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

EDR(pos,caps,e1,e2,e3,e4,e5,e6,e7="",e8="") {
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

ED(pos,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a="",e8a="") {
  global
  e1  := EncodeUniComposeA(e1a)
  e2  := EncodeUniComposeA(e2a)
  e3  := EncodeUniComposeA(e3a)
  e4  := EncodeUniComposeA(e4a)
  e5  := EncodeUniComposeA(e5a)
  e6  := EncodeUniComposeA(e6a)
  e7  := EncodeUniComposeA(e7a)
  e8  := EncodeUniComposeA(e8a)
  EDR(pos,caps,e1,e2,e3,e4,e5,e6,e7,e8)
}

EDNR(pos1,pos2,caps,e1,e2,e3,e4,e5,e6) {
  EDR(pos1,caps,e1,e2,e3,e4,e5,e6)
  EDR(pos2,caps,e1,e2,e3,e4,e5,e6)
}

EDN(pos1,pos2,caps,e1a,e2a,e3a,e4a,e5a,e6a) {
  ED(pos1,caps,e1a,e2a,e3a,e4a,e5a,e6a)
  ED(pos2,caps,e1a,e2a,e3a,e4a,e5a,e6a)
}

EDSR(scpos,caps,e1,e2,e3,e4,e5,e6,e7="",e8="") {
  global
  EDR(vksc%scpos%,caps,e1,e2,e3,e4,e5,e6,e7,e8)
}

EDS(scpos,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a="",e8a="") {
  global
  ED(vksc%scpos%,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a,e8a)
}

EDNS(scpos,caps,e1a,e2a,e3a,e4a1,e4a2,e5a,e6a,e7a="",e8a="") {
  global
  ED(vkscn1%scpos%,caps,e1a,e2a,e3a,e4a1,e5a,e6a)
  ED(vkscn2%scpos%,caps,e2a,e1a,e5a,e4a2,"","")
}

ED1(pos,e1a) {
 ED(pos,0,e1a,e1a,e1a,e1a,e1a,e1a)
}

ED1S(scpos,e1a) {
 EDS(scpos,0,e1a,e1a,e1a,e1a,e1a,e1a)
}

ED12(scpos,caps,e1a,e2a) {
  global
  pos := vksc%scpos%
  e1  := EncodeUniComposeA(e1a)
  e2  := EncodeUniComposeA(e2a)
  if (caps == 0) {
    NOC%pos% := 1
    UNSH%e1% := 0
  } else {
    NOC%pos% := 0
    UNSH%e1% := 1 ; unshift wenn caps lock + Shift?
  }
  SetKeyPos("CP1" . pos, e1)
  SetKeyPos("CP2" . pos, e2)
}

ED1256(scpos,caps,e1a,e2a,e5a,e6a) {
  global
  pos := vksc%scpos%
  e1  := EncodeUniComposeA(e1a)
  e2  := EncodeUniComposeA(e2a)
  e5  := EncodeUniComposeA(e5a)
  e6  := EncodeUniComposeA(e6a)
  if (caps == 0) {
    NOC%pos% := 1
    UNSH%e1% := 0
  } else {
    NOC%pos% := 0
    UNSH%e1% := 1 ; unshift wenn caps lock + Shift?
  }
  SetKeyPos("CP1" . pos, e1)
  SetKeyPos("CP2" . pos, e2)
  SetKeyPos("CP5" . pos, e5)
  SetKeyPos("CP6" . pos, e6)
}

Comp := ""

; RegisterAndHookSC
RSC(sc,vk) {
  global
  vksc%sc% := "VK" . vk . "SC" . sc
  RKEY(vksc%sc%)
}

RSCN(sc,vk1,vk2) {
  global
  vkscn1%sc% := "VK" . vk1 . "SC" . sc
  vkscn2%sc% := "VK" . vk2 . "SC" . sc
  RKEY(vkscn1%sc%)
  RKEY(vkscn2%sc%)
}

RKEY(key) {
  RKEYN("*" . key)
}

RKEYS(keys) {
  loop,parse,keys,`,
  {
    RKEY(A_Loopfield)
  }
}

RKEYN(dnkey) {
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
; Numpad
  RSC("145","90") ; NumLock
  RSC("135","6F") ; NumpadDiv
  RSC("037","6A") ; NumpadMult
  RSC("04A","6D") ; NumpadSub
  RSC("04E","6B") ; NumpadAdd
  RSCN("047","67","24") ; Numpad7/NumpadHome
  RSCN("048","68","26") ; Numpad8/NumpadUp
  RSCN("049","69","21") ; Numpad9/NumpadPgUp
  RSCN("04B","64","25") ; Numpad4/NumpadLeft
  RSCN("04C","65","0C") ; Numpad5/NumpadClear
  RSCN("04D","66","27") ; Numpad6/NumpadRight
  RSCN("04F","61","23") ; Numpad1/NumpadEnd
  RSCN("050","62","28") ; Numpad2/NumpadDown
  RSCN("051","63","22") ; Numpad3/NumpadPgDn
  RSCN("052","60","2D") ; Numpad0/NumpadIns
  RSCN("053","6E","2E") ; NumpadDot/NumpadDel
; Diverses
  RKEYS("F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12")
  RKEYS("space,enter,backspace")
  RKEYS("del,ins,home,end,pgup,pgdn,up,down,left,right")
; Diverses ohne *
  RKEYN("tab")
  RKEYN("esc")
  RKEYN("numpadenter")
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
  ; DNCSU00005E := "{^}{space}"
  ; DNCSU000060 := "{``}{space}"
  ; DNCSU0000B4 := "{´}{space}"

  CSU00005E := ""
  CSU000060 := ""
  CSU0000B4 := ""

  CSU0020AC := chr(128)   ; €
  ; CSU00201A := chr(130) ; ‚
  ; CSU000192 := chr(131) ; ƒ
  ; CSU00201E := chr(132) ; „
  ; CSU002026 := chr(133) ; …
  ; CSU002020 := chr(134) ; †
  ; CSU002021 := chr(135) ; ‡
  ; CSU0002C6 := chr(136) ; ˆ
  ; CSU002030 := chr(137) ; ‰
  ; CSU000160 := chr(138) ; Š
  ; CSU002039 := chr(139) ; ‹
  ; CSU000152 := chr(140) ; Œ
  ; CSU00017D := chr(142) ; Ž
  ; CSU002018 := chr(145) ; ‘
  ; CSU002019 := chr(146) ; ’
  ; CSU00201C := chr(147) ; “
  ; CSU00201D := chr(148) ; ”
  ; CSU002022 := chr(149) ; •
  ; CSU002013 := chr(150) ; –
  ; CSU002014 := chr(151) ; —
  ; CSU0002DC := chr(152) ; ˜
  ; CSU002122 := chr(153) ; ™
  ; CSU000161 := chr(154) ; š
  ; CSU00203A := chr(155) ; ›
  ; CSU000153 := chr(156) ; œ
  ; CSU00017E := chr(158) ; ž
  ; CSU000178 := chr(159) ; Ÿ
  CSU0000A7 := chr(167)   ; §
  CSU0000B0 := chr(176)   ; °
  CSU0000B2 := chr(178)   ; ²
  CSU0000B3 := chr(179)   ; ³
  ; CSU0000B4 := chr(180)   ; ´
  CSU0000B5 := chr(181)   ; µ
  CSU0000C4 := chr(196)   ; Ä
  CSU0000D6 := chr(214)   ; Ö
  CSU0000DC := chr(220)   ; Ü
  CSU0000DF := chr(223)   ; ß
  CSU0000E4 := chr(228)   ; ä
  CSU0000F6 := chr(246)   ; ö
  CSU0000FC := chr(252)   ; ü
  CSU0000FF := chr(255)   ; ÿ

  /*
    Für alle Zeichen, die durch Tastendrücke ohne Shift-Taste zustande kommen,
    muss eine gegebenenfalls gedrückte Shift-Taste vor dem Senden temporär
    gelöst werden. Dafür werden für sämtliche relevante Zeichen die passenden
    UNSHU.... Variablen gesetzt.
  */
  ; Reihe 1
  UNSHU00005E := 1 ; ^
  UNSHU000031 := 1 ; 1
  UNSHU000032 := 1 ; 2
  UNSHU000033 := 1 ; 3
  UNSHU000034 := 1 ; 4
  UNSHU000035 := 1 ; 5
  UNSHU000036 := 1 ; 6
  UNSHU000037 := 1 ; 7
  UNSHU000038 := 1 ; 8
  UNSHU000039 := 1 ; 9
  UNSHU000030 := 1 ; 0
  UNSHU0000DF := 1 ; ß
  UNSHU0000B4 := 1 ; ´
  ; Alphabet
  UNSHU000061 := 1 ; a
  UNSHU000062 := 1 ; b
  UNSHU000063 := 1 ; c
  UNSHU000064 := 1 ; d
  UNSHU000065 := 1 ; e
  UNSHU000066 := 1 ; f
  UNSHU000067 := 1 ; g
  UNSHU000068 := 1 ; h
  UNSHU000069 := 1 ; i
  UNSHU00006A := 1 ; j
  UNSHU00006B := 1 ; k
  UNSHU00006C := 1 ; l
  UNSHU00006D := 1 ; m
  UNSHU00006E := 1 ; n
  UNSHU00006F := 1 ; o
  UNSHU000070 := 1 ; p
  UNSHU000071 := 1 ; q
  UNSHU000072 := 1 ; r
  UNSHU000073 := 1 ; s
  UNSHU000074 := 1 ; t
  UNSHU000075 := 1 ; u
  UNSHU000076 := 1 ; v
  UNSHU000077 := 1 ; w
  UNSHU000078 := 1 ; x
  UNSHU000079 := 1 ; y
  UNSHU00007A := 1 ; z
  UNSHU0000E4 := 1 ; ä
  UNSHU0000F6 := 1 ; ö
  UNSHU0000FC := 1 ; ü
  ; Rest
  UNSHU00002B := 1 ; +
  UNSHU000023 := 1 ; #
  UNSHU00003C := 1 ; <
  UNSHU00002C := 1 ; ,
  UNSHU00002E := 1 ; .
  UNSHU00002D := 1 ; -
  ; AltGr
  UNSHU0000B2 := 1 ; ²
  UNSHU0000B3 := 1 ; ³
  UNSHU00007B := 1 ; {
  UNSHU00005B := 1 ; [
  UNSHU00005D := 1 ; ]
  UNSHU00007D := 1 ; }
  UNSHU00005C := 1 ; \
  UNSHU000040 := 1 ; @
  UNSHU0020AC := 1 ; Euro
  UNSHU00007E := 1 ; ~
  UNSHU00007C := 1 ; |
  UNSHU0000B5 := 1 ; µ
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
; Numpad
  RSC("145","90") ; NumLock
  RSC("135","6F") ; NumpadDiv
  RSC("037","6A") ; NumpadMult
  RSC("04A","6D") ; NumpadSub
  RSC("04E","6B") ; NumpadAdd
  RSCN("047","67","24") ; Numpad7/NumpadHome
  RSCN("048","68","26") ; Numpad8/NumpadUp
  RSCN("049","69","21") ; Numpad9/NumpadPgUp
  RSCN("04B","64","25") ; Numpad4/NumpadLeft
  RSCN("04C","65","0C") ; Numpad5/NumpadClear
  RSCN("04D","66","27") ; Numpad6/NumpadRight
  RSCN("04F","61","23") ; Numpad1/NumpadEnd
  RSCN("050","62","28") ; Numpad2/NumpadDown
  RSCN("051","63","22") ; Numpad3/NumpadPgDn
  RSCN("052","60","2D") ; Numpad0/NumpadIns
  RSCN("053","6E","2E") ; NumpadDot/NumpadDel
; Diverses
  RKEYS("F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12")
  RKEYS("space,enter,backspace")
  RKEYS("del,ins,home,end,pgup,pgdn,up,down,left,right")
; Diverses ohne *
  RKEYN("tab")
  RKEYN("esc")
  RKEYN("numpadenter")
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
  ; DNCSU00005E := "{^}{space}"
  ; DNCSU000060 := "{``}{space}"
  ; DNCSU0000B4 := "{´}{space}"

  CSU00005E := ""
  CSU000060 := ""
  CSU0000B4 := ""

  CSU0020AC := chr(128)   ; €
  ; CSU00201A := chr(130) ; ‚
  ; CSU000192 := chr(131) ; ƒ
  ; CSU00201E := chr(132) ; „
  ; CSU002026 := chr(133) ; …
  ; CSU002020 := chr(134) ; †
  ; CSU002021 := chr(135) ; ‡
  ; CSU0002C6 := chr(136) ; ˆ
  ; CSU002030 := chr(137) ; ‰
  ; CSU000160 := chr(138) ; Š
  ; CSU002039 := chr(139) ; ‹
  ; CSU000152 := chr(140) ; Œ
  ; CSU00017D := chr(142) ; Ž
  ; CSU002018 := chr(145) ; ‘
  ; CSU002019 := chr(146) ; ’
  ; CSU00201C := chr(147) ; “
  ; CSU00201D := chr(148) ; ”
  ; CSU002022 := chr(149) ; •
  ; CSU002013 := chr(150) ; –
  ; CSU002014 := chr(151) ; —
  ; CSU0002DC := chr(152) ; ˜
  ; CSU002122 := chr(153) ; ™
  ; CSU000161 := chr(154) ; š
  ; CSU00203A := chr(155) ; ›
  ; CSU000153 := chr(156) ; œ
  ; CSU00017E := chr(158) ; ž
  ; CSU000178 := chr(159) ; Ÿ
  CSU0000A7 := chr(167)   ; §
  CSU0000B0 := chr(176)   ; °
  ; CSU0000B2 := chr(178)   ; ²
  ; CSU0000B3 := chr(179)   ; ³
  ; CSU0000B4 := chr(180)   ; ´
  ; CSU0000B5 := chr(181)   ; µ
  ; CSU0000C4 := chr(196)   ; Ä
  ; CSU0000D6 := chr(214)   ; Ö
  ; CSU0000DC := chr(220)   ; Ü
  ; CSU0000DF := chr(223)   ; ß
  CSU0000E0 := chr(224)   ; à
  CSU0000E4 := chr(228)   ; ä
  CSU0000E8 := chr(232)   ; è
  CSU0000E9 := chr(233)   ; é
  CSU0000F6 := chr(246)   ; ö
  CSU0000FC := chr(252)   ; ü
  ; CSU0000FF := chr(255)   ; ÿ

  /*
    Für alle Zeichen, die durch Tastendrücke ohne Shift-Taste zustande kommen,
    muss eine gegebenenfalls gedrückte Shift-Taste vor dem Senden temporär
    gelöst werden. Dafür werden für sämtliche relevante Zeichen die passenden
    UNSHU.... Variablen gesetzt.
  */
  ; Reihe 1
  UNSHU0000A7 := 1 ; §
  UNSHU000031 := 1 ; 1
  UNSHU000032 := 1 ; 2
  UNSHU000033 := 1 ; 3
  UNSHU000034 := 1 ; 4
  UNSHU000035 := 1 ; 5
  UNSHU000036 := 1 ; 6
  UNSHU000037 := 1 ; 7
  UNSHU000038 := 1 ; 8
  UNSHU000039 := 1 ; 9
  UNSHU000030 := 1 ; 0
  UNSHU000027 := 1 ; '
  UNSHU00005E := 1 ; ^
  ; Alphabet
  UNSHU000061 := 1 ; a
  UNSHU000062 := 1 ; b
  UNSHU000063 := 1 ; c
  UNSHU000064 := 1 ; d
  UNSHU000065 := 1 ; e
  UNSHU000066 := 1 ; f
  UNSHU000067 := 1 ; g
  UNSHU000068 := 1 ; h
  UNSHU000069 := 1 ; i
  UNSHU00006A := 1 ; j
  UNSHU00006B := 1 ; k
  UNSHU00006C := 1 ; l
  UNSHU00006D := 1 ; m
  UNSHU00006E := 1 ; n
  UNSHU00006F := 1 ; o
  UNSHU000070 := 1 ; p
  UNSHU000071 := 1 ; q
  UNSHU000072 := 1 ; r
  UNSHU000073 := 1 ; s
  UNSHU000074 := 1 ; t
  UNSHU000075 := 1 ; u
  UNSHU000076 := 1 ; v
  UNSHU000077 := 1 ; w
  UNSHU000078 := 1 ; x
  UNSHU000079 := 1 ; y
  UNSHU00007A := 1 ; z
  UNSHU0000E4 := 1 ; ä
  UNSHU0000F6 := 1 ; ö
  UNSHU0000FC := 1 ; ü
  ; Rest
  UNSHU0000A8 := 1 ; ¨
  UNSHU000024 := 1 ; $
  UNSHU00003C := 1 ; <
  UNSHU00002C := 1 ; ,
  UNSHU00002E := 1 ; .
  UNSHU00002D := 1 ; -
  ; AltGr
  UNSHU0000A6 := 1 ; ¦
  UNSHU000040 := 1 ; @
  UNSHU000023 := 1 ; #
  UNSHU0000AC := 1 ; ¬
  UNSHU00007C := 1 ; |
  UNSHU0000A2 := 1 ; ¢
  UNSHU0000B4 := 1 ; ´
  UNSHU00007E := 1 ; ~
  UNSHU0020AC := 1 ; Euro
  UNSHU00005B := 1 ; [
  UNSHU00005D := 1 ; ]
  UNSHU00007B := 1 ; {
  UNSHU00007D := 1 ; }
  UNSHU00005C := 1 ; \
}

Layout00010407() {
  Layout00000407()
}

ActivateLayOut(layout) {
  Layout%layout%()
}
