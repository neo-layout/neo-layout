BSTOguiErstellt := 0
BSTOalwaysOnTop := 1
BSTOcapsChars   := 0

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

CP3F2 := "P_BSTOt"
CP3F8 := "P_BSTOA"

BSTOSwitch(Eb) {
  global
  if (Eb <> BSTOEbeneAlt) {
    BSTOeb := Eb
    if (BSTOcapsChars) {
      if (BSTOeb == "1")
        BSTOeb := "1C"
      else if (BSTOeb == "2C")
        BSTOeb := "2"
    }
    GuiControl,Show,Picture%BSTOeb%
    GuiControl,Hide,Picture%BSTOEbeneAlt%
    BSTOEbeneAlt := Eb
  }
}

BSTOOnClose() {
  global
  if (BSTOguiErstellt) {
    BSTOguiErstellt := 0
    GuiCurrent := ""
    Gui, Destroy
  }
}

BSTOToggle() {
  global
  if (BSTOguiErstellt) {
    BSTOguiErstellt := 0
    GuiCurrent := ""
    Gui, Destroy
  } else {
    if (GuiCurrent!="")
      %GuiCurrent%OnClose()

    SysGet, WorkArea, MonitorWorkArea
    yPosition := WorkAreaBottom - 230
    Gui, Color, FFFFFF
    Gui, Add, Picture,AltSubmit x0   y0          vPicture1, % ResourceFolder . "\ebene1.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture1C,% ResourceFolder . "\ebene1Caps.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture2, % ResourceFolder . "\ebene2.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture2C,% ResourceFolder . "\ebene2Caps.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture3, % ResourceFolder . "\ebene3.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture4, % ResourceFolder . "\ebene4.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture5, % ResourceFolder . "\ebene5.png"
    Gui, Add, Picture,AltSubmit xp+0 yp+0 Hidden vPicture6, % ResourceFolder . "\ebene6.png"
    Gui, +AlwaysOnTop +ToolWindow
    Gui, Show, y%yposition% w776 h200 NoActivate, NEO-Bildschirmtastatur (statisch)
    BSTOEbeneAlt := 1
    BSTOguiErstellt := 1
    BSTOSwitch(EbeneNC)
    BSTOalwaysOnTop := 1
    GuiCurrent := "BSTO"
  }
}

BSTOToggleAlwaysOnTop() {
  global
  if (BSTOalwaysOnTop) {
    Gui, -AlwaysOnTop
    BSTOalwaysOnTop := 0    
  } else {
    Gui, +AlwaysOnTop
    BSTOalwaysOnTop := 1
  }
}

CharProc_BSTOt() {
  global
  ; Bildschirmtastatur Ein/Aus
  BSTOToggle()
}

CharProc_BSTOA() {
  global
  ; Bildschirmtastatur AlwaysOnTop
  if (BSTOguiErstellt)
    BSTOToggleAlwaysOnTop()
}
