IniRead,LangSTastatur,%ini%,Global,LangSTastatur,0
If (LangSTastatur)
  CharProcLnS1()

CP3F11 := "PLnSt"

CharProcLnSt() {
  global
  ;Lang-s-Tastatur: Toggle
  LangSTastatur := !(LangSTastatur)
  if (LangSTastatur) {
    CharProcLnS1()
    if (zeigeModusBox)
      TrayTip,Lang-S-Tastatur,Die Lang-S-Belegungsvariante wurde aktiviert. Zum Deaktivieren`, Mod3+F11 drücken.,10,1
  } else {
    CharProcLnS0()
    if (zeigeModusBox)
      TrayTip,Lang-S-Tastatur,Lang-S-Belegungsvariante wurde deaktiviert.,10,1
  }
} 

CharProcLnS1() {
  global
  ; Lange-s-Tastatur aktivieren
  ED("VKBASC01A",1,"U0073","U1E9E","U00DF",""     ,"U03C2","U2218") ; ß
  ED("VK48SC023",1,"U017F","U0053","U003F","U00BF","U03C3","U03A3") ; s
  KeyboardLED(2,"on")
}

CharProcLnS0() {
  global
  ; Lange-s-Tastatur deaktivieren
  ED("VKBASC01A",1,"U00DF","U1E9E","U017F",""     ,"U03C2","U2218") ; ß
  ED("VK48SC023",1,"U0073","U0053","U003F","U00BF","U03C3","U03A3") ; s
  KeyboardLED(2,"off")
  if (zeigeModusBox)
    TrayTip,Lange-s-Tastatur,Die Lange-s-Belegungsvariante wurde aktiviert. Zum Deaktivieren`, Mod3+F11 drücken.,10,1
}

