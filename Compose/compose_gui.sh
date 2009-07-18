#!/bin/sh

# This file is part of the german Neo keyboard layout
#
# GUI to combine several Compose modules written by Neo keyboard layout
# This file has been originally written by Pascal Hauck (neo@pascalhauck.de)


SRC=./src								# Source directory
CONFFILE=.config
typeset -i anzahl


auswahl=XCompose_base

for i in src/*.module
do
	name=$(basename $i .module)					# name of modul
	if [ ! "$name" = "base" ]
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
		if grep -q $name $CONFFILE
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


if [ $KDE_FULL_SESSION = true ]
then
	menu=`kdialog --title Compose-Module --checklist " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten. " $klist`
else
	menu=`zenity --title Compose-Module --width=480 --height=250 --list --multiple --column Modulname  --column Modulebeschreibung --hide-column=1 --separator=_ --text " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten.\n Für Für mehrere Module STRG bzw. CTRL gedrückt halten. " $glist`
fi
menu=$(echo $menu | sed -e 's/\"//g' | sed -e 's/\ /_/g')

if [ $menu ]
then
	echo "USER_XCOMPOSE = XCompose_$auswahl_$menu" > .config
	make install
	make clean
fi
