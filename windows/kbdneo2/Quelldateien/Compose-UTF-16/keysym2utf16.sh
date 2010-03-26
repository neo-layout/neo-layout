#!/bin/bash

# Konvertiert die Compose-Definitionen für
# den kbdneo-Treiber ins UTF-16-Format
#
# Author: Erik Streb
# Licence: GPL v3 or later
# Date: 2010-03-26

SEDDATEI=keysym2utf16.sed

# neueste keysymdef.h aus dem git-Repo von X.org
wget -O keysymdef.h http://cgit.freedesktop.org/xorg/proto/xproto/plain/keysymdef.h

# daraus eine sed-Datei erstellen
sed -n -e 's%^\(#define\ XK_\)\([a-zA-Z0-9_]\+\)\(\ \+0x[0-9a-fA-F]\+\ \+/\*[\ (]\+\)\(U+\)\([0-9a-fA-F]\+\)\(\ .*\)%s\%<\2>\%0x\5\%g% p' keysymdef.h > $SEDDATEI

mkdir -p utf-16
for i in ../../../../Compose/src/*; do
	AUSGABE=utf-16/$(basename $i).kbdneo

	# generierte sed-Datei mit einem kleinen Zusatz anwenden
	sed -e 's%\(<\)\(U\)\([0-9a-fA-F]\+\)\(>\)%0x\3%g' -f $SEDDATEI $i > $AUSGABE && echo "$AUSGABE erzeugt"
done

