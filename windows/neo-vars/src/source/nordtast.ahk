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
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante NT wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else if (isNordTast == 1) {
    isNordTast := 2
    CharProcNordT2()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante AdNW wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else if (isNordTast == 2) {
    isNordTast := 3
    CharProcNordT3()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante DIEgO wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else if (isNordTast == 3) {
    isNordTast := 4
    CharProcNordT4()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante K.O`,Y wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else {
    isNordTast := 0
    CharProcNordT0()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante wurde deaktiviert.,10,1
  }
}

CharProcNordT1() {
  ; Tastaturbelegungsvariante NordTast aktivieren
  Change1256Layout("-äuobpkglmfxaietchdnrsß.,üöqyzwvj")
}

CharProcNordT2() {
  ; Tastaturbelegungsvariante Aus der Neo-Welt (AdNW) aktivieren
  Change1256Layout("-kuü.ävgcljfhieaodtrnsßxyö,qbpwmz")
}

CharProcNordT3() {
  ; Tastaturbelegungsvariante DIEgO aktivieren
  Change1256Layout("-puü.äjclhxzdieaogtrnsßkyö,qmvwbf")
}

CharProcNordT4() {
  ; Tastaturbelegungsvariante K.O,Y aktivieren
  Change1256Layout("-k.o,yvgclßzhaeiudtrnsfxqäüöbpwmj")
}

CharProcNordT0() {
  ; Tastaturbelegungsvariante deaktivieren
  Change1256LayoutNeo20()
}

CharProcNordTs() {
  global

  if (isNordTast == 0)
    IniDelete,%ini%,Global,isNordTast
  else
    IniWrite,%isNordTast%,%ini%,Global,isNordTast

  if ErrorLevel
    TrayTip,NordTast-Belegungsvariante,Beim Speichern der Variante ist ein Fehler aufgetreten.,10,1    
  else if (zeigeModusBox)
    TrayTip,NordTast-Belegungsvariante,Variante gespeichert.,10,1    
}

ActivateNordTast() {
  global

  CP3F12  := "PNordTt"                   ; M3+F12: Aktiviere/Deaktiviere NordTast
  CP4F12  := "PNordTs"                   ; M4+F12: Speichere NordTast

  IniRead,isNordTast,%ini%,Global,isNordTast,0
  if (isNordTast == 1)
    CharProcNordT1()
  else if (isNordTast == 2)
    CharProcNordT2()
  else if (isNordTast == 3)
    CharProcNordT3()
  else if (isNordTast == 4)
    CharProcNordT4()
}

ActivateNordTast()
