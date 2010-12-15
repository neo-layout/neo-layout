; -*- encoding:utf-8 -*-
; NordTast. Belegung von Ulf Bro, http://www.nordtast.org/
; Aus der Neo-Welt (AdNW) von Andreas Wettstein, http://wettstae.home.solnet.ch/
; (c) 2010 Matthias Wächter

CharProcNordTt() {
  global
  ; Custom Layout togglen
  if (isNordTast == 0) {
    isNordTast := 1
    CharProcNordT1()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante NT wurde aktiviert. Zum Umschalten`, Mod3+F12 druecken.,10,1
  } else if (isNordTast == 1) {
    isNordTast := 2
    CharProcNordT2()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante AdNW wurde aktiviert. Zum Umschalten`, Mod3+F12 druecken.,10,1
  } else {
    isNordTast := 0
    CharProcNordT0()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante wurde deaktiviert.,10,1
  }
}

CharProcNordT1() {
  global
  ; Tastaturbelegungsvariante aktivieren
  ED12("010",1,"ä","Ä")
  ED12("011",1,"u","U")
  ED12("012",1,"o","O")
  ED12("013",1,"b","B")
  ED12("014",1,"p","P")
  ED12("015",1,"k","K")
  ED12("016",1,"g","G")
  ED12("017",1,"l","L")
  ED12("018",1,"m","M")
  ED12("019",1,"f","F")
  ED12("01A",1,"x","X")

  ED12("01E",1,"a","A")
  ED12("01F",1,"i","I")
  ED12("020",1,"e","E")
  ED12("021",1,"t","T")
  ED12("022",1,"c","C")
  ED12("023",1,"h","H")
  ED12("024",1,"d","D")
  ED12("025",1,"n","N")
  ED12("026",1,"r","R")
  ED12("027",1,"s","S")
  ED12("028",1,"ß","ẞ")

  ED12("02C",0,".","•")
  ED12("02D",0,",","–")
  ED12("02E",1,"ü","Ü")
  ED12("02F",1,"ö","Ö")
  ED12("030",1,"q","Q")
  ED12("031",1,"y","Y")
  ED12("032",1,"z","Z")
  ED12("033",1,"w","W")
  ED12("034",1,"v","V")
  ED12("035",1,"j","J")
}

CharProcNordT2() {
  global
  ; Tastaturbelegungsvariante Aus der Neo-Welt (AdNW) aktivieren
  ED12("010",1,"k","K")
  ED12("011",1,"u","U")
  ED12("012",1,"ü","Ü")
  ED12("013",0,".","•")
  ED12("014",1,"ä","Ä")
  ED12("015",1,"v","V")
  ED12("016",1,"g","G")
  ED12("017",1,"c","C")
  ED12("018",1,"l","L")
  ED12("019",1,"j","J")
  ED12("01A",1,"f","F")

  ED12("01E",1,"h","H")
  ED12("01F",1,"i","I")
  ED12("020",1,"e","E")
  ED12("021",1,"a","A")
  ED12("022",1,"o","O")
  ED12("023",1,"d","D")
  ED12("024",1,"t","T")
  ED12("025",1,"r","R")
  ED12("026",1,"n","N")
  ED12("027",1,"s","S")
  ED12("028",1,"ß","ẞ")

  ED12("02C",1,"x","X")
  ED12("02D",1,"y","Y")
  ED12("02E",1,"ö","Ö")
  ED12("02F",0,",","–")
  ED12("030",1,"q","Q")
  ED12("031",1,"b","B")
  ED12("032",1,"p","P")
  ED12("033",1,"w","W")
  ED12("034",1,"m","M")
  ED12("035",1,"z","Z")
}

CharProcNordT0() {
  global
  ; Tastaturbelegungsvariante deaktivieren
  ED12("010",1,"x","X")
  ED12("011",1,"v","V")
  ED12("012",1,"l","L")
  ED12("013",1,"c","C")
  ED12("014",1,"w","W")
  ED12("015",1,"k","K")
  ED12("016",1,"h","H")
  ED12("017",1,"g","G")
  ED12("018",1,"f","F")
  ED12("019",1,"q","Q")
  ED12("01A",1,"ß","ẞ")

  ED12("01E",1,"u","U")
  ED12("01F",1,"i","I")
  ED12("020",1,"a","A")
  ED12("021",1,"e","E")
  ED12("022",1,"o","O")
  ED12("023",1,"s","S")
  ED12("024",1,"n","N")
  ED12("025",1,"r","R")
  ED12("026",1,"t","T")
  ED12("027",1,"d","D")
  ED12("028",1,"y","Y")

  ED12("02C",1,"ü","Ü")
  ED12("02D",1,"ö","Ö")
  ED12("02E",1,"ä","Ä")
  ED12("02F",1,"p","P")
  ED12("030",1,"z","Z")
  ED12("031",1,"b","B")
  ED12("032",1,"m","M")
  ED12("033",0,",","–")
  ED12("034",0,".","•")
  ED12("035",1,"j","J")
}

ActivateNordTast() {
  global

  CP3F12  := "PNordTt"                   ; M3+F12: Aktiviere/Deaktiviere NordTast

  IniRead,isNordTast,%ini%,Global,isNordTast,0
  if (isNordTast == 1)
    CharProcNordT1()
  else if (isNordTast == 2)
    CharProcNordT2()
}

ActivateNordTast()
