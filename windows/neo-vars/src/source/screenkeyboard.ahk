; -*- encoding:utf-8 -*-

BSTalwaysOnTop := 1

UniFontVersion  := "2.33"
UniFontFilename := "DejaVuSans-Bold.ttf"
UniFontName     := "DejaVu Sans"

UniFontZipFilename   := "dejavu-fonts-ttf-" . UniFontVersion . ".zip"
UniFontZipLocalFile  := ResourceFolder . "\" . UniFontZipFilename

UniFontZipSourceLink := "http://downloads.sourceforge.net/project/dejavu/dejavu/" . UniFontVersion . "/" . UniFontZipFilename

UniFontLocalFilePath := ApplicationFolder
UniFontLocalFile := UniFontLocalFilePath . "\" . UniFontFilename
UniFontZipFontPath := "dejavu-fonts-ttf-" . UniFontVersion . "\ttf\" . UniFontFilename

BSTlayout_0_image := "ebene0.png"
BSTlayout_0_width := 729
BSTlayout_0_height := 199

BSTlayout_1_image := "ergodox.png"
BSTlayout_1_width := 700
BSTlayout_1_height := 300

Check_BSTUpdate(DoBSTUpdate = 0) {
  global
  if (useDBST) {
    if (!useBST and ((Comp != "") or (EbeneC == 5) or (EbeneC == 6))) {
      useBST := 1
      BSTLastComp := ""
      CharProc__BST1()
    } else if (useBST and ((Comp == "") and (EbeneC != 5) and (EbeneC != 6))) {
      useBST := 0
      BSTLastComp := ""
      CharProc__BST0()
    }
  }
  if (useBST
      and (DoBSTUpdate
           or (Comp != BSTLastComp)
           or (EbeneC != BSTLastEbeneC)
           or (EbeneNC != BSTLastEbeneNC)))
    BSTUpdate()
}

BSTUpdate() {
    global
    static WM_SETTEXT := 0x0C
    {
      BSTLastComp := Comp
      BSTLastEbeneC := EbeneC
      BSTLastEbeneNC := EbeneNC
      VarSetCapacity(ptrU,20)
      loop,parse,GuiKeyList,`,
      {
        GuiPhysKey := A_LoopField
        if (EbeneC<3) {
          if (NOC%GuiPhysKey%==1) {
            GuiEb := EbeneNC
          } else {
            GuiEb := EbeneC
          }
        } else
          GuiEb := EbeneC
        if (TransformBSTProc != "")
          GuiVirtKey := TransformBST%TransformBSTProc%(GuiPhysKey)
        else
          GuiVirtKey := GuiPhysKey
        CurrentComp := Comp
        GuiComp := ""
rerun_bstnupdate:
        GuiComp1 := CurrentComp . CP%GuiEb%%GuiVirtKey%
        if (GSYM%GuiComp1% != "") {
          GuiComp .= GSYM%GuiComp1%
        } else if (CD%GuiComp1% != "") {
          G_Sym    := CD%GuiComp1%
          if (GSYM%G_Sym% != "")
            GuiComp .= GSYM%G_sym%
          else
            GuiComp .= CD%GuiComp1%
        } else if (CM%GuiComp1% == 1) {
          GuiComp .= "U00002AU00002A"
        } else if (CF%CurrentComp% != "") {
          if (IM%GuiVirtKey% != 1)
            GuiComp .= CF%CurrentComp%
          CurrentComp := ""
          goto rerun_bstnupdate
        } else if (CurrentComp == "") {
          GuiComp .= GuiComp1
        }
        GuiPos := 0
        loop {
          if (GuiComp=="")
            break
          if (SubStr(GuiComp,1,1)=="U") {
            Charcode := "0x" . Substr(GuiComp,2,6)
              if (charCode < 0x10000) {
                if (charCode == 0x26) {
                  ; double any Ampersand (&) to avoid being replaced with
                  ; underscore (Windows Shortcut Key terminology)
                  NumPut(CharCode, ptrU, GuiPos, "UShort")
                  GuiPos := GuiPos + 2
                }
                NumPut(CharCode, ptrU, GuiPos, "UShort")
              } else {
                ; surrogates
                NumPut(0xD800|((charCode-0x10000)/1024) , ptrU, GuiPos, "UShort")
                GuiPos := GuiPos + 2
                NumPut(0xDC00|((charCode-0x10000)&0x3FF), ptrU, GuiPos, "UShort")
              }
            GuiPos := GuiPos + 2
          }
          GuiComp := SubStr(GuiComp,8)
        }
        NumPut(0x0   ,ptrU,GuiPos,"UShort") ; End of string
        DllCall("SendMessageW", "UInt",GuiKey%GuiPhysKey%, "UInt",WM_SETTEXT, "UInt",0, "Uint",&ptrU)
      }
    }
    GuiControl,MoveDraw,Picture0
}

GuiAddKeyS(sc,x,y) {
  global
  GuiAddKey(vksc%sc%,x,y)
}

GuiAddKeySM(sc,x,y) {
  global
  vksc := vksc%sc%
  IM%vksc% := 1
  GuiAddKey(vksc,x,y)
}

GuiAddKeySN(sc,x,y) {
  global
  GuiAddKey(vkscn1%sc%,x,y)
}

GuiAddKey(key,x,y) {
  global
  if (bstLayout == 0) {
    x:=x-4
  }
  GuiPosx%key% := x
  GuiPosy%key% := y
  Gui, Add, Text, x%x% y%y% w38 h38 Center 0x200 vGuiKey%key% hwndGuiKey%key% BackgroundTrans
  GuiKeyList := GuiKeyList . key . ","
}

CharProc__BSTt() {
  global
  ; Bildschirmtastatur togglen
  useBST := !(useBST)
  if (useBST)
    CharProc__BST1()
  else
    CharProc__BST0()
}

CharProc_DBSTt() {
  global
  useDBST := !(useDBST)
  if (useDBST) {
    if (zeigeModusBox)
      TrayTip,Dynamische Bildschirmtastatur,Die dynamische Bildschirmtastatur wurde aktiviert. Zum Deaktivieren`, Mod3+F3 drücken.,10,1
  } else {
    if (zeigeModusBox)
      TrayTip,Dynamische Bildschirmtastatur,Die dynamische Bildschirmtastatur wurde deaktiviert.,10,1
  }
}

BSTOnClose() {
  global
  useBST := 0
  CharProc__BST0()
}

BSTOnSize() {
  global
  xSize := BSTlayout_%bstLayout%_width
  ySize := BSTlayout_%bstLayout%_height
  guiWidth := A_GuiWidth
  yPosition := WorkAreaBottom - Round(guiWidth*ySize/xSize,0)
  Gui, Show, % "Y" . yPosition . " W" . guiWidth . " H" . Round(guiWidth*ySize/xSize,0) . " NoActivate", Neo-Bildschirmtastatur
  Gui, Font, % "s" . Round(guiWidth*12/xSize,0) . " bold", % UniFontName
  loop,parse,GuiKeyList,`,
  {
    GuiPhysKey := A_LoopField
    GuiControl,Font,GuiKey%GuiPhysKey%
    GuiControl,Move,GuiKey%GuiPhysKey%, % "x" . Round(GuiPosx%GuiPhysKey%*guiWidth/xSize,0) . " y" . Round(GuiPosy%GuiPhysKey%*guiWidth/xSize,0) . " w" . Round(38*guiWidth/xSize,0) . " h" . Round(38*guiWidth/xSize,0)
  }
  GuiControl,,Picture0, % "*w" . guiWidth * 1.0 . " *h-1 " . ResourceFolder . "\" . BSTlayout_%bstLayout%_image
}

CharProc__BST0() {
  global
  GuiCurrent := ""
  Gui, Destroy
  DllCall( "GDI32.DLL\RemoveFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)
}

Copy_Async(sourcefile, destpath)
{
    ComObjCreate("Shell.Application").Namespace(destpath).CopyHere(sourcefile,4|16)
}

BSTnormalLayout() {
  global
  GuiAddKeyS("029",6,0)
  GuiAddKeyS("002",44,0)
  GuiAddKeyS("003",82,0)
  GuiAddKeyS("004",120,0)
  GuiAddKeyS("005",158,0)
  GuiAddKeyS("006",196,0)
  GuiAddKeyS("007",234,0)
  GuiAddKeyS("008",272,0)
  GuiAddKeyS("009",310,0)
  GuiAddKeyS("00A",348,0)
  GuiAddKeyS("00B",386,0)
  GuiAddKeyS("00C",424,0)
  GuiAddKeyS("00D",462,0)
  GuiAddKey("backspace",510,0)

  GuiAddKey("tab",10,40)
  GuiAddKeyS("010",58,40)
  GuiAddKeyS("011",96,40)
  GuiAddKeyS("012",134,40)
  GuiAddKeyS("013",172,40)
  GuiAddKeyS("014",210,40)
  GuiAddKeyS("015",248,40)
  GuiAddKeyS("016",286,40)
  GuiAddKeyS("017",324,40)
  GuiAddKeyS("018",362,40)
  GuiAddKeyS("019",400,40)
  GuiAddKeyS("01A",438,40)
  GuiAddKeyS("01B",476,40)
  GuiAddKey("enter",526,60)

  GuiAddKeySM("03A",18,80)
  GuiAddKeyS("01E",75,80)
  GuiAddKeyS("01F",113,80)
  GuiAddKeyS("020",151,80)
  GuiAddKeyS("021",189,80)
  GuiAddKeyS("022",227,80)
  GuiAddKeyS("023",265,80)
  GuiAddKeyS("024",303,80)
  GuiAddKeyS("025",341,80)
  GuiAddKeyS("026",379,80)
  GuiAddKeyS("027",417,80)
  GuiAddKeyS("028",455,80)
  GuiAddKeySM("02B",493,80)

  GuiAddKeySM("02A",8,120)
  GuiAddKeySM("056",50,120)
  GuiAddKeyS("02C",88,120)
  GuiAddKeyS("02D",126,120)
  GuiAddKeyS("02E",164,120)
  GuiAddKeyS("02F",202,120)
  GuiAddKeyS("030",240,120)
  GuiAddKeyS("031",278,120)
  GuiAddKeyS("032",316,120)
  GuiAddKeyS("033",354,120)
  GuiAddKeyS("034",392,120)
  GuiAddKeyS("035",430,120)
  GuiAddKeySM("136",498,120)

  GuiAddKey("space",264,160)
  GuiAddKeySM("138",430,160)

  GuiAddKeyS("145",582,0)
  GuiAddKeyS("135",620,0)
  GuiAddKeyS("037",658,0)
  GuiAddKeyS("04A",696,0)

  GuiAddKeySN("047",582,40)
  GuiAddKeySN("048",620,40)
  GuiAddKeySN("049",658,40)
  GuiAddKeyS("04E",696,60)

  GuiAddKeySN("04B",582,80)
  GuiAddKeySN("04C",620,80)
  GuiAddKeySN("04D",658,80)

  GuiAddKeySN("04F",582,120)
  GuiAddKeySN("050",620,120)
  GuiAddKeySN("051",658,120)
  GuiAddKey("numpadenter",696,140)

  GuiAddKeySN("052",601,160)
  GuiAddKeySN("053",658,160)
}

BSTergodoxLayout() {
  global
  ;GuiAddKeyS("029",6,9)
  GuiAddKeyS("001",10,20)
  GuiAddKeyS("002",60,20)
  GuiAddKeyS("003",100,10)
  GuiAddKeyS("004",140,00)
  GuiAddKeyS("005",180,10)
  GuiAddKeyS("006",220,20)
  GuiAddKeySM("029",260,20) ; moved
  GuiAddKeyS("00D",400,20) ; moved
  GuiAddKeyS("007",440,20)
  GuiAddKeyS("008",480,10)
  GuiAddKeyS("009",520,00)
  GuiAddKeyS("00A",560,10)
  GuiAddKeyS("00B",600,20)
  GuiAddKeyS("00C",650,20)
  ;GuiAddKeyS("00D",462,9)
  ;GuiAddKey("backspace",510,9)

  GuiAddKey("tab",10,60)
  GuiAddKeyS("010",60,60)
  GuiAddKeyS("011",100,50)
  GuiAddKeyS("012",140,40)
  GuiAddKeyS("013",180,50)
  GuiAddKeyS("014",220,60)
  GuiAddKeyS("01B",400,70) ; moved
  GuiAddKeyS("015",440,60)
  GuiAddKeyS("016",480,50)
  GuiAddKeyS("017",520,40)
  GuiAddKeyS("018",560,50)
  GuiAddKeyS("019",600,60)
  GuiAddKeyS("01A",650,60)
  ;GuiAddKeyS("01B",476,48)
  ;GuiAddKey("enter",526,68)

  GuiAddKeyS("056",10,100) ; moved
  ;GuiAddKeySM("03A",18,88)
  GuiAddKeyS("01E",60,100)
  GuiAddKeyS("01F",100,90)
  GuiAddKeyS("020",140,80)
  GuiAddKeyS("021",180,90)
  GuiAddKeyS("022",220,100)
  GuiAddKeyS("023",440,100)
  GuiAddKeyS("024",480,90)
  GuiAddKeyS("025",520,80)
  GuiAddKeyS("026",560,90)
  GuiAddKeyS("027",600,100)
  GuiAddKeyS("028",650,100)
  ;GuiAddKeySM("02B",493,88)

  GuiAddKeySM("02A",10,140)
  ;GuiAddKeySM("056",50,128)
  GuiAddKeyS("02C",60,140)
  GuiAddKeyS("02D",100,130)
  GuiAddKeyS("02E",140,120)
  GuiAddKeyS("02F",180,130)
  GuiAddKeyS("030",220,140)
  GuiAddKeyS("031",440,140)
  GuiAddKeyS("032",480,130)
  GuiAddKeyS("033",520,120)
  GuiAddKeyS("034",560,130)
  GuiAddKeyS("035",600,140)
  GuiAddKeySM("136",650,140)

  GuiAddKeySM("03A",180,170) ; moved
  GuiAddKeySM("02B",480,170)

  GuiAddKey("space",220,240)
  GuiAddKey("backspace",400,240) ; moved
  GuiAddKey("enter",440,240) ; moved
}

CharProc__BST1() {
  global
  if (GuiCurrent!="")
    %GuiCurrent%OnClose()

  if (FileExist(ResourceFolder)!="") {
    FileInstall,ebene0.png,%ResourceFolder%\%BSTlayout_0_image%,1
    FileInstall,ergodox.png,%ResourceFolder%\%BSTlayout_1_image%,1
  }

  if (FileExist(UniFontLocalFile)=="") {
    Msgbox, 4, NeoVars-Bildschirmtastatur, Wollen Sie die für die Bildschirmtastatur notwendigen Dateien herunterladen?
    ifMsgBox, No
      Return

    Progress,0,Herunterladen der gepackten Font-Datei ...
    if (FileExist(UniFontZipLocalFile)=="") {
      UrlDownloadToFile,%UniFontZipSourceLink%,%UniFontZipLocalFile%
    }

    if (FileExist(UniFontZipLocalFile)=="") {
      Progress,100,Fehler. Konnte gepackte Font-Datei nicht herunterladen.
      return
    }

    Progress,50,Entpacken des Archivs ...
    Copy_Async(UniFontZipLocalFile . "\" . UniFontZipFontPath, UniFontLocalFilePath)
    i := 0
    loop {
      Progress,% 50+i,Entpacken des Archivs ...
      sleep 200
      if (FileExist(UniFontLocalFile)!="") {
        Progress,75,Fertig
        break
      }
      i := i+1
      if (i > 20) {
        Progress,100,Fehler
        sleep 500
        break
      }
    }
    ; 4 Sekunden sollten reichen. Wenn nicht, Abbruch.
    if (FileExist(UniFontLocalFile)=="") {
      Progress,OFF
      MsgBox,Font-Datei %UniFontLocalFile% existiert nicht. Abbruch.
      return
    }
    Progress,90,Entferne Archiv-Datei ...
    FileDelete,%UniFontZipLocalFile%
    Sleep,200
    Progress,100,Fertig!
    Sleep,2000
    Progress,OFF
  }

  DllCall( "GDI32.DLL\AddFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)


  SysGet, WorkArea, MonitorWorkArea
  xSize := BSTlayout_%bstLayout%_width
  ySize := BSTlayout_%bstLayout%_height
  yPosition := WorkAreaBottom - ySize
  Gui, Color, FFFFFF
  Gui, Add, Picture,AltSubmit x0 y0 +BackgroundTrans vPicture0, % ResourceFolder . "\" . BSTlayout_%bstLayout%_image
  Gui, Font, s12 bold, %UniFontName%
  GuiKeyList := ""

  if (bstLayout == 0) {
      BSTnormalLayout()
  }
  else {
      BSTergodoxLayout()
  }

  Gui, +AlwaysOnTop +LastFound +Resize +ToolWindow -0x40000 -DPIScale -Caption -MaximizeBox
  Gui, Show, % "y" . yPosition . " w" . xSize . " h" . ySize . " NoActivate", Neo-Bildschirmtastatur
  WinSet, TransColor, White, Neo-Bildschirmtastatur
  BSTUpdate()
  BSTalwaysOnTop := 1
  OnMessage(0x201, "WM_LBUTTONDOWN")
  GuiCurrent := "BST"
}

WM_LBUTTONDOWN()
{
  PostMessage, 0xA1, 2
}

BSTToggleAlwaysOnTop() {
  global
  if (BSTalwaysOnTop) {
    Gui, -AlwaysOnTop
    WinSet, Style, +0x40000, Neo-Bildschirmtastatur
    BSTalwaysOnTop := 0
  } else {
    Gui, +AlwaysOnTop
    WinSet, Style, -0x40000, Neo-Bildschirmtastatur
    BSTalwaysOnTop := 1
  }
}

BSTToggleKeyboardLayout() {
  global
  if (0 == bstLayout) {
    bstLayout := 1
  } else {
    bstLayout := 0
  }
  IniWrite,%bstLayout%,%ini%,Global,bstLayout
  CharProc__BST0()
  CharProc__BST1()
}

CharProc__BSTA() {
  global
  ; Bildschirmtastatur AlwaysOnTop
  if (useBST or useDBST)
    BSTToggleAlwaysOnTop()
}

CharProc__BSTK() {
  global
  ; Bildschirmtastatur Layout
  if (useBST or useDBST)
    BSTToggleKeyboardLayout()
}

GUISYM(sym,chars) {
  global
  GSYM%sym% := EncodeUniComposeA(chars)
}

BSTSymbols() {
  global
  ; diverse Symbole für Spezialzeichen
  GUISYM("T__cflx","◌̂")
  GUISYM("T__cron","◌̌")
  GUISYM("T__turn","↻")
  GUISYM("T__abdt","◌̇")
  GUISYM("T__hook","◌˞") ; not perfect
  GUISYM("T__bldt",".") ; not perfect

  GUISYM("T__grav","◌̀")
  GUISYM("T__cedi","◌̧")
  GUISYM("T__abrg","◌̊")
  GUISYM("T__drss","◌̈")
  GUISYM("T_dasia","◌῾") ; not perfect
  GUISYM("T__mcrn","◌̄")

  GUISYM("T__acut","◌́")
  GUISYM("T__tlde","◌̃")
  GUISYM("T__strk","◌̷")
  GUISYM("T__dbac","◌̋")
  GUISYM("T_psili","◌᾿") ; not perfect
  GUISYM("T__brve","◌̆")



  GUISYM("S__Sh_L","⇧")
  GUISYM("S__Sh_R","⇧")
  GUISYM("S__Caps","⇪")
  GUISYM("S___Del","⌦")
  GUISYM("S___Ins","⎀")
  GUISYM("S____Up","⇡")
  GUISYM("S__Down","⇣")
  GUISYM("S__Rght","⇢")
  GUISYM("S__Left","⇠")
  GUISYM("S__PgUp","⇞")
  GUISYM("S__PgDn","⇟")
  GUISYM("S__Home","↸")
  GUISYM("S___End","⇲")

  GUISYM("S__N__0","0")
  GUISYM("S__N__1","1")
  GUISYM("S__N__2","2")
  GUISYM("S__N__3","3")
  GUISYM("S__N__4","4")
  GUISYM("S__N__5","5")
  GUISYM("S__N__6","6")
  GUISYM("S__N__7","7")
  GUISYM("S__N__8","8")
  GUISYM("S__N__9","9")
  GUISYM("S__NDiv","÷")
  GUISYM("S__NMul","×")
  GUISYM("S__NSub","-")
  GUISYM("S__NAdd","+")
  GUISYM("S__NDot",",")
  GUISYM("S__NEnt","⏎")

  GUISYM("S__NDel","⌦")
  GUISYM("S__NIns","⎀")
  GUISYM("S__N_Up","⇡")
  GUISYM("S__N_Dn","⇣")
  GUISYM("S__N_Ri","⇢")
  GUISYM("S__N_Le","⇠")
  GUISYM("S__NPUp","⇞")
  GUISYM("S__NPDn","⇟")
  GUISYM("S__NHom","↸")
  GUISYM("S__NEnd","⇲")

  GUISYM("S_SNDel","⌦")
  GUISYM("S_SNIns","⎀")
  GUISYM("S_SN_Up","⇡")
  GUISYM("S_SN_Dn","⇣")
  GUISYM("S_SN_Ri","⇢")
  GUISYM("S_SN_Le","⇠")
  GUISYM("S_SNPUp","⇞")
  GUISYM("S_SNPDn","⇟")
  GUISYM("S_SNHom","↸")
  GUISYM("S_SNEnd","⇲")

  GUISYM("U00001B","⌧")
  GUISYM("U000008","⌫")
  GUISYM("U000009","↹")
  GUISYM("U00000D","⏎")

  GUISYM("P__M2LD","⇧")
  GUISYM("P__M2RD","⇧")
  GUISYM("P__M3LD","M3")
  GUISYM("P__M3RD","M3")
  GUISYM("P__M4LD","M4")
  GUISYM("P__M4RD","M4")

  GUISYM("U000020","␣")
  GUISYM("U0000A0","⍽")
  GUISYM("U00202F",">⍽<")
}

BSTRegister() {
  global

  CP3F1 := "P__BSTt" ; toggle on screen keyboard
  CP4F1 := "P__BSTK" ; toggle keyboard layout
  CP3F2 := "P__BSTA" ; toggle always on top
  CP3F3 := "P_DBSTt" ; toggle
  BSTSymbols()

  IniRead,bstLayout,%ini%,Global,bstLayout,0
  IniRead,useBST,%ini%,Global,useBST,0
  if (useBST)
    CharProc__BST1()

  IniRead,useDBST,%ini%,Global,useDBST,0
}

BSTRegister()
