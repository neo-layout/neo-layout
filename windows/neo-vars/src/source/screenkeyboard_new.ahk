; -*- encoding:utf-8 -*-

BSTNguiErstellt := 0
BSTNalwaysOnTop := 1

UnZipLocalFile := ResourceFolder . "\unzip.exe"
UnZipSourceLink := "http://stahlworks.com/dev/unzip.exe"

UniFontVersion  := "2.30"
UniFontFilename := "DejaVuSans-Bold.ttf"
UniFontName     := "DejaVu Sans"

UniFontZipFilename   := "dejavu-fonts-ttf-" . UniFontVersion . ".zip"
UniFontZipLocalFile  := ResourceFolder . "\" . UniFontZipFilename

UniFontZipSourceLink := "http://downloads.sourceforge.net/project/dejavu/dejavu/" . UniFontVersion . "/" . UniFontZipFilename

UniFontLocalFilePath := ApplicationFolder
UniFontLocalFile := UniFontLocalFilePath . "/" . UniFontFilename
UniFontZipFontPath := "dejavu-fonts-ttf-" . UniFontVersion . "/ttf/" . UniFontFilename

BSTNUpdate() {
    global
    static WM_SETTEXT := 0x0C
    {
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
	CurrentComp := Comp
        GuiComp := ""
rerun_bstnupdate:
        GuiComp1 := CurrentComp . CP%GuiEb%%GuiPhysKey%
        if (GSYM%GuiComp1% != "") {
          GuiComp .= GSYM%GuiComp1%
        } else if (CD%GuiComp1% != "") {
          GuiComp .= CD%GuiComp1%
        } else if (CM%GuiComp1% == 1) {
          GuiComp .= "U00002AU00002A"
        } else if (CF%CurrentComp% != "") {
	  if (IM%GuiPhysKey% != 1)
            GuiComp .= CF%CurrentComp%
	  CurrentComp := ""
          goto rerun_bstnupdate
        } else if (CurrentComp = "") {
          GuiComp .= GuiComp1
        }
	GuiPos := 0
        loop {
          if (GuiComp=="")
            break
	  if (SubStr(GuiComp,1,1)=="U") {
            Charcode := "0x" . Substr(GuiComp,2,6)
	      if (charCode < 0x10000) {
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
  x:=x-4
  y:=y-10
  Gui, Add, Text, x%x% y%y% w38 h38 Center 0x200 hwndGuiKey%key% BackgroundTrans
  GuiKeyList := GuiKeyList . key . ","
}

CharProc_BSTNt() {
  global
  ; Bildschirmtastatur togglen
  useBSTN := !(useBSTN)
  if (useBSTN)
    CharProc_BSTN1()
  else
    CharProc_BSTN0()
}

BSTNOnClose() {
  global
  useBSTN := 0
  CharProc_BSTN0()
}

CharProc_BSTN0() {
  global
  GuiCurrent := ""
  Gui, Destroy
  DllCall( "GDI32.DLL\RemoveFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)
}

CharProc_BSTN1() {
  global
  if (GuiCurrent!="")
    %GuiCurrent%OnClose()

  if (FileExist(ResourceFolder)!="") {
    FileInstall,ebene0.png,%ResourceFolder%\ebene0.png,1
  }

  if (FileExist(UniFontLocalFile)=="") {
    if (FileExist(UnZipLocalFile)=="") {
      Progress,0,,Herunterladen des Entpack-Programms ...
      UrlDownloadToFile,%UnZipSourceLink%,%UnZipLocalFile%
      if (FileExist(UnZipLocalFile)=="") {
        Msgbox,Konnte Unzip-Programm nicht finden und nicht installieren!
      }
    }

    if (FileExist(UniFontZipLocalFile)=="") {
      Progress,20,Herunterladen des Fonts ...
      UrlDownloadToFile,%UniFontZipSourceLink%,%UniFontZipLocalFile%
    }

    Progress,80,Entpacken des Archivs ...
    RunWait,% """" . UnZipLocalFile . """ -j """ . UniFontZipLocalFile . """ """ . UniFontZipFontPath . """",%UniFontLocalFilePath%,Hide
    Progress,OFF
  }

  DllCall( "GDI32.DLL\AddFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)


  SysGet, WorkArea, MonitorWorkArea
  yPosition := WorkAreaBottom - 230
  Gui, Color, FFFFFF
  Gui, Add, Picture,AltSubmit x0   y0          vPicture0, % ResourceFolder . "\ebene0.png"
  Gui, Font, s12 bold, %UniFontName%
  GuiKeyList := ""
  GuiAddKeyS("029",6,9)
  GuiAddKeyS("002",44,9)
  GuiAddKeyS("003",82,9)
  GuiAddKeyS("004",120,9)
  GuiAddKeyS("005",158,9)
  GuiAddKeyS("006",196,9)
  GuiAddKeyS("007",234,9)
  GuiAddKeyS("008",272,9)
  GuiAddKeyS("009",310,9)
  GuiAddKeyS("00A",348,9)
  GuiAddKeyS("00B",386,9)
  GuiAddKeyS("00C",424,9)
  GuiAddKeyS("00D",462,9)
  GuiAddKey("backspace",510,9)

  GuiAddKey("tab",10,48)
  GuiAddKeyS("010",58,48)
  GuiAddKeyS("011",96,48)
  GuiAddKeyS("012",134,48)
  GuiAddKeyS("013",172,48)
  GuiAddKeyS("014",210,48)
  GuiAddKeyS("015",248,48)
  GuiAddKeyS("016",286,48)
  GuiAddKeyS("017",324,48)
  GuiAddKeyS("018",362,48)
  GuiAddKeyS("019",400,48)
  GuiAddKeyS("01A",438,48)
  GuiAddKeyS("01B",476,48)
  GuiAddKey("enter",526,68)

  GuiAddKeySM("03A",18,88)
  GuiAddKeyS("01E",75,88)
  GuiAddKeyS("01F",113,88)
  GuiAddKeyS("020",151,88)
  GuiAddKeyS("021",189,88)
  GuiAddKeyS("022",227,88)
  GuiAddKeyS("023",265,88)
  GuiAddKeyS("024",303,88)
  GuiAddKeyS("025",341,88)
  GuiAddKeyS("026",379,88)
  GuiAddKeyS("027",417,88)
  GuiAddKeyS("028",455,88)
  GuiAddKeySM("02B",493,88)

  GuiAddKeySM("02A",8,128)
  GuiAddKeySM("056",50,128)
  GuiAddKeyS("02C",88,128)
  GuiAddKeyS("02D",126,128)
  GuiAddKeyS("02E",164,128)
  GuiAddKeyS("02F",202,128)
  GuiAddKeyS("030",240,128)
  GuiAddKeyS("031",278,128)
  GuiAddKeyS("032",316,128)
  GuiAddKeyS("033",354,128)
  GuiAddKeyS("034",392,128)
  GuiAddKeyS("035",430,128)
  GuiAddKeySM("136",498,128)

  GuiAddKey("space",264,168)
  GuiAddKeySM("138",430,168)

  GuiAddKeyS("145",582,9)
  GuiAddKeyS("135",620,9)
  GuiAddKeyS("037",658,9)
  GuiAddKeyS("04A",696,9)

  GuiAddKeySN("047",582,48)
  GuiAddKeySN("048",620,48)
  GuiAddKeySN("049",658,48)
  GuiAddKeyS("04E",696,68)

  GuiAddKeySN("04B",582,88)
  GuiAddKeySN("04C",620,88)
  GuiAddKeySN("04D",658,88)

  GuiAddKeySN("04F",582,128)
  GuiAddKeySN("050",620,128)
  GuiAddKeySN("051",658,128)
  GuiAddKey("numpadenter",696,148)

  GuiAddKeySN("052",601,168)
  GuiAddKeySN("053",658,168)
  Gui, +AlwaysOnTop +ToolWindow
  Gui, Show, y%yposition% w729 h199 NoActivate, NEO-Bildschirmtastatur (neu!)
  BSTNUpdate()
  BSTNalwaysOnTop := 1
  GuiCurrent := "BSTN"
}

BSTNToggleAlwaysOnTop() {
  global
  if (BSTNalwaysOnTop) {
    Gui, -AlwaysOnTop
    BSTNalwaysOnTop := 0    
  } else {
    Gui, +AlwaysOnTop
    BSTNalwaysOnTop := 1
  }
}

CharProc_BSTNA() {
  global
  ; Bildschirmtastatur AlwaysOnTop
  if (BSTNguiErstellt)
    BSTNToggleAlwaysOnTop()
}

GUISYM(sym,chars) {
  global
  GSYM%sym% := EncodeUniComposeA(chars)
}

BSTNSymbols() {
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
  GUISYM("T__obrg","◌̊")
  GUISYM("T__drss","◌̈")
  GUISYM("U001FFE","◌῾") ; not perfect
  GUISYM("T__mcrn","◌̄")

  GUISYM("T__acut","◌́")
  GUISYM("T__tlde","◌̃")
  GUISYM("T__strk","◌̷")
  GUISYM("T__dbac","◌̋")
  GUISYM("U001FBF","◌᾿") ; not perfect
  GUISYM("U0002D8","◌̆")



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

BSTNRegister() {
  global

  CP3F2 := "P_BSTNt"
  BSTNSymbols()

  IniRead,useBSTN,%ini%,Global,useBSTN,0
  if (useBSTN)
    CharProc_BSTN1()
}

BSTNRegister()
