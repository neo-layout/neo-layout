; -*- encoding:utf-8 -*-

BSTNguiErstellt := 0
BSTNalwaysOnTop := 1

CP3F2 := "P_BSTNt"

UnZipLocalFile := ApplicationFolder . "\unzip.exe"
UnZipSourceLink := "http://stahlworks.com/dev/unzip.exe"

UniFontVersion  := "2.30"
UniFontFilename := "DejaVuSans-Bold.ttf"
UniFontName     := "DejaVu Sans"

UniFontZipFilename   := "dejavu-fonts-ttf-" . UniFontVersion . ".zip"
UniFontZipLocalFile  := ApplicationFolder . "\" . UniFontZipFilename

UniFontZipSourceLink := "http://downloads.sourceforge.net/project/dejavu/dejavu/" . UniFontVersion . "/" . UniFontZipFilename

UniFontLocalFile := ApplicationFolder . "/" . UniFontFilename
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
        GuiComp := Comp . CP%GuiEb%%GuiPhysKey%
        if (GSYM%GuiComp% != "") {
          GuiComp := GSYM%GuiComp%
        } else if (CD%GuiComp% != "") {
          GuiComp := CD%GuiComp%
        } else if (CM%GuiComp% == 1) {
          GuiComp := "U00002A"
        } else if (Comp != "") {
          GuiComp := ""
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
}

GuiAddKeyS(sc,x,y) {
  global
  GuiAddKey(vksc%sc%,x,y)
}

GuiAddKey(key,x,y) {
  global
  Gui, Add, Text, x%x% y%y% Center hwndGuiKey%key%, MM
  GuiKeyList := GuiKeyList . key . ","
}

BSTNToggle() {
  global
  if (BSTNguiErstellt) {
    BSTNguiErstellt := 0
    Gui, Destroy
  } else {
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
      RunWait,% """" . UnZipLocalFile . """ -j """ . UniFontZipLocalFile . """ """ . UniFontZipFontPath . """",%ApplicationFolder%,Hide
      Progress,OFF
    }

    DllCall( "GDI32.DLL\AddFontResourceEx", Str, UniFontLocalFile ,UInt,(FR_PRIVATE:=0x10), Int,0)


    SysGet, WorkArea, MonitorWorkArea
    yPosition := WorkAreaBottom - 230
    Gui, Color, FFFFFF
    Gui, Add, Picture,AltSubmit x0   y0          vPicture0, % ResourceFolder . "\ebene0.png"
    Gui, Font, s12 bold, %UniFontName%
    GuiKeyList := ""
    GuiAddKeyS("029",12,8)
    GuiAddKeyS("002",52,8)
    GuiAddKeyS("003",90,8)
    GuiAddKeyS("004",128,8)
    GuiAddKeyS("005",166,8)
    GuiAddKeyS("006",204,8)
    GuiAddKeyS("007",242,8)
    GuiAddKeyS("008",280,8)
    GuiAddKeyS("009",318,8)
    GuiAddKeyS("00A",356,8)
    GuiAddKeyS("00B",394,8)
    GuiAddKeyS("00C",432,8)
    GuiAddKeyS("00D",470,8)
    GuiAddKey("backspace",508,8)

    GuiAddKey("tab",26,48)
    GuiAddKeyS("010",64,48)
    GuiAddKeyS("011",102,48)
    GuiAddKeyS("012",140,48)
    GuiAddKeyS("013",178,48)
    GuiAddKeyS("014",216,48)
    GuiAddKeyS("015",254,48)
    GuiAddKeyS("016",292,48)
    GuiAddKeyS("017",330,48)
    GuiAddKeyS("018",368,48)
    GuiAddKeyS("019",406,48)
    GuiAddKeyS("01A",444,48)
    GuiAddKeyS("01B",484,48)
    GuiAddKey("enter",532,48)
    a
    GuiAddKeyS("01E",82,88)
    GuiAddKeyS("01F",120,88)
    GuiAddKeyS("020",158,88)
    GuiAddKeyS("021",196,88)
    GuiAddKeyS("022",234,88)
    GuiAddKeyS("023",272,88)
    GuiAddKeyS("024",310,88)
    GuiAddKeyS("025",348,88)
    GuiAddKeyS("026",386,88)
    GuiAddKeyS("027",424,88)
    GuiAddKeyS("028",462,88)

    GuiAddKeyS("02C",94,128)
    GuiAddKeyS("02D",132,128)
    GuiAddKeyS("02E",170,128)
    GuiAddKeyS("02F",208,128)
    GuiAddKeyS("030",246,128)
    GuiAddKeyS("031",284,128)
    GuiAddKeyS("032",322,128)
    GuiAddKeyS("033",360,128)
    GuiAddKeyS("034",398,128)
    GuiAddKeyS("035",436,128)

    GuiAddKey("space",246,168)

    Gui, +AlwaysOnTop +ToolWindow
    Gui, Show, y%yposition% w776 h200 NoActivate, NEO-Bildschirmtastatur (neu!)
    BSTNguiErstellt := 1
    BSTNUpdate()
    BSTNalwaysOnTop := 1
  }
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

CharProc_BSTNt() {
  global
  ; Bildschirmtastatur Ein/Aus
  BSTNToggle()
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
  GUISYM("T__tlde","◌̃")
  GUISYM("T__obrg","◌̊")
  GUISYM("T__cron","◌̌")
  GUISYM("T__brve","◌̆")
  GUISYM("T__mcrn","◌̄")

  GUISYM("T__grav","◌̀")
  GUISYM("T__turn","↻")
  GUISYM("T__drss","◌̈")
  GUISYM("T__dgrv","◌")
  GUISYM("T__hook","◌")

  GUISYM("T__acut","◌́")
  GUISYM("T__cedi","◌̧")
  GUISYM("T__strk","◌̷")
  GUISYM("T__dbac","◌̋")
  GUISYM("T__abdt","◌̇")

  GUISYM("S__Sh_L","⇧")
  GUISYM("S__Sh_R","⇧")
  GUISYM("S__Caps","⇪")
  GUISYM("S___Del","⌦")
  GUISYM("S___Ins","⎀")
  GUISYM("S____Up","↑")
  GUISYM("S__Down","↓")
  GUISYM("S__Rght","→")
  GUISYM("S__Left","←")
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
  GUISYM("S__N_Up","↑")
  GUISYM("S__N_Dn","↓")
  GUISYM("S__N_Ri","→")
  GUISYM("S__N_Le","←")
  GUISYM("S__NPUp","⇞")
  GUISYM("S__NPDn","⇟")
  GUISYM("S__NHom","↸")
  GUISYM("S__NEnd","⇲")

  GUISYM("S_SNDel","⌦")
  GUISYM("S_SNIns","⎀")
  GUISYM("S_SN_Up","↑")
  GUISYM("S_SN_Dn","↓")
  GUISYM("S_SN_Ri","→")
  GUISYM("S_SN_Le","←")
  GUISYM("S_SNPUp","⇞")
  GUISYM("S_SNPDn","⇟")
  GUISYM("S_SNHom","↸")
  GUISYM("S_SNEnd","⇲")

  GUISYM("U00001B","ESC")
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

BSTNSymbols()
