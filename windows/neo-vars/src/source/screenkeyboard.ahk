BSTguiErstellt := 0
BSTalwaysOnTop := 1
BSTcapsChars   := 0

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

CP3F1 := "P__BSTt"
CP3F8 := "P__BSTA"

BSTSwitch(Eb) {
  global
  if (Eb <> BSTEbeneAlt) {
    BSTeb := Eb
    if (BSTcapsChars) {
      if (BSTeb == "1")
        BSTeb := "1C"
      else if (BSTeb == "2C")
        BSTeb := "2"
    }
    GuiControl,Show,Picture%BSTeb%
    GuiControl,Hide,Picture%BSTEbeneAlt%
    BSTEbeneAlt := Eb
  }
}

BSTOnClose() {
  global
  if (BSTguiErstellt) {
    BSTguiErstellt := 0
    GuiCurrent := ""
    Gui, Destroy
  }
}

BSTToggle() {
  global
  if (BSTguiErstellt) {
    BSTguiErstellt := 0
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
    Gui, Show, y%yposition% w776 h200 NoActivate, NEO-Bildschirmtastatur
    BSTEbeneAlt := 1
    BSTguiErstellt := 1
    BSTSwitch(EbeneNC)
    BSTalwaysOnTop := 1
    GuiCurrent := "BST"
  }
}

BSTToggleAlwaysOnTop() {
  global
  if (BSTalwaysOnTop) {
    Gui, -AlwaysOnTop
    BSTalwaysOnTop := 0    
  } else {
    Gui, +AlwaysOnTop
    BSTalwaysOnTop := 1
  }
}

CharProc__BSTt() {
  global
  ; Bildschirmtastatur Ein/Aus
  BSTToggle()
}

CharProc__BSTA() {
  global
  ; Bildschirmtastatur AlwaysOnTop
  if (BSTguiErstellt)
    BSTToggleAlwaysOnTop()
}
