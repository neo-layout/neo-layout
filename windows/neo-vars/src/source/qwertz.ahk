; -*- encoding:utf-8 -*-
; QWERTZ
; (c) 2011 Matthias Wächter

CharProcQwertT() {
  global
  ; Custom Layout togglen
  if (isQwertz == 0) {
    isQwertz := 1
    CharProcQwerT1()
    if (zeigeModusBox)
      TrayTip,QWERTZ-Belegungsvariante,Die Belegungsvariante QWERTZ wurde aktiviert. Zum Umschalten`, Mod3+F6 drücken.,10,1
  } else {
    isQwertz := 0
    CharProcQwerT0()
    if (zeigeModusBox)
      TrayTip,QWERTZ-Belegungsvariante,Die Belegungsvariante wurde deaktiviert.,10,1
  }
}

CharProcQwerT1() {
  ; Tastaturbelegungsvariante QWERTZ aktivieren
  Change1256Layout("ßqwertzuiopüasdfghjklöäyxcvbnm,.-")
}

CharProcQwerT0() {
  ; Tastaturbelegungsvariante deaktivieren
  Change1256LayoutNeo20()
}

CharProcQwerts() {
  global

  if (isQwertz == 0)
    IniDelete,%ini%,Global,isQwertz
  else
    IniWrite,%isQwertz%,%ini%,Global,isQwertz

  if ErrorLevel
    TrayTip,Qwertz-Belegungsvariante,Beim Speichern der Variante ist ein Fehler aufgetreten.,10,1    
  else if (zeigeModusBox)
    TrayTip,Qwertz-Belegungsvariante,Variante gespeichert.,10,1    
}

ActivateQwertz() {
  global

  CP3F6   := "PQwertt"                   ; M3+F6: Aktiviere/Deaktiviere QWERTZ
  CP4F6   := "PQwerts"                   ; M4+F6: Speichere QWERTZ

  IniRead,isQwertz,%ini%,Global,isQwertz,0
  if (isQwertz == 1)
    CharProcQwerT1()
}

ActivateQwertz()
