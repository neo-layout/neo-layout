#!/bin/sh

SRC=./src								# Source directory

# Anzahl der Compose-Module
anzahl=6

m[2]=math								# name of modul
b[2]="mathematische und physikalische Zeichen (≥ ∉ ℏ ℃)"		# description of module
a[2]=off								# default value for this module

m[3]=greek
b[3]="griechische Buchstaben (A ἀ)"
a[3]=off

m[4]=lang
b[4]="Lautschrift und weitere Sprachen ([neːo] Ɱ ʃ ɐ)"
a[4]=off

m[5]=roman
b[5]="römische Zahlen >12 (große Datei!) (1868→ⅿⅾⅽⅽⅽⅼⅹⅴⅰⅰⅰ)"
a[5]=off

m[6]=klingon
b[6]="klingonische Zahlen (große Datei!) (1984→wa'SaD Hutvatlh chorghmaH loS)"
a[6]=off


m[0]=base
auswahl=XCompose_${m[0]}

if [ -f $SRC/optional.module ]
then
	m[1]=optional
	b[1]=eigene Compose-Datei					# for zenity written with a no‑break space
	a[1]=on
fi

while [ ! "$module" ]
do
 case ${1-" "} in
  " ")
      module=ausgewählt
      ;;
  *)
      echo Aufruf: compose.sh [-g] [COMPOSEMODULE]
      echo Mit »compose.sh« können die Compose-Module von Neo zusammengesetzt werden.
      echo Folgende Module sind verfügbar:
      for i in $(seq 2 $anzahl)
      do
       echo -e "  ${m[$i]}\t\t${b[$i]}"
      done
      exit;;
 esac
done

if [ $KDE_FULL_SESSION = true ]
then
	menu=`kdialog --title Compose-Module --checklist " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten. " ${m[2]} "${b[2]}" ${a[2]} ${m[3]} "${b[3]}" ${a[3]} ${m[4]} "${b[4]}" ${a[4]} ${m[5]} "${b[5]}" ${a[5]} ${m[6]} "${b[6]}" ${a[6]} ${m[1]} "${b[1]}" ${a[1]}`
else
	menu=`zenity --title Compose-Module --width=480 --height=250 --list --multiple --column Modulname  --column Modulebeschreibung --hide-column=1 --separator=_ --text " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten.\n Für Für mehrere Module STRG bzw. CTRL gedrückt halten. " ${m[2]} "${b[2]}" ${m[3]} "${b[3]}" ${m[4]} "${b[4]}" ${m[5]} "${b[5]}" ${m[6]} "${b[6]}" ${m[1]} ${b[1]}`
fi
menu=$(echo $menu | sed -e 's/\"//g' | sed -e 's/\ /_/g')

if [ $menu ]
then
	echo "USER_XCOMPOSE = XCompose_$auswahl_$menu" > .config
	make install
	make clean
fi
