guiErstellt := 0
alwaysOnTop := 1

if (FileExist("ResourceFolder")<>false) {
  FileInstall,ebene1.png,%ResourceFolder%\ebene1.png,1
  FileInstall,ebene1Caps.png,%ResourceFolder%\ebene1Caps.png,1
  FileInstall,ebene2.png,%ResourceFolder%\ebene2.png,1
  FileInstall,ebene2Caps.png,%ResourceFolder%\ebene2Caps.png,1
  FileInstall,ebene3.png,%ResourceFolder%\ebene3.png,1
  FileInstall,ebene4.png,%ResourceFolder%\ebene4.png,1
  FileInstall,ebene5.png,%ResourceFolder%\ebene5.png,1
  FileInstall,ebene6.png,%ResourceFolder%\ebene6.png,1
}

CP3F1 := "PBSTt"
CP3F8 := "PBSTA"

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
    Gui, Add, Picture,AltSubmit x0   y0          vPicture1, % ResourceFolder . "\ebene1.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture1C,% ResourceFolder . "\ebene1Caps.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture2, % ResourceFolder . "\ebene2.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture2C,% ResourceFolder . "\ebene2Caps.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture3, % ResourceFolder . "\ebene3.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture4, % ResourceFolder . "\ebene4.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture5, % ResourceFolder . "\ebene5.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture6, % ResourceFolder . "\ebene6.png"
    Gui, +AlwaysOnTop
    Gui, Show, y%yposition% Autosize
    BSTEbeneAlt := 1
    guiErstellt := 1
    BSTSwitch(EbeneNC)
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

CharProcBSTt() {
  global
  ; Bildschirmtastatur Ein/Aus
  BSTToggle()
}

CharProcBSTA() {
  global
  ; Bildschirmtastatur AlwaysOnTop
  if (guiErstellt)
    BSTToggleAlwaysOnTop()
}

