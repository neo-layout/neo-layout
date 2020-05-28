; -*- encoding: utf-8 -*-

; Wir müssen F24 nicht hooken, aber bei einem Restart hat AHK den Bug,
; dass manchmal der erste Hook ausgeführt wird, als wäre diese Taste
; gedrückt worden. Da F24 auf den wenigsten Tastaturen vorkommt und daher für
; NEO uninteressant ist, kehren wir einfach wieder zurück.
~F24::return

+pause::
Suspend, Permit
  Traytogglesuspend()
return

allstarhook:
  AllStar(A_ThisHotkey)
return

; Ein paar andere Hooks kommen hier auch noch. GUIs springen hier her, wenn
; sich bei ihnen etwas auf die entsprechende Art tut.

GuiClose:
  if (GuiCurrent!="")
    %GuiCurrent%OnClose()
  else
    Gui, Destroy
return

GuiSize:
  if (GuiCurrent!="")
    %GuiCurrent%OnSize()
return
