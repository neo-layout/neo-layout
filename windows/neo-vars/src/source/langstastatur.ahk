; -*- encoding: utf-8 -*-

IniRead,LangSTastatur,%ini%,Global,LangSTastatur,0
If (LangSTastatur)
  CharProc__LnS1()

CP3F11 := "P__LnSt"

CharProc__LnSt() {
  global
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
  ED("VKBASC01A",1,"U000073","U001E9E","U0000DF",""       ,"U0003C2","U002218") ; ß
  ED("VK48SC023",1,"U00017F","U000053","U00003F","U0000BF","U0003C3","U0003A3") ; s
  NEONumLockLEDState := "On"
  UpdateNEOLEDS()
}

CharProc__LnS0() {
  global
  ; Lange-s-Tastatur deaktivieren
  ED("VKBASC01A",1,"U0000DF","U001E9E","U00017F",""       ,"U0003C2","U002218") ; ß
  ED("VK48SC023",1,"U000073","U000053","U00003F","U0000BF","U0003C3","U0003A3") ; s
  NEONumLockLEDState := "Off"
  UpdateNEOLEDS()
  if (zeigeModusBox)
    TrayTip,Lange-s-Tastatur,Die Lange-s-Belegungsvariante wurde aktiviert. Zum Deaktivieren`, Mod3+F11 drücken.,10,1
}

