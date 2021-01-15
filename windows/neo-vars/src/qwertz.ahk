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
      TrayTip,Voreingestellte Belegungsvariante,Die voreingestellte Belegungsvariante wurde wieder aktiviert.,10,1
  }
}

CharProcQwerT1() {
  ; Tastaturbelegungsvariante QWERTZ aktivieren
  Change1256Layout("ßqwertzuiopüasdfghjklöäyxcvbnm,.-")
}

CharProcQwerT0() {
  ; Ursprüngliche Belegung wieder aktivieren
  ChangeCustomLayout()
}

CharProcQwerts() {
  global

  if (isQwertz == 0)
    IniDelete,%ini%,Global,isQwertz
  else
    IniWrite,%isQwertz%,%ini%,Global,isQwertz

  if ErrorLevel
    TrayTip,QWERTZ-Belegungsvariante,Beim Speichern der Einstellung ist ein Fehler aufgetreten.,10,1    
  else if (zeigeModusBox)
    TrayTip,QWERTZ-Belegungsvariante,Die aktuelle Einstellung wurde gespeichert.,10,1    
}

ActivateQwertz() {
  global

  CP3F6   := "PQwertt"                   ; M3+F6: Aktiviere/Deaktiviere QWERTZ
  CP4F6   := "PQwerts"                   ; M4+F6: Speichere QWERTZ

  ; Auf 1 setzen, um ohne Ini-Datei beim Start bereits Qwertz zu haben
  IniRead,isQwertz,%ini%,Global,isQwertz,0
  if (isQwertz == 1)
    CharProcQwerT1()
}

ActivateQwertz()
