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

#ex -s -c '%s/^[^_]\+//' -c'%s/^_//' -c "w! ./tmp_keysymdef.h" -c 'q!' ./keysymdef.h
#cat ./tmp_keysymdef.h | sed -e '/^$/d' >./tmp_keysymdef.h

ex -s -c '%s/^\([^_]\+\)_//' -c "w! ./tmp_keysymdef.h" -c 'q!' ./keysymdef.h

#ex -s -c '%s/^#define XK_//'  -c "w! ./tmp_keysymdef.h" -c 'q!' ./keysymdef.h


#cat ./tmp_keysymdef.h | sed -e '/^$/d' >./tmp_keysymdef.h
#sed -n -e '/U\+/p' ./tmp_keysymdef.h > tmp_tmp
sed -n -e '/U+/p' ./tmp_keysymdef.h > tmp_tmp


#cat ./tmp_keysymdef.h |grep tra
#cat tmp_tmp |grep tra
#exit 1

cp tmp_tmp tmp_keysymdef.h


#===============================================
# Nachschlagen und Ersetzen von Symbolnamen


cp ./tmp_$1 ./tmp_analysiert_$1

while read -r ZEILE; do

#debug
echo
echo ====================================================
echo -e "\033[40;01;37m $ZEILE \033[0m"
echo ----------------------------------------------------
echo -e "Tastencode ist \033[40;01;34m`echo $ZEILE | cut -d\  -f1`\033[0m ."


for ebene in `seq 2 8`; do


  echo $ZEILE | awk "{ printf $`echo $ebene` }" > ./tmp_symbolistleer

  if [ -s ./tmp_symbolistleer ]; then 

###        #Tastensymbol ist Keypad -> gleiches Symbol wie normal
###	ex -s -c "%s/^KP_//" -c 'w! ./tmp_symbolistleer' -c "q!"  ./tmp_symbolistleer


	Tastensymbol=`cat ./tmp_symbolistleer` 
	cat ./tmp_keysymdef.h | grep "^$Tastensymbol " > ./tmp_keysymdef.h_buchstabenanalyse


#echo -n "$Tastensymbol"; cat ./tmp_keysymdef.h_buchstabenanalyse

	if [ -s ./tmp_keysymdef.h_buchstabenanalyse ]; then
		if  ( grep -q -i "U+" ./tmp_keysymdef.h_buchstabenanalyse );  then
			ex -s -c '%s/\(.\+\)U+/U+/g' -c '%s/U+\([^ ]\+\).\+/\1/g' -c "w! ./tmp_keysymdef.h_buchstabenanalyse" -c 'q!'   ./tmp_keysymdef.h_buchstabenanalyse; 

			if [ -s ./tmp_keysymdef.h_buchstabenanalyse ]; then 
			     #cat ./tmp_keysymdef.h_buchstabenanalyse
			     echo -e "Mit Unicode  \033[40;0;32mU+`cat ./tmp_keysymdef.h_buchstabenanalyse`\033[0m  ist in keysymdef.h folgender Zeichenname verknüpft: »\033[40;0;32m$Tastensymbol\033[0m«."
			else
			     echo -e "\033[40;0;31mERROR: Unicode in Datei keysymdef.h\033[0m"     
			     exit 1 
			fi 

   			ex -s  -c "%s/\t`cat ./tmp_symbolistleer`\t/\t\&\#x`cat ./tmp_keysymdef.h_buchstabenanalyse`;\t/g" -c "w! ./tmp_analysiert_$1" -c 'q!' ./tmp_analysiert_$1
			ex -s  -c  "%s/\t`cat ./tmp_symbolistleer`$/\t\&\#x`cat ./tmp_keysymdef.h_buchstabenanalyse`;\t/g" -c "w! ./tmp_analysiert_$1" -c 'q!' ./tmp_analysiert_$1

###			#Für KP_ gleiche Ersetzung
###
   ####			ex -s  -c "%s/\tKP_`cat ./tmp_symbolistleer`\t/\t\&\#x`cat ./tmp_keysymdef.h_buchstabenanalyse`;\t/g" -c "w! ./tmp_$1" -c 'q!' ./tmp_$1
###			ex -s  -c  "%s/\tKP_`cat ./tmp_symbolistleer`$/\t\&\#x`cat ./tmp_keysymdef.h_buchstabenanalyse`;\t/g" -c "w! ./tmp_$1" -c 'q!' ./tmp_$1

 		else
			echo -e "\033[40;0;31m»$Tastensymbol« hat in keysymdef.h keinen Unicode gelistet. Deswegen wird der Text unmodifiziert übernommen.\033[0m"
		fi
 
	else
		if [ "${Tastensymbol/U[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f ]/Unicodezeichen}" == "Unicodezeichen" ] 
		then 
		echo -e "Der Unicode \033[40;0;32m ${Tastensymbol/U/U+} \033[0m aus $1 wird \033[40;0;32m übernommen \033[0m. \033[0m"
		else
		echo -e "\033[40;01;31m»$Tastensymbol« ist in keysymdef.h nicht gelistet. Tippfehler? Der Text wird unmodifiziert übernommen. \033[0m"  
		nichtgelistet="$nichtgelistet, »$Tastensymbol«"
		fi
	fi
  else
  #Kein Tastensymbol in der aktuellen Ebene
  echo -n "";
  fi


done;

done < ./tmp_$1;


cp ./tmp_analysiert_$1 ./tmp_$1


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
echo $ZEILE | awk '{print " <text id=\""$1"_ebene1\" x=\"30\" y=\"35\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;\" xml:space=\"preserve\">"$3"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene2\" x=\"90\" y=\"35\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;\" xml:space=\"preserve\">"$5"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene3\" x=\"30\" y=\"85\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#ffffff;font-weight:bold\" xml:space=\"preserve\">"$2"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene4\" x=\"90\" y=\"85\"  style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;\" xml:space=\"preserve\">"$4"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene5\" x=\"30\" y=\"135\" style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;\" xml:space=\"preserve\">"$6"</text>"}' >> ./tmp_svg_$1
echo $ZEILE | awk '{print " <text id=\""$1"_ebene6\" x=\"90\" y=\"135\" style=\"font-size:30;text-align:center;text-anchor:middle;fill:#000000;\" xml:space=\"preserve\">"$8"</text>"}' >> ./tmp_svg_$1
echo "</g>" >> ./tmp_svg_$1





X_Translation=$(($X_Translation+150))

done < ./tmp_$1;                                           



echo "</svg>" >> ./tmp_svg_$1


#======================
#debug

#Es werden irgendwie leere UTF-8-Zeichen übergeben. Lösche &#x;
ex -s  -c '%s/&#x;//g' -c "w! ./tmp_svg_$1" -c 'q!' ./tmp_svg_$1


#======================
# Fehleranzeige

if [ -n "$nichtgelistet" ]; then
echo
echo
echo -e "\033[40;01;31mFehlerbericht\033[0m"
echo
echo Folgende Bezeichner wurden nicht in der keysymdef.h gefunden und wurden unabgeändert übernommen:
echo -e "\033[40;01;31m ${nichtgelistet/, /}\033[0m "
echo
echo
fi

#=======================
# Dateiausgabe

echo

if [ $#  -gt 1 ]; then
 if  echo $2 | grep "\.svg$" ; then
  # svg-datei mit .svg-suffix
  cp tmp_svg_$1 $2
  echo -e "Die SVG-Datei \033[40;01;370m$2\033[0m wurde geschrieben." >&2

  else
  # svg-datei ohne .svg-suffix
  cp tmp_svg_$1 $2.svg
  echo -e "Die SVG-Datei \033[40;01;370m$2.svg\033[0m wurde geschrieben." >&2

  fi
else
 # keine svg-datei
 cp tmp_svg_$1 $1.svg
  echo -e "Die SVG-Datei \033[40;01;370m$1.svg\033[0m wurde geschrieben." >&2
fi

echo

#========================
# debug

rm ./tmp_*
