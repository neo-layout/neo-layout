#!/bin/bash

# This file is part of the german Neo keyboard layout
#
# GUI to combine several Compose modules written by Neo keyboard layout
# This file has been originally written by Pascal Hauck (neo@pascalhauck.de)


SRC=./src								# Source directory
CONFFILE=.config


if [ "X:$KDE_FULL_SESSION" = "X:true" ]
then
	ADD_TO_LIST() {
		list=("${list[@]}" "$1" "$2" "$3")
	}
	CHECKLIST() {
		kdialog --title Compose-Module --checklist "Die Neo-Tastaturbelegung hat etliche Erweiterungen für Compose (Mod3+Tab) erstellt,<br>wodurch Zeichen wie ≙ έ ʒ ermöglicht werden.<br>Wählen Sie die Compose-Module von Neo aus, die Sie verwenden möchten." "${list[@]}"
	}
	MSGBOX() {
		kdialog --title Compose-Module --msgbox "$1"
	}
	YESNO() {
		kdialog --title Compose-Module --yesno "$1"
	}
else
	ADD_TO_LIST() {
		list=("${list[@]}" "$1" "$2")
	}
	CHECKLIST() {
		zenity --title Compose-Module --width=610 --height=320 --list --multiple --column Modulname  --column Modulebeschreibung --separator=_ --text "Die Neo-Tastaturbelegung hat etliche Erweiterungen für Compose (Mod3+Tab) erstellt,\nwodurch Zeichen wie ≙ έ ʒ ermöglicht werden.\nWählen Sie die Compose-Module von Neo aus, die Sie verwenden möchten.\nFür mehrere Module STRG bzw. CTRL gedrückt halten." "${list[@]}"
	}
	MSGBOX() {
		zenity --title Compose-Module --info --text "$1"
	}
	YESNO() {
		zenity --title Compose-Module --question --text "$1"
	}
fi


while [ ! "$nohelp" ]
do
 case ${1-" "} in
  " ")
	nohelp=ok
	;;
  *)
	echo Aufruf: compose.sh
	echo Mit »compose.sh« können die Compose-Module von Neo zusammengesetzt werden.
	echo Folgende Module sind verfügbar:
	for j in `ls $SRC/*.module`; do
	i=$(basename $j .module)
	sed -n "
/^#configinfo[ \t]*/{
    s///
    b print
}

\$! b

s/.*/(ohne Beschreibung)/
: print

x
s/^/$i          /
G
s/^\(.\{9\}\).*\n\(.\{1,69\}\).*/\1 \2/  # 80-Zeichen-Terminal-Grenze
p
q
" ${SRC}/${i}.module
	done
	exit;;
 esac
done



auswahl=XCompose_enUS_base

for i in src/*.module
do
	name=$(basename $i .module)					# name of modul
	if [ ! "$name" = "base" -a ! "$name" = "enUS" ]
	then
		description=$(sed -n "
/^#configinfo[ \t]*/{
    s///
    b print
}

\$! b

s/.*/(ohne Beschreibung)/
: print
p
q
" $SRC/$name.module)							# description of module
		if  grep -qs $name $CONFFILE
		then
			default=on					# default value for this module
		else
			default=off
		fi
	ADD_TO_LIST "$name" "$description" "$default"
	fi
done





if [ -f $HOME/.XCompose ]
then
	YESNO "Es gibt bereits eine Compose-Datei (z.B. durch eine ältere Neo-Installation).\nSollten Sie eigene Definitionen in der Datei ~/.XCompose vorgenommen haben, dann brechen Sie jetzt ab und schreiben Ihre eigenen Definitionen in eine Datei (z.B. user.module) im Ordner src.\n\nAnderenfalls können Sie das Skript bedenkenlos fortsetzen.\nWollen Sie fortfahren?" || exit
fi

menu=`CHECKLIST | sed -e 's/\"//g' | sed -e 's/\ /_/g'`

if [ $menu ]
then
	fertig="Die neue Compose-Datei wurde erfolgreich erstellt.\nSie wird für alle neu gestarteten Programme sowie nach dem nächsten Login wirksam."
	echo "USER_XCOMPOSE = ${auswahl}_${menu}" > .config && make install && MSGBOX "$fertig"
fi
