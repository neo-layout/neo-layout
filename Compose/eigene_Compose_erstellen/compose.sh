#!/bin/sh

pfad=..
g=1									# mit graphischer Menüauswahl

# Compose-Module
anzahl=4

m[1]=mathephysik							# Modul
b[1]="mathematische und physikalische Zeichen (≥ ∉ ℏ ℃)"		# Beschreibung
d[1]=Compose_math_and_physics.neo					# Datei
a[1]=off								# Standard-Auswahl

m[2]=griechisch
b[2]="griechische Buchstaben (A ἀ)"
d[2]=Compose_greek.neo
a[2]=off

m[3]=roemisch
b[3]="römische Zahlen >12 (große Datei!) (1868→ⅿⅾⅽⅽⅽⅼⅹⅴⅰⅰⅰ)"
d[3]=Compose_many_roman_numericals.neo
a[3]=off

m[4]=klingonisch
b[4]="klingonische Zahlen (große Datei!) (1984→wa'SaD Hutvatlh chorghmaH loS)"
d[4]=Compose_many_klingon_numericals.neo
a[4]=off

m[0]=standard
d[0]=Compose.neo
auswahl=${m[0]}

while [ ! "$module" ]
do
 case ${1-" "} in
  " ")
      module=ausgewählt
      ;;
  --help)
      echo Aufruf: compose.sh [-g] [COMPOSEMODULE]
      echo Mit »compose.sh« können die Compose-Module von Neo zusammengesetzt werden.
      echo Folgende Module sind verfügbar:
      for i in $(seq 1 $anzahl)
      do
       echo -e "  ${m[$i]}\t\t${b[$i]}"
      done
      echo -e \\n\\r"  -g               Startet nicht das Menü, um dort die Auswahl zu treffen.\\n"
    exit;;
  -g) shift
      g=0
      ;;
  ${m[1]}) shift
      a[1]=on
      auswahl=`echo $auswahl ${m[1]}`
      ;;
  ${m[2]}) shift
      a[2]=on
      auswahl=`echo $auswahl ${m[2]}`
      ;;
  ${m[3]}) shift
      a[3]=on
      auswahl=`echo $auswahl ${m[3]}`
      ;;
  ${m[4]}) shift
      a[4]=on
      auswahl=`echo $auswahl ${m[4]}`
      ;;
  *) echo $1 ist kein bekanntes Compose-Modul von Neo
    exit;;
 esac
done

if [ $g = 1 ]
then
	menu=`kdialog --title Compose-Module --checklist " Wählen Sie die optionalen Compose-Module von Neo aus, die Sie verwenden möchten. " ${m[1]} "${b[1]}" ${a[1]} ${m[2]} "${b[2]}" ${a[2]} ${m[3]} "${b[3]}" ${a[3]} ${m[4]} "${b[4]}" ${a[4]}`
	auswahl=`echo \"${m[0]}\" $menu`
fi

echo -e "# with additional definitions by Neo keyboard\n" > $pfad/XCompose
cat  /usr/share/X11/locale/en_US.UTF-8/Compose >> $pfad/XCompose
for i in $(seq 0 $anzahl)
do
	echo $auswahl | grep ${m[$i]} > /dev/null && cat $pfad/${d[$i]} >> $pfad/XCompose
done

echo -e "\n# End of Definitions by Neo keyboard layout" >> $pfad/XCompose
