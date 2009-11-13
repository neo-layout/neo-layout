#!/bin/bash
# Autor: Adam Taras <www.adam-taras.de/opensource>
# Datum: 20.06.2009

#=== Hilfe ===
printHelp(){
echo "Usage: "$0" [OPTIONEN]"
echo "Liest aus der Datei \"$fileIn\" alle Wörter ein und gibt diese sortiert nach der in der Datei \"$fileKey\" festgelegten Reihenfolge weider aus."
echo "Sie werden einmal in eine Klartextdatei \"$fileOut\" und in eine KTouch-Lektion \"$fileKTouch\" geschrieben."
echo "Dabei ist egal, wie die Worte in \"$fileIn\" voneinander getrennt sind. (Windows-Zeilentrennzeichen, Linux-Zeilentrennzeichen, Leerzeichen, Tabulator, ...)"
echo
echo "  -k  berücksichtige nur komplett klein geschriebene Worte"
echo "  -w  wandle alle Worte in klein-schreibeise um. Setzt automatisch die Option '-k'"
echo "  -e  entfernt doppelt vorkommende Worte und sortiert dabei die Ergebnisliste nach dem Alphabet. Empfehlenswert in Verbindung mit der Option '-w', da hierbei zwei gleiche Worte auftreten können, die sich zuvor durch Groß/kleinschreibung unterschieden haben"
echo "  -f:<SPALTEN>  faltet die Ausgabedatei \"$fileOut\" nach der angegebenen Anzahl von Spalten. Standard=80"
echo "  -z:<ZEILEN>   maximale Anzahl an Zeilen pro Trainings-Lektion-Stufe. (WARNUNG: Ausführung dauert sehr lange!)"
echo
echo "Beispiel: ./sortWords.sh -w -e -z:4"
exit 0
}

	
#=== Parameter ===
# Datei mit den häufigsten Wörtern der deutschen Sprache. Es ist egal, wie die Wörter von einander getrennt sind.
fileIn=in.txt
# Falls eine benutzerspezifische Zeichenreihenfolge gewählt werden soll, muss sie sich in dieser Datei befinden.
fileKey=key.conf
# Die standard Ausgabedatei
fileOut=out.txt
# Die standard Ausgabedatei für eine KTouch-Lektion
fileKTouch=out.ktouch.xml
# Sollen nur klein geschriebene Worte berücksichtigt werden?
paramSet_k=false
# Sollen alle Worte in kleinschreibweise umgewandelt werden?
paramSet_w=false
# Sollen doppelte Einträge in der Quelldatei igonriert werden? Die Wörter müssen dazu jedoch alphabetisch sortiert werden
paramSet_e=false
# Sollen die Zeilen auf eine Maximale Größe pro Trainigs-Lektion-Stufe begrenzt werden?
paramSet_z=false
# Nach wie vielen Spalten sollen die Zeilen der Ausgabedatei umgebrochen werden?
paramF_Amount=80
# Wie viele Zeilen sind pro Trainings-Lektion-Stufe maximal erlaubt?
paramZ_Amount=4

# Lese die Parameter aus der Kommandozeile aus
for param
do
	case $param in
		-k ) paramSet_k=true;;
		-w ) paramSet_w=true; paramSet_k=true;;
		-e ) paramSet_e=true;;
		-f:[[:digit:]]* ) paramF_Amount=`echo $param | grep -E -o [[:digit:]]+`;;
		-z:[[:digit:]]* ) paramSet_z=true; paramZ_Amount=`echo $param | grep -E -o [[:digit:]]+`;;
		* ) printHelp;;
	esac
done
# TODO: Lese den Letzten Parameter als fileIn raus und Prüfe, ob dieser existiert


#=== Initialisierung ===
# Temporäre Datei
fileTmpFormatted=tmpFormatted.txt

# Falls ein KeyFile existiert, wird es geladen
# Das key-Array enthält die Buchstaben, die in jeder neuen Lektion hinzu kommen
echo -n "Zeichenreihenfolge wird geladen: "
if [ -e $fileKey ]
then
	echo -n "Aus Datei \"$fileKey\"..."
	key=(`grep ^[^#] key.conf | head -n 1`)
else
	echo -n "Standard..."
	# Lade die Standard-Zeichenreihenfolge
	key=(en ar ud it l g c h o s w k p m z b v f ä q j y ü ß ö x)
fi
# Falls der Parameter '-k' NICHT gewählt wurde, füge die großen Buchstaben direkt an die kleinen an.
if [ $paramSet_k = false ]
then
	for smallKey in `echo ${key[*]}`
	do
		bigKey=`echo $smallKey | tr 'a-zäöü' 'A-ZÄÖÜ'`
		list=$list' '$smallKey$bigKey
	done
	key=($list)
fi
echo "OK"


#=== Quelldatei einlesen ===
echo -n "Quelldatei \"$fileIn\" wird eingelesen..."
if [ ! -e $fileIn ]
then
	echo FEHLER: Die Quelldatei $fileIn existiert nicht!
	exit 1
fi
# assertion: Quelldatei existiert
wordsCount=`wc -w $fileIn | grep -E -o [[:digit:]]+`
echo "OK"
echo "Wörter gesamt = $wordsCount"

	
#=== Formatiere den Quelltext ===
	# Entferne alle NICHT-Buchstaben und alle NICHT-Whitespace
	# Ersetze Whitespace durch ein einzelnes LineFeed-Zeichen
	# Wandle alle Großbuchstaben in Kleinbuchstaben um (|tr 'A-ZÄÖÜ' 'a-zäöü' \)
	# Filtere alle ein-buchstabigen Wörter raus
	# Entferne die doppelten Wörter (leider wird hierbei auch sortiert)
	# Schreibe in eine temporäre Datei
echo -n "Formatiere den Quelltext..."
cat $fileIn \
	| tr -d -c 'a-zA-ZäöüÄÖÜß\n\t ' \
	| tr -s [:space:] '\n' \
	| grep -E -x .\{2,\} \
	> $fileTmpFormatted

# Wandle alle Worte in kleinschreibweise um
if [ $paramSet_w = true ]
then
	tr 'A-ZÄÖÜ' 'a-zäöü' < $fileTmpFormatted > $fileTmpFormatted.small
	rm $fileTmpFormatted
	mv $fileTmpFormatted.small $fileTmpFormatted
fi
	
# Entferne doppelte Wörter
if [ $paramSet_e = true ]
then
	sort -u $fileTmpFormatted > $fileTmpFormatted.sorted
	rm $fileTmpFormatted
	mv $fileTmpFormatted.sorted $fileTmpFormatted
fi

# Ausgabe
wordsCount=`wc -l $fileTmpFormatted | grep -E -o [[:digit:]]+`
echo "OK"
echo "Nach dem Filtern bleiben $wordsCount Wörter übrig."


#=== Hauptschleife ===
pOld=.  # Nur initialisierung
rm $fileOut
echo
echo Buchstaben \| Anzahl der neuen Wörter 
echo =====================================
for newKey in `echo ${key[*]}`
do
	pNew=$pNew$newKey
	#Schreibe in Datei
	echo "===$newKey===" >> $fileOut
	grep -E -x [$pNew]+ $fileTmpFormatted \
		| grep -E -x -v [$pOld]+ \
		| tr -s '\n' ' ' \
		| sed -e 's/ $//' \
		>> $fileOut
	echo  >> $fileOut
	#Ausgabe auf die Konsole
	echo $newKey  \|  `grep -E -x [$pNew]+ $fileTmpFormatted | grep -E -x -v -c [$pOld]+`
	pOld=$pNew
done
echo


#=== Faltung ===
echo -n "Falte die Datei \"$fileOut\" nach spätestens $paramF_Amount Spalten..."
fold -s -w $paramF_Amount < $fileOut \
	| sed -e 's/ $//' \
	> $fileOut.wrapped
rm $fileOut
mv $fileOut.wrapped $fileOut
echo "OK"


#=== Zeilen Begrenzung ===
if [ $paramSet_z = true ]
then
	echo -n "Trainings-Lektions-Stufen werden auf $paramZ_Amount Zeilen begrenzt"
	rm -f $fileOut.splitted
	zeilenNr=1
	count=0
	teileNaechsteZeile=false
	zeilenGesamt=`wc -l $fileOut | grep -E -o [[:digit:]]+`
	while [ $zeilenNr -le $zeilenGesamt ]
	do
		zeile=`sed -n ${zeilenNr}p $fileOut`
		if [ `echo $zeile | grep -c ^===` -gt 0 ]
		then
			teileNaechsteZeile=false
			kopfZeile=$zeile
			count=0
			echo -n "."
		else
			if [ $teileNaechsteZeile = true ]
			then
				# insert new line at this position
				echo $kopfZeile >> $fileOut.splitted
				teileNaechsteZeile=false
			fi
			count=`expr $count + 1`
			if [ $count -eq $paramZ_Amount ]
			then
				teileNaechsteZeile=true
				count=0
			fi
		fi
		zeilenNr=`expr $zeilenNr + 1`
		echo $zeile >> $fileOut.splitted
	done
	rm $fileOut
	mv $fileOut.splitted $fileOut
	echo "OK"
fi


#=== Erstelle KTouch-Lektion ===
echo -n "Erstelle KTouch-Lektion \"$fileKTouch\"..."
echo -e "<KTouchLecture>\n"\
		"<Title>Deutsch (Neo2 Sortierte Wörter)</Title>\n"\
		"<Comment>`date -I` - Neo2 - Mit \"$0\" automatisch generierte Datei</Comment>\n"\
		"<FontSuggestions>Monospace</FontSuggestions>\n"\
		"<Levels>" > $fileKTouch	
sed -e 's/^===/  <Level>\n   <NewCharacters>/' \
	-e 's/===$/<\/NewCharacters>/' \
	-e '/^ /! s/$/<\/Line>/' -e '/^ /! s/^/   <Line>/' \
	-e '/^  <Level>/ i\  <\/Level>' \
	$fileOut >> $fileKTouch
sed -e '6d' $fileKTouch > $fileKTouch.tmp #Entferne die erste zu viel eingefügte "  </Level>" Zeile
rm $fileKTouch
mv $fileKTouch.tmp $fileKTouch
echo -e "  </Level>\n </Levels>\n</KTouchLecture>" >> $fileKTouch
echo "OK"


#=== Clean & Exit ===
rm $fileTmpFormatted
exit 0