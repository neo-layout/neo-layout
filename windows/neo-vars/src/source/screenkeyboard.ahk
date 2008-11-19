BSTSwitch(Eb) {
  global
  if (Eb <> EbeneAlt) {
    GuiControl,Show,Picture%Eb%
    GuiControl,Hide,Picture%EbeneAlt%
    EbeneAlt := Eb
  }
}

BSTToggle() {
  global
  if (guiErstellt) {
    guiErstellt := 0
    Gui, Destroy
  } else {
    yPosition := A_ScreenHeight -270
    Gui, Color, FFFFFF
    Gui, Add, Picture,AltSubmit x0   y0   w729 h199        vPicture1, % ResourceFolder . "\ebene1.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 w729 h199 Hidden vPicture2, % ResourceFolder . "\ebene2.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 w729 h199 Hidden vPicture3, % ResourceFolder . "\ebene3.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 w729 h199 Hidden vPicture4, % ResourceFolder . "\ebene4.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 w729 h199 Hidden vPicture5, % ResourceFolder . "\ebene5.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 w729 h199 Hidden vPicture6, % ResourceFolder . "\ebene6.png"
    Gui, +AlwaysOnTop
    Gui, Show, y%yposition% Autosize
    BSTEbeneAlt := 1
    guiErstellt := 1
    BSTSwitch(EbeneC)
    alwaysOnTop := 1
  }
}

BSTToggleAlwaysOnTop() {
  global
  if (alwaysOnTop) {
    Gui, -AlwaysOnTop
    alwaysOnTop := 0    
  } else {
    Gui, +AlwaysOnTop
    alwaysOnTop := 1
  }
}
