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
        sc := A_LoopField
        GuiPhysKey := vksc%sc%
        if (EbeneC<3) {
          if (NOC%GuiPhysKey%==1) {
            GuiEb := EbeneNC
          } else {
	    GuiEb := EbeneC
          }
        } else
          GuiEb := EbeneC
        GuiComp := Comp . CP%GuiEb%%GuiPhysKey%
        if (CD%GuiComp% != "") {
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
        DllCall("SendMessageW", "UInt",GuiKey%sc%, "UInt",WM_SETTEXT, "UInt",0, "Uint",&ptrU)
      }
    }
}

GuiAddKey(sc,x,y) {
  global
  Gui, Add, Text, x%x% y%y% Center hwndGuiKey%sc%, MM
  GuiKeyList := GuiKeyList . sc . ","
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
    Gui, Font, s10 bold, %UniFontName%
    GuiKeyList := ""
    GuiAddKey("029",12,8)
    GuiAddKey("002",52,8)
    GuiAddKey("003",90,8)
    GuiAddKey("004",128,8)
    GuiAddKey("005",166,8)
    GuiAddKey("006",204,8)
    GuiAddKey("007",242,8)
    GuiAddKey("008",280,8)
    GuiAddKey("009",318,8)
    GuiAddKey("00A",356,8)
    GuiAddKey("00B",394,8)
    GuiAddKey("00C",432,8)
    GuiAddKey("00D",470,8)

    GuiAddKey("010",64,48)
    GuiAddKey("011",102,48)
    GuiAddKey("012",140,48)
    GuiAddKey("013",178,48)
    GuiAddKey("014",216,48)
    GuiAddKey("015",254,48)
    GuiAddKey("016",292,48)
    GuiAddKey("017",330,48)
    GuiAddKey("018",368,48)
    GuiAddKey("019",406,48)
    GuiAddKey("01A",444,48)
    GuiAddKey("01B",484,48)
    GuiAddKey("00D",532,48)

    GuiAddKey("01E",82,88)
    GuiAddKey("01F",120,88)
    GuiAddKey("020",158,88)
    GuiAddKey("021",196,88)
    GuiAddKey("022",234,88)
    GuiAddKey("023",272,88)
    GuiAddKey("024",310,88)
    GuiAddKey("025",348,88)
    GuiAddKey("026",386,88)
    GuiAddKey("027",424,88)
    GuiAddKey("028",462,88)

    GuiAddKey("02C",94,128)
    GuiAddKey("02D",132,128)
    GuiAddKey("02E",170,128)
    GuiAddKey("02F",208,128)
    GuiAddKey("030",246,128)
    GuiAddKey("031",284,128)
    GuiAddKey("032",322,128)
    GuiAddKey("033",360,128)
    GuiAddKey("034",398,128)
    GuiAddKey("035",436,128)
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
