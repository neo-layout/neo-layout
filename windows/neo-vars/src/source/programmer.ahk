; -*- encoding:utf-8 -*-
; Programmer Belegungen
; Coffee++ and Q-KOIN-M (by Ruben Barkow)
; EurKey (by Steffen Brüntjen)

CharProcProgTt() {
  global

  ; Custom Layout togglen
  if (isProgrammer == 0) {
    isProgrammer := 1
    CharProcProgT1()
    if (zeigeModusBox)
      TrayTip,Programmer-Belegungsvariante,Die Belegungsvariante Coffee++ wurde aktiviert. Zum Umschalten`, Mod3+F5 drücken.,10,1
  } else if (isProgrammer == 1) {
    isProgrammer := 2
    CharProcProgT2()
    if (zeigeModusBox)
      TrayTip,Programmer-Belegungsvariante,Die Belegungsvariante Q-KOIN-M wurde aktiviert. Zum Umschalten`, Mod3+F5 drücken.,10,1
  }  else if (isProgrammer == 2) {
    isProgrammer := 3
    CharProcProgT3()
    if (zeigeModusBox)
      TrayTip,Programmer-Belegungsvariante,Die Belegungsvariante EurKey wurde aktiviert. Zum Umschalten`, Mod3+F5 drücken.,10,1
  } else {
    isProgrammer := 0
    CharProcProgT0()
    if (zeigeModusBox)
      TrayTip,Programmer-Belegungsvariante,Die Belegungsvariante wurde deaktiviert.,10,1
  }
}

PL_Backup(pos) {
  global
  PO_CP1%pos% := CP1%pos%
  PO_CP2%pos% := CP2%pos%
  PO_CP3%pos% := CP3%pos%
  PO_CP4%pos% := CP4%pos%
  PO_CP5%pos% := CP5%pos%
  PO_CP6%pos% := CP6%pos%
  PO_CP7%pos% := CP7%pos%
  PO_CP8%pos% := CP8%pos%
  if (POList == "")
    POList := pos
  else
    POList := POList . "," . pos
}
PL_Restore(pos) {
  global
  CP1%pos% := PO_CP1%pos%
  CP2%pos% := PO_CP2%pos%
  CP3%pos% := PO_CP3%pos%
  CP4%pos% := PO_CP4%pos%
  CP5%pos% := PO_CP5%pos%
  CP6%pos% := PO_CP6%pos%
  CP7%pos% := PO_CP7%pos%
  CP8%pos% := PO_CP8%pos%
}
PL_RestoreAll() {
  global
  Loop, parse, POList, `,
    PL_Restore(A_LoopField)
}

PL_ED(pos,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a="",e8a="") {
  global
  PL_Backup(pos)
  ED(pos,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a,e8a)
}

PL_EDS(scpos,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a="",e8a="") {
  global
  PL_ED(vksc%scpos%,caps,e1a,e2a,e3a,e4a,e5a,e6a,e7a,e8a)
}

CharProcProgT1() {
global
POList := ""
;   KeyCode    Ebene1    Ebene2    Ebene3    Ebene4    Ebene5    Ebene6   Ebene7* Ebene8*
; Reihe 1
PL_EDS("029",1,"q"      ,"Q"      ,"7"      ,"T__abdt","÷"      ,"T__bldt") ; circumflex
PL_EDS("002",1,"p"      ,"P"      ,"8"      ,"ª"      ,"!"      ,"¬"      ) ; 1
PL_EDS("003",1,"f"      ,"F"      ,"9"      ,"º"      ,""""     ,"∨"      ) ; 2
PL_EDS("004",1,"m"      ,"M"      ,"0"      ,"№"      ,"\"      ,"∧"      ) ; 3
PL_EDS("005",1,"u"      ,"U"      ,"1"      ,"⋮"      ,"½"      ,"⊥"      ) ; 4
PL_EDS("006",1,"k"      ,"K"      ,"2"      ,"·"      ,"%"      ,"∡"      ) ; 5
PL_EDS("007",1,"y"      ,"Y"      ,"3"      ,"£"      ,"³"      ,"∥"      ) ; 6
PL_EDS("008",0,"$"      ,"x"      ,"4"      ,"¤"      ,"¼"      ,"→"      ) ; 7
PL_EDS("009",0,"/"      ,"€"      ,"∑"      ,""       ,"⅓"      ,"∞"      ) ; 8
PL_EDS("00A",0,"+"      ,"&"      ,"T__cron","S__NDiv","±"      ,"∝"      ) ; 9
PL_EDS("00B",0,"*"      ,"§"      ,"¤"      ,"S__NMul","×"      ,"∅"      ) ; 0
PL_EDS("00C",0,"T__drss","ß"      ,"«"      ,"S__NSub","£"      ,"­"      ) ; ß
PL_EDS("00D",0,"!"      ,"T__acut","»"      ,"T__drss","¡"      ,"T__mcrn") ; `
; Reihe 2
PL_EDS("010",1,"w"      ,"W"      ,"@"      ,"S__PgUp","'"      ,"Ξ"      ) ; q
PL_EDS("011",1,"i"      ,"I"      ,"["      ,"U000008","+"      ,"√"      ) ; w
PL_EDS("012",1,"r"      ,"R"      ,"]"      ,"S____Up","/"      ,"Λ"      ) ; e
PL_EDS("013",1,"h"      ,"H"      ,"("      ,"S___Del","#"      ,"ℂ"      ) ; r
PL_EDS("014",1,"l"      ,"L"      ,")"      ,"S__PgDn","*"      ,"Ω"      ) ; t
PL_EDS("015",1,"z"      ,"Z"      ,"5"      ,"¡"      ,"⅔"      ,"×"      ) ; z
PL_EDS("016",0,"("      ,"{"      ,"T__cedi","S__N__7","¢"      ,"Ψ"      ) ; u
PL_EDS("017",0,")"      ,"}"      ,"S____Up","S__N__8","Я"      ,"Γ"      ) ; i
PL_EDS("018",0,"="      ,"%"      ,"S__PgUp","S__N__9","‰"      ,"Φ"      ) ; o
PL_EDS("019",0,"["      ,"|"      ,"S___Del","S__NAdd","¦"      ,"ℚ"      ) ; p
PL_EDS("01A",0,">"      ,"T__grav","©"      ,"−"      ,"›"      ,"∘"      ) ; ü
PL_EDS("01B",0,"<"      ,"T__cflx","T__tlde","T__dbac","‹"      ,"T__brve") ; +
; Reihe 3
PL_EDS("01E",1,"a"      ,"A"      ,"?"      ,"S__Home","ß"      ,"⊂"      ) ; a
PL_EDS("01F",1,"s"      ,"S"      ,"."      ,"S__Left","&"      ,"∫"      ) ; s
PL_EDS("020",1,"d"      ,"D"      ,"U00000D","S__Down",":"      ,"∀"      ) ; d
PL_EDS("021",1,"o"      ,"O"      ,"U000008","S__Rght","T__mcrn","∃"      ) ; f
PL_EDS("022",1,"c"      ,"C"      ,";"      ,"S___End","T__acut","∈"      ) ; g
PL_EDS("023",1,"g"      ,"G"      ,"6"      ,"¿"      ,"™"      ,"Σ"      ) ; h
PL_EDS("024",1,"e"      ,"E"      ,"S__Left","S__N__4","æ"      ,"ℕ"      ) ; j
PL_EDS("025",1,"n"      ,"N"      ,"S__Down","S__N__5","®"      ,"ℝ"      ) ; k
PL_EDS("026",1,"t"      ,"T"      ,"S__Rght","S__N__6","→"      ,"∂"      ) ; l
PL_EDS("027",1,"i"      ,"I"      ,"ø"      ,"S__NDot","Ø"      ,"Δ"      ) ; ö
PL_EDS("028",0,"]"      ,"?"      ,"¿"      ,"."      ,"↔"      ,"∇"      ) ; ä
PL_EDS("02B",0,"'"      ,"#"      ,"T__abrg",""       ,"►"      ,""       ) ; #
; Reihe 4
PL_EDS("056",1,"x"      ,"X"      ,"|"      ,"P__M4LD",","      ,"P__M4LD") ; <>
PL_EDS("02C",1,"v"      ,"V"      ,">"      ,"U00001B","<"      ,"∪"      ) ; y
PL_EDS("02D",1,"t"      ,"T"      ,"="      ,"U000009","T__grav","∩"      ) ; x
PL_EDS("02E",1,"n"      ,"N"      ,"_"      ,"S___Ins","T__tlde","ℵ"      ) ; c
PL_EDS("02F",1,"e"      ,"E"      ,"-"      ,"U00000D","²"      ,"Π"      ) ; v
PL_EDS("030",1,"b"      ,"B"      ,"{"      ,""       ,"∞"      ,"ℤ"      ) ; b
PL_EDS("031",1,"j"      ,"J"      ,"}"      ,":"      ,"¥"      ,"⇐"      ) ; n
PL_EDS("032",0,""""     ,"\"      ,"S__Home","S__N__1","µ"      ,"⇔"      ) ; m
PL_EDS("033",0,","      ,";"      ,"S___End","S__N__2","—"      ,"⇒"      ) ; ,
PL_EDS("034",0,"."      ,":"      ,"S__PgDn","S__N__3","·"      ,"↦"      ) ; .
PL_EDS("035",0,"-"      ,"_"      ,"¯"      ,";"      ,"–"      ,"Θ"      ) ; -

; other keys
PL_Backup("space")
PL_Backup("esc"  )
PL_Backup("tab"  )
PL_Backup("F1"   )
PL_Backup("F2"   )
PL_Backup("F3"   )
PL_Backup("F4"   )
PL_Backup("F5"   )
PL_Backup("F6"   )
PL_Backup("F7"   )
PL_Backup("F8"   )
PL_Backup("F9"   )
PL_Backup("F10"  )
PL_Backup("F11"  )
PL_Backup("F12"  )
PL_Backup("enter")

; Die Modifier
;ED1S("02A","P__M2LD") ; Mod2L (ShiftL)
;ED1S("136","P__M2RD") ; Mod2R (ShiftR)
;ED1S("03A","P__M3LD") ; Mod3L (CapsLock)
PL_EDS("138",0,"P__M3RD","P__M3RD","P__M3RD","P__M3RD","P__M3RD","P__M3RD") ; Mod3R (AltGr)
}

CharProcProgT2() {
global
PL_RestoreAll()
POList := ""
;   KeyCode    Ebene1    Ebene2    Ebene3    Ebene4    Ebene5    Ebene6   Ebene7* Ebene8*
; Reihe 1
PL_EDS("029",1,"q"      ,"Q"      ,"7"      ,"T__abdt","÷"      ,"T__bldt") ; circumflex
PL_EDS("002",1,"k"      ,"K"      ,"8"      ,"ª"      ,"!"      ,"¬"      ) ; 1
PL_EDS("003",1,"o"      ,"O"      ,"9"      ,"º"      ,""""     ,"∨"      ) ; 2
PL_EDS("004",1,"i"      ,"I"      ,"0"      ,"№"      ,"\"      ,"∧"      ) ; 3
PL_EDS("005",1,"n"      ,"N"      ,"1"      ,"⋮"      ,"½"      ,"⊥"      ) ; 4
PL_EDS("006",1,"m"      ,"M"      ,"2"      ,"·"      ,"%"      ,"∡"      ) ; 5
PL_EDS("007",1,"y"      ,"Y"      ,"3"      ,"£"      ,"³"      ,"∥"      ) ; 6
PL_EDS("008",0,"$"      ,"T__tlde","4"      ,"¤"      ,"¼"      ,"→"      ) ; 7
PL_EDS("009",0,"/"      ,"@"      ,"∑"      ,""       ,"⅓"      ,"∞"      ) ; 8
PL_EDS("00A",0,"+"      ,"&"      ,"T__cron","S__NDiv","±"      ,"∝"      ) ; 9
PL_EDS("00B",0,"*"      ,"§"      ,"¤"      ,"S__NMul","×"      ,"∅"      ) ; 0
PL_EDS("00C",0,"T__drss","ß"      ,"«"      ,"S__NSub","£"      ,"­"      ) ; ß
PL_EDS("00D",0,"!"      ,"T__acut","»"      ,"T__drss","¡"      ,"T__mcrn") ; `
; Reihe 2
PL_EDS("010",1,"p"      ,"P"      ,"@"      ,"S__PgUp","'"      ,"Ξ"      ) ; q
PL_EDS("011",1,"w"      ,"W"      ,"["      ,"U000008","+"      ,"√"      ) ; w
PL_EDS("012",1,"e"      ,"E"      ,"]"      ,"S____Up","/"      ,"Λ"      ) ; e
PL_EDS("013",1,"r"      ,"R"      ,"("      ,"S___Del","#"      ,"ℂ"      ) ; r
PL_EDS("014",1,"t"      ,"T"      ,")"      ,"S__PgDn","*"      ,"Ω"      ) ; t
PL_EDS("015",1,"z"      ,"Z"      ,"5"      ,"¡"      ,"⅔"      ,"×"      ) ; z
PL_EDS("016",0,"("      ,"{"      ,"T__cedi","S__N__7","¢"      ,"Ψ"      ) ; u
PL_EDS("017",0,")"      ,"}"      ,"S____Up","S__N__8","Я"      ,"Γ"      ) ; i
PL_EDS("018",0,"="      ,"%"      ,"S__PgUp","S__N__9","‰"      ,"Φ"      ) ; o
PL_EDS("019",0,"["      ,"|"      ,"S___Del","S__NAdd","¦"      ,"ℚ"      ) ; p
PL_EDS("01A",0,">"      ,"T__grav","©"      ,"−"      ,"›"      ,"∘"      ) ; ü
PL_EDS("01B",0,"<"      ,"T__cflx","T__tlde","T__dbac","‹"      ,"T__brve") ; +
; Reihe 3
PL_EDS("01E",1,"a"      ,"A"      ,"?"      ,"S__Home","ß"      ,"⊂"      ) ; a
PL_EDS("01F",1,"s"      ,"S"      ,"."      ,"S__Left","&"      ,"∫"      ) ; s
PL_EDS("020",1,"d"      ,"D"      ,"U00000D","S__Down",":"      ,"∀"      ) ; d
PL_EDS("021",1,"f"      ,"F"      ,"U000008","S__Rght","T__mcrn","∃"      ) ; f
PL_EDS("022",1,"g"      ,"G"      ,";"      ,"S___End","T__acut","∈"      ) ; g
PL_EDS("023",1,"h"      ,"H"      ,"6"      ,"¿"      ,"™"      ,"Σ"      ) ; h
PL_EDS("024",1,"n"      ,"N"      ,"S__Left","S__N__4","æ"      ,"ℕ"      ) ; j
PL_EDS("025",1,"i"      ,"I"      ,"S__Down","S__N__5","®"      ,"ℝ"      ) ; k
PL_EDS("026",1,"o"      ,"O"      ,"S__Rght","S__N__6","→"      ,"∂"      ) ; l
PL_EDS("027",1,"e"      ,"E"      ,"ø"      ,"S__NDot","Ø"      ,"Δ"      ) ; ö
PL_EDS("028",0,"]"      ,"?"      ,"¿"      ,"."      ,"↔"      ,"∇"      ) ; ä
PL_EDS("02B",0,"'"      ,"#"      ,"T__abrg",""       ,"►"      ,""       ) ; #
; Reihe 4
PL_EDS("056",1,"x"      ,"X"      ,"|"      ,"P__M4LD",","      ,"P__M4LD") ; <>
PL_EDS("02C",1,"v"      ,"V"      ,">"      ,"U00001B","<"      ,"∪"      ) ; y
PL_EDS("02D",1,"l"      ,"L"      ,"="      ,"U000009","T__grav","∩"      ) ; x
PL_EDS("02E",1,"c"      ,"C"      ,"_"      ,"S___Ins","T__tlde","ℵ"      ) ; c
PL_EDS("02F",1,"u"      ,"U"      ,"-"      ,"U00000D","²"      ,"Π"      ) ; v
PL_EDS("030",1,"b"      ,"B"      ,"{"      ,""       ,"∞"      ,"ℤ"      ) ; b
PL_EDS("031",1,"j"      ,"J"      ,"}"      ,":"      ,"¥"      ,"⇐"      ) ; n
PL_EDS("032",0,""""     ,"\"      ,"S__Home","S__N__1","µ"      ,"⇔"      ) ; m
PL_EDS("033",0,","      ,";"      ,"S___End","S__N__2","—"      ,"⇒"      ) ; ,
PL_EDS("034",0,"."      ,":"      ,"S__PgDn","S__N__3","·"      ,"↦"      ) ; .
PL_EDS("035",0,"-"      ,"_"      ,"¯"      ,";"      ,"–"      ,"Θ"      ) ; -

; other keys
PL_Backup("space")
PL_Backup("esc"  )
PL_Backup("tab"  )
PL_Backup("F1"   )
PL_Backup("F2"   )
PL_Backup("F3"   )
PL_Backup("F4"   )
PL_Backup("F5"   )
PL_Backup("F6"   )
PL_Backup("F7"   )
PL_Backup("F8"   )
PL_Backup("F9"   )
PL_Backup("F10"  )
PL_Backup("F11"  )
PL_Backup("F12"  )
PL_Backup("enter")

; Die Modifier
;ED1S("02A","P__M2LD") ; Mod2L (ShiftL)
;ED1S("136","P__M2RD") ; Mod2R (ShiftR)
;ED1S("03A","P__M3LD") ; Mod3L (CapsLock)
PL_EDS("138",0,"P__M3RD","P__M3RD","P__M3RD","P__M3RD","P__M3RD","P__M3RD") ; Mod3R (AltGr)
}


CharProcProgT3() {
global
PL_RestoreAll()
POList := ""
;   KeyCode    Ebene1    Ebene2    Ebene3    Ebene4    Ebene5    Ebene6   Ebene7* Ebene8*
; Reihe 1
PL_EDS("029",0,"``"     ,"~"      ,"T__grav","T__abdt","T__tlde","T__bldt") ; circumflex
PL_EDS("002",0,"1"      ,"!"      ,"¡"      ,"ª"      ,"¹"      ,"¬"      ) ; 1
PL_EDS("003",0,"2"      ,"@"      ,"ª"      ,"º"      ,"²"      ,"∨"      ) ; 2
PL_EDS("004",0,"3"      ,"#"      ,"º"      ,"№"      ,"³"      ,"∧"      ) ; 3
PL_EDS("005",0,"4"      ,"$"      ,"£"      ,"⋮"      ,"¥"      ,"⊥"      ) ; 4
PL_EDS("006",0,"5"      ,"%"      ,"€"      ,"·"      ,"¢"      ,"∡"      ) ; 5
PL_EDS("007",0,"6"      ,"^"      ,"T__cflx","£"      ,"T__cron","∥"      ) ; 6
PL_EDS("008",0,"7"      ,"&"      ,"T__abrg","¤"      ,"T__mcrn","→"      ) ; 7
PL_EDS("009",0,"8"      ,"*"      ,"„"      ,""       ,"‚"      ,"∞"      ) ; 8
PL_EDS("00A",0,"9"      ,"("      ,"“"      ,"S__NDiv","‘"      ,"∝"      ) ; 9
PL_EDS("00B",0,"0"      ,")"      ,"”"      ,"S__NMul","’"      ,"∅"      ) ; 0
PL_EDS("00C",0,"-"      ,"_"      ,"©"      ,"S__NSub","№"      ,"­"      ) ; ß
PL_EDS("00D",0,"="      ,"+"      ,"×"      ,"T__drss","÷"      ,"T__mcrn") ; `
; Reihe 2
PL_EDS("010",1,"q"      ,"Q"      ,"æ"      ,"S__PgUp","Æ"      ,"Ξ"      ) ; q
PL_EDS("011",1,"w"      ,"W"      ,"å"      ,"U000008","Å"      ,"√"      ) ; w
PL_EDS("012",1,"e"      ,"E"      ,"ë"      ,"S____Up","Ë"      ,"Λ"      ) ; e
PL_EDS("013",1,"r"      ,"R"      ,"ý"      ,"S___Del","Ý"      ,"ℂ"      ) ; r
PL_EDS("014",1,"t"      ,"T"      ,"þ"      ,"S__PgDn","Þ"      ,"Ω"      ) ; t
PL_EDS("015",1,"y"      ,"Y"      ,"ÿ"      ,"¡"      ,"Ÿ"      ,"×"      ) ; z
PL_EDS("016",1,"u"      ,"U"      ,"ü"      ,"S__N__7","Ü"      ,"Ψ"      ) ; u
PL_EDS("017",1,"i"      ,"I"      ,"ï"      ,"S__N__8","Ï"      ,"Γ"      ) ; i
PL_EDS("018",1,"o"      ,"O"      ,"ö"      ,"S__N__9","Ö"      ,"Φ"      ) ; o
PL_EDS("019",1,"p"      ,"P"      ,"œ"      ,"S__NAdd","Œ"      ,"ℚ"      ) ; p
PL_EDS("01A",0,"["      ,"{"      ,"«"      ,"−"      ,"‹"      ,"∘"      ) ; ü
PL_EDS("01B",0,"]"      ,"}"      ,"»"      ,"T__dbac","›"      ,"T__brve") ; +
; Reihe 3
PL_EDS("01E",1,"a"      ,"A"      ,"ä"      ,"S__Home","Ä"      ,"⊂"      ) ; a
PL_EDS("01F",1,"s"      ,"S"      ,"ß"      ,"S__Left","§"      ,"∫"      ) ; s
PL_EDS("020",1,"d"      ,"D"      ,"õ"      ,"S__Down","Ð"      ,"∀"      ) ; d
PL_EDS("021",1,"f"      ,"F"      ,"è"      ,"S__Rght","È"      ,"∃"      ) ; f
PL_EDS("022",1,"g"      ,"G"      ,"é"      ,"S___End","É"      ,"∈"      ) ; g
PL_EDS("023",1,"h"      ,"H"      ,"ù"      ,"¿"      ,"Ù"      ,"Σ"      ) ; h
PL_EDS("024",1,"j"      ,"J"      ,"ú"      ,"S__N__4","Ú"      ,"ℕ"      ) ; j
PL_EDS("025",1,"k"      ,"K"      ,"ĳ"      ,"S__N__5","Ĳ"      ,"ℝ"      ) ; k
PL_EDS("026",1,"l"      ,"L"      ,"ø"      ,"S__N__6","Ø"      ,"∂"      ) ; l
PL_EDS("027",0,";"      ,":"      ,"T__drss","S__NDot","·"      ,"Δ"      ) ; ö
PL_EDS("028",0,"'"      ,""""     ,"T__acut","."      ,"†"      ,"∇"      ) ; ä
PL_EDS("02B",0,"\"      ,"|"      ,"¬"      ,""       ,"¦"      ,""       ) ; #
; Reihe 4
PL_EDS("02C",1,"z"      ,"Z"      ,"à"      ,"U00001B","À"      ,"∪"      ) ; y
PL_EDS("02D",1,"x"      ,"X"      ,"á"      ,"U000009","Á"      ,"∩"      ) ; x
PL_EDS("02E",1,"c"      ,"C"      ,"ç"      ,"S___Ins","Ç"      ,"ℵ"      ) ; c
PL_EDS("02F",1,"v"      ,"V"      ,"ì"      ,"U00000D","Ì"      ,"Π"      ) ; v
PL_EDS("030",1,"b"      ,"B"      ,"í"      ,""       ,"Í"      ,"ℤ"      ) ; b
PL_EDS("031",1,"n"      ,"N"      ,"ñ"      ,":"      ,"Ñ"      ,"⇐"      ) ; n
PL_EDS("032",1,"m"      ,"M"      ,"Ω"      ,"S__N__1","√"      ,"⇔"      ) ; m
PL_EDS("033",0,","      ,"<"      ,"ò"      ,"S__N__2","Ò"      ,"⇒"      ) ; ,
PL_EDS("034",0,"."      ,">"      ,"ó"      ,"S__N__3","Ó"      ,"↦"      ) ; .
PL_EDS("035",0,"/"      ,"?"      ,"¿"      ,";"      ,"…"      ,"Θ"      ) ; -

; other keys
PL_Backup("space")
PL_Backup("esc"  )
PL_Backup("tab"  )
PL_Backup("F1"   )
PL_Backup("F2"   )
PL_Backup("F3"   )
PL_Backup("F4"   )
PL_Backup("F5"   )
PL_Backup("F6"   )
PL_Backup("F7"   )
PL_Backup("F8"   )
PL_Backup("F9"   )
PL_Backup("F10"  )
PL_Backup("F11"  )
PL_Backup("F12"  )
PL_Backup("enter")

; Die Modifier
;ED1S("02A","P__M2LD") ; Mod2L (ShiftL)
;ED1S("136","P__M2RD") ; Mod2R (ShiftR)
;ED1S("03A","P__M3LD") ; Mod3L (CapsLock)
PL_EDS("056",0,"P__M4LD","P__M4LD","P__M4LD","P__M4LD","P__M4LD","P__M4LD") ; Mod4L (<>)
PL_EDS("138",0,"P__M3RD","P__M3RD","P__M3RD","P__M3RD","P__M3RD","P__M3RD") ; Mod3R (AltGr)
}

CharProcProgT0() {
  global

  ; Tastaturbelegungsvariante deaktivieren
  thekeys() ; restore key behaviors
  PL_RestoreAll()
  POList := ""
}

CharProcProgTs() {
  global

  if (isProgrammer == 0)
    IniDelete,%ini%,Global,isProgrammer
  else
    IniWrite,%isProgrammer%,%ini%,Global,isProgrammer

  if ErrorLevel
    TrayTip,Programmer-Belegungsvariante,Beim Speichern der Variante ist ein Fehler aufgetreten.,10,1
  else if (zeigeModusBox)
    TrayTip,Programmer-Belegungsvariante,Variante gespeichert.,10,1
}

ActivateProgTast() {
  global

  CP3F5  := "PProgTt" ; M3+F5: Aktiviere/Deaktiviere Programmer
  CP3F4  := "PProgTs" ; M3+F4: Speichere Programmer

  IniRead,isProgrammer,%ini%,Global,isProgrammer,0
  if (isProgrammer == 1)
    CharProcProgT1()
  else if (isProgrammer == 2)
    CharProcProgT2()
  else if (isProgrammer == 3)
    CharProcProgT3()
}

ActivateProgTast()
