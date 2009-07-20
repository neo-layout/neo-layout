#!/bin/bash

# This file is part of the german Neo keyboard layout
#
# GUI to combine several Compose modules written by Neo keyboard layout
# This file has been originally written by Pascal Hauck (neo@pascalhauck.de)


SRC=./src								# Source directory
CONFFILE=.config
typeset -i anzahl


if [ "X:$KDE_FULL_SESSION" = "X:true" ]
then
	CHECKLIST() {
		kdialog --title Compose-Module --checklist "$1<br>$2<br><br>$3" $5
	}
	MSGBOX() {
		kdialog --title Compose-Module --msgbox "$1"
	}
	YESNO() {
		kdialog --title Compose-Module --yesno "$1"
	}
else
	CHECKLIST() {
		zenity --title Compose-Module --width=610 --height=320 --list --multiple --column Modulname  --column Modulebeschreibung --separator=_ --text "$1\n$2\n\n$3\n$4" $6
	}
	MSGBOX() {
		zenity --title Compose-Module --info --text "$1"
	}
	YESNO() {
		zenity --title Compose-Module --question --text "$1"
	}
fi


if [ -f $HOME/.XCompose ]
then
	YESNO "Es gibt bereits eine Compose-Datei (z.B. durch eine ältere Neo-Installation).\nSollten Sie eigene Definitionen in der Datei ~/.XCompose vorgenommen haben, dann brechen Sie jetzt ab und schreiben Ihre eigenen Definitionen in eine Datei (z.B. user.module) im Ordner src.\n\nAnderenfalls können Sie das Skript bedenkenlos fortsetzen.\nWollen Sie fortfahren?" || exit
fi


auswahl=XCompose_enUS_base

for i in src/*.module
do
	name=$(basename $i .module)					# name of modul
	if [ ! "$name" = "base" -a ! "$name" = "enUS" ]
	then
		anzahl=anzahl+1
		m[$anzahl]=$name
		b[$anzahl]=$(sed -n "
/^#configinfo[ \t]*/{
    s///
    s/^\(.\{10\}\) */\1/
    p;q
}

\${
    s/.*/ohne Beschreibung/
    s/^\(.\{10\}\) */\1/
    p
}" $SRC/$name.module)							# description of module
		if  grep -qs $name $CONFFILE
		then
			a[$anzahl]=on					# default value for this module
		else
			a[$anzahl]=off
		fi
	fi
	klist=$klist\ ${m[$anzahl]}\ ${b[$anzahl]}\ ${a[$anzahl]}
	glist=$glist\ ${m[$anzahl]}\ ${b[$anzahl]}
done


while [ ! "$module" ]
do
 case ${1-" "} in
  " ")
      module=ausgewählt
      ;;
  *)
      echo Aufruf: compose.sh
      echo Mit »compose.sh« können die Compose-Module von Neo zusammengesetzt werden.
      echo Folgende Module sind verfügbar:
      for i in $(seq 1 $anzahl)
      do
       echo -e "  ${m[$i]}\t\t${b[$i]}"
      done
      exit;;
 esac
done

menu=`CHECKLIST "Die Neo-Tastaturbelegung hat etliche Erweiterungen für Compose (Mod3+Tab) erstellt," "wodurch Zeichen wie ∮ έ ʒ ermöglicht werden." "Wählen Sie die Compose-Module von Neo aus, die Sie verwenden möchten." "Für mehrere Module STRG bzw. CTRL gedrückt halten." "$klist" "$glist" | sed -e 's/\"//g' | sed -e 's/\ /_/g'`

if [ $menu ]
then
	fertig="Die neue Compose-Datei wurde erfolgreich erstellt.\nSie wird für alle neu gestarteten Programme sowie nach dem nächsten Login wirksam."
	echo "USER_XCOMPOSE = XCompose_$auswahl_$menu" > .config && make install && make clean && MSGBOX "$fertig"
fi
