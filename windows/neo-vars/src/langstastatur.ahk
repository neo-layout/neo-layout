; -*- encoding: utf-8 -*-

IniRead,LangSTastatur,%ini%,Global,LangSTastatur,0
If (LangSTastatur)
  CharProc__LnS1()

CP3F11 := "P__LnSt"

CharProc__LnSt() {
  global
  ; Nur aktivieren, wenn kein Qwertz aktiv ist
  if (isQwertz) {
    TrayTip,Lang-S-Tastatur,Die Lang-S-Belegungsvariante kann nicht im QWERTZ-Modus aktiviert werden.,10,1
    Return
  }
  
  ;Lang-s-Tastatur: Toggle
  LangSTastatur := !(LangSTastatur)
  if (LangSTastatur) {
    CharProc__LnS1()
    if (zeigeModusBox)
      TrayTip,Lang-S-Tastatur,Die Lang-S-Belegungsvariante wurde aktiviert. Zum Deaktivieren`, Mod3+F11 drücken.,10,1
  } else {
    CharProc__LnS0()
    if (zeigeModusBox)
      TrayTip,Lang-S-Tastatur,Lang-S-Belegungsvariante wurde deaktiviert.,10,1
  }
} 

CharProc__LnS1() {
  global
  ; Lange-s-Tastatur aktivieren
  spos := InStr(layoutstring, "s")
  eszettpos := InStr(layoutstring, "ß")
  
  ; ſ, s und ß zyklisch vertauschen auf den drei Positionen
  scpos := LOSP%spos%
  pos := vksc%scpos%
  SetKeyPos("CP1" . pos, EncodeUniComposeA("ſ"))

  scpos := LOSP%eszettpos%
  pos := vksc%scpos%
  SetKeyPos("CP1" . pos, EncodeUniComposeA("s"))

  pos := vksc01A
  SetKeyPos("CP3" . pos, EncodeUniComposeA("ß"))
}

CharProc__LnS0() {
  global
  ; Lange-s-Tastatur deaktivieren
  spos := InStr(layoutstring, "s")
  eszettpos := InStr(layoutstring, "ß")
  
  ; ſ, s und ß wieder auf die Originalpositionen setzen
  scpos := LOSP%spos%
  pos := vksc%scpos%
  SetKeyPos("CP1" . pos, EncodeUniComposeA("s"))

  scpos := LOSP%eszettpos%
  pos := vksc%scpos%
  SetKeyPos("CP1" . pos, EncodeUniComposeA("ß"))

  pos := vksc01A
  SetKeyPos("CP3" . pos, EncodeUniComposeA("ſ"))
}
