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

ActivateQwertz() {
  global

  CP3F6   := "PQwertt"                   ; M3+F6: Aktiviere/Deaktiviere QWERTZ

  IniRead,isQwertz,%ini%,Global,isQwertz,0
  if (isQwertz == 1)
    CharProcQwerT1()
}

ActivateQwertz()
