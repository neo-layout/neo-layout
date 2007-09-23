#!/bin/bash
#
# BENUTZUNG AUF EIGENE GEFAHR!
#
# xmodmap2tastaturaufkleber.sh
# Dieses Skript wertet eine beliebige .Xmodmap-Datei aus und 
# verteilt die Zeichen einer Taste nach folgendem Schema auf
# eine Druckvorlage:
#
# keycode 84 =  a A b B c C
#
# +---+---+
# | a | A |
# +---+---+
# | b | B |
# +---+---+
# | c | C |
# +---+---+
#

vers=0.01


#================================================
# Bedienungsanleitung,  falls ohne Parameter gestartet

if [ $# -lt 1 ] ; then
 echo "" >&2
 echo "xmodmap2tastaturaufkleber, Version $vers" >&2
 echo "BENUTZUNG AUF EIGENE GEFAHR!" >&2
 echo "" >&2
 echo "Dieses Skript wertet eine beliebige .Xmodmap-Datei aus und " >&2
 echo "verteilt die Zeichen einer Taste nach folgendem Schema auf" >&2
 echo "eine Druckvorlage im SVG-Format:" >&2
 echo '' >&2
 echo 'keycode 84 =  a A b B c C' >&2
 echo '' >&2
 echo '+---+---+' >&2
 echo '| a | A |' >&2
 echo '+---+---+' >&2
 echo '| b | B |' >&2
 echo '+---+---+' >&2
 echo '| c | C |' >&2
 echo '+---+---+' >&2
 echo '' >&2
 echo '' >&2
 echo 'Parameter:' >&2
 echo 'xmodmap2tastaturaufkleber  Xmodmap-Datei  [Ausgabedatei.svg]' >&2
 echo '' >&2

 exit 1
fi

if [ ! -f $1 ]; then
 echo "Fehler: Die Xmodmap-Datei »$1« ist nicht auffindbar."

 exit 1
fi


 echo "" >&2
 echo "xmodmap2tastaturaufkleber, Version $vers" >&2
 echo "BENUTZUNG AUF EIGENE GEFAHR!" >&2
 echo "" >&2
 echo "Einen Moment Geduld, bitte..." >&2



#================================================
# Ausfiltern von Nicht-keycode-Definitionen aus der Xmodmap-Datei

sed -n -e '/^keycode/p' $1 > ./tmp_$1

#Andere Möglichkeit?: xmodmap -pk neo_de.xmodmap > tt




#================================================
# Freistellen der Zeichen; der keycode bleibt als ID für die SVG-Datei vorhanden

ex -s -c '%s/^[^0-9]\+//' -c '%s/=//' -c '%s/ \+/\t/g' -c '%s/\t\+/\t/g' -c "w! ./tmp_$1" -c 'q!' ./tmp_$1




#================================================
# Herausfiltern von Modifikatortasten, etc.
# Die zu filternden Tastencodes stehen in den runden Klammern jeweils durch ein Oder-Zeichen getrennt

cat tmp_$1 | grep -v -E "^(9|51|65|66|94|113|115|116)[^0-9]" > tmp_$1

#================================================
# Parsfreundlicheres Tablayout

ex -s -c '%s/ \+/\t/g' -c '%s/\t\+/\t/g' -c "w! ./tmp_$1" -c 'q!' ./tmp_$1


#================================================
# Aufbereiten der keysymdef.h zum Nachschlagen des Zeichens


ex -s -c '%s/^\([^_]\+\)_//' -c "w! ./tmp_keysymdef.h" -c 'q!' ./keysymdef.h
sed -n -e '/U+/p' ./tmp_keysymdef.h > tmptmp


cp tmptmp tmp_keysymdef.h


#===============================================
# Nachschlagen und Ersetzen von Symbolnamen


while read ZEILE; do

for ebene in `seq 2 8`; do


  echo $ZEILE | awk "{ printf $`echo $ebene` }" > ./tmp_symbolistleer

  if [ -s ./tmp_symbolistleer ]; then 


	Tastensymbol=`cat ./tmp_symbolistleer` 
	cat ./tmp_keysymdef.h | grep "^$Tastensymbol " > ./tmp_keysymdef.h_buchstabenanalyse


#echo -n "$Tastensymbol"; cat ./tmp_keysymdef.h_buchstabenanalyse

	if [ -s ./tmp_keysymdef.h_buchstabenanalyse ]; then
		if  ( grep -q -i "U+" ./tmp_keysymdef.h_buchstabenanalyse );  then
			echo -n »$Tastensymbol« hat laut keysymdef.h den Unicode U+
			ex -s -c '%s/\(.\+\)U+/U+/g' -c '%s/U+\([^ ]\+\).\+/\1/g' -c "w! ./tmp_keysymdef.h_buchstabenanalyse" -c 'q!'   ./tmp_keysymdef.h_buchstabenanalyse; 

			if [ -s ./tmp_keysymdef.h_buchstabenanalyse ]; then 
			     cat ./tmp_keysymdef.h_buchstabenanalyse
			else
			     echo "ERROR"     
			     exit 1 
			fi 

   			ex -s  -c "%s/\t`cat ./tmp_symbolistleer`\t/\t\&\#x`cat ./tmp_keysymdef.h_buchstabenanalyse`;\t/g" -c "w! ./tmp_$1" -c 'q!' ./tmp_$1
			ex -s  -c  "%s/\t`cat ./tmp_symbolistleer`$/\t\&\#x`cat ./tmp_keysymdef.h_buchstabenanalyse`;\t/g" -c "w! ./tmp_$1" -c 'q!' ./tmp_$1

 		else
			echo »$Tastensymbol« hat in keysymdef.h keinen Unicode gelistet.
		fi
 
	else
		echo »$Tastensymbol« ist in keysymdef.h nicht gelistet.
	fi
  else
  #Kein Tastensymbol in der aktuellen Ebene
  echo -n "";
  fi


done;

done < ./tmp_$1;


#===============================================
# Unicodezeichen im xmodmaplayout für SVG aufbereiten
# Alle Daten die mit einem großen U beginen!

ex -s -c '%s/U\([0-9A-F]\+\)/ \&\#x\1; /g' -c "w! ./tmp_$1" -c 'q!' ./tmp_$1




#================================================
# Schreiben der SVG-Datei

cp svg_kopf  ./tmp_svg_$1


declare -i X_Translation=150
declare -i Y_Translation=0

while read ZEILE; do 


if [ $X_Translation -gt 1600 ]; then 
 Y_Translation=$(($Y_Translation+200))
 X_Translation=0
fi


echo "" >> ./tmp_svg_$1
echo $ZEILE | awk '{   printf "<use xlink:href=\"#taste\" id=\"taste_"$1"\" "      }' >> ./tmp_svg_$1
echo "transform=\"translate($X_Translation,$Y_Translation)\" x=\"0\"  y=\"0\"  />" >> ./tmp_svg_$1

echo $ZEILE | awk '{   printf "<g id=\""$1"\" " } ' >> ./tmp_svg_$1
echo "transform=\"translate($X_Translation,$Y_Translation)\" >" >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene1\" x=\"30\" y=\"35\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#ffffff;font-weight:bold\" xml:space=\"preserve\">"$2"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene2\" x=\"90\" y=\"35\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;font-weight:bold\" xml:space=\"preserve\">"$3"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene3\" x=\"30\" y=\"85\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;font-weight:bold\" xml:space=\"preserve\">"$4"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene4\" x=\"90\" y=\"85\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;font-weight:bold\" xml:space=\"preserve\">"$5"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene5\" x=\"30\" y=\"135\" style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;font-weight:bold\" xml:space=\"preserve\">"$6"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene6\" x=\"90\" y=\"135\" style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;font-weight:bold\" xml:space=\"preserve\">"$7"</text>"}' >> ./tmp_svg_$1
echo "</g>" >> ./tmp_svg_$1





X_Translation=$(($X_Translation+150))

done < ./tmp_$1;                                           



echo "</svg>" >> ./tmp_svg_$1


#======================
#debug

#Es werden irgendwie leere UTF-8-Zeichen übergeben. Lösche &#x;
ex -s  -c '%s/&#x;//g' -c "w! ./tmp_svg_$1" -c 'q!' ./tmp_svg_$1



#=======================
# Dateiausgabe

if [ $#  -gt 1 ]; then
 if  echo $2 | grep "\.svg$" ; then
  # svg-datei mit .svg-suffix
  cp tmp_svg_$1 $2
  echo "Die SVG-Datei $2 wurde angelegt." >&2

  else
  # svg-datei ohne .svg-suffix
  cp tmp_svg_$1 $2.svg
  echo "Die SVG-Datei $2.svg wurde angelegt." >&2

  fi
else
 # keine svg-datei
 cp tmp_svg_$1 $1.svg
  echo "Die SVG-Datei $1.svg wurde angelegt." >&2
fi



#========================
# debug

#rm ./tmp_*
