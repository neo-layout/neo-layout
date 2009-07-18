#!/bin/sh

# Anzahl der Compose-Module
anzahl=6

m[2]=math								# Modul
b[2]="mathematische und physikalische Zeichen (≥ ∉ ℏ ℃)"		# Beschreibung
d[2]=math.module							# Datei
a[2]=off								# Standard-Auswahl

m[3]=greek
b[3]="griechische Buchstaben (A ἀ)"
d[3]=greek.module
a[3]=off

m[4]=lang
b[4]="Lautschrift und weitere Sprachen ([neːo] Ɱ ʃ ɐ)"
d[4]=lang.module
a[4]=off

m[5]=roman
b[5]="römische Zahlen >12 (große Datei!) (1868→ⅿⅾⅽⅽⅽⅼⅹⅴⅰⅰⅰ)"
d[5]=roman.module
a[5]=off

m[6]=klingon
b[6]="klingonische Zahlen (große Datei!) (1984→wa'SaD Hutvatlh chorghmaH loS)"
d[6]=klingon.module
a[6]=off


m[0]=base
d[0]=base.module
auswahl=XCompose_${m[0]}

m[1]=optional
d[1]=optional.module
#auswahl=${m[0]}\ ${m[1]}						# Bei Verwendung einer eigenen (optionalen) Compose das Kommentarzeichen (#) entfernen


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
	menu=`kdialog --title Compose-Module --checklist " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten. " ${m[2]} "${b[2]}" ${a[2]} ${m[3]} "${b[3]}" ${a[3]} ${m[4]} "${b[4]}" ${a[4]} ${m[5]} "${b[5]}" ${a[5]} ${m[6]} "${b[6]}" ${a[6]}`
else
	menu=`zenity --title Compose-Module --width=480 --height=250 --list --multiple --column Modulname  --column Modulebeschreibung --hide-column=1 --separator=_ --text " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten.\n Für Für mehrere Module STRG bzw. CTRL gedrückt halten. " ${m[2]} "${b[2]}" ${m[3]} "${b[3]}" ${m[4]} "${b[4]}" ${m[5]} "${b[5]}" ${m[6]} "${b[6]}"`
fi
menu=$(echo $menu | sed -e 's/\"//g' | sed -e 's/\ /_/g')

if [ $menu ]
then
	make $auswahl\_$menu
	make install
	make clean
fi
