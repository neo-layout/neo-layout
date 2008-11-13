if (iconBenutzen)
  menu,tray,icon,%ResourceFolder%\neo_enabled.ico,,1
menu,tray,nostandard
menu,tray,add,Öffnen,open
  menu,helpmenu,add,About,about
  menu,helpmenu,add,Autohotkey-Hilfe,help
  menu,helpmenu,add
  menu,helpmenu,add,http://autohotkey.com/,autohotkey
  menu,helpmenu,add,http://www.neo-layout.org/,neo
menu,tray,add,Hilfe,:helpmenu
menu,tray,add
menu,tray,add,%disable%,togglesuspend
menu,tray,add
menu,tray,add,Bearbeiten,edit
menu,tray,add,Neu Laden,reload
menu,tray,add
menu,tray,add,Nicht im Systray anzeigen,hide
menu,tray,add,%name% beenden, exitprogram
menu,tray,default,%disable%
menu,tray,tip,%name%

