== Kompilieren ==
Kompiliert man die uniinput.dtx mit LaTeX 
	latex uniinput.dtx
oder
	pdflatex uniinput.dtx
so erhält man die Dokumentation zu dem Paket. Kompiliert man die uniinput.ins mit
	latex uniinput.ins
wird eine uniinput.sty erzeugt. 

=== Kopieren ===
Wenn man auch seine tex-Dateien mit Neos Zeichenvielfalt beschreiben will (zum
Beispiel griechische Buchstaben oder sonstige mathematische Sonderzeichen),
dann muss man sich die Datei
	uniinput.sty
in das gleiche Verzeichnis, wie die tex-Datei kopieren.
Soll die Datei ständig auf dem Rechner sein und immer verfügbar, so muss man sie
in einen von LaTeX durchsuchten Ordner kopieren und danach mit dem Befehl mktexlsr
die LaTeX-Bibliothek aktualisieren.

=== Wichtige Zeile ===
Außerdem muss man natürlich noch die Zeile
	\usepackage[utf8]{inputenc}
in seine tex-Datei schreiben (statt \usepackage[latin1]{inputenc} oder
Ähnlichem).

=== Erweitern ===
Um die Datei mit weiteren Zeichen zu erweitern, muss man einfach weitere
Zeilen in die uniinput.dtx nach diesem Schema einfügen:
	\DeclareUnicodeCharacter{03B1}{\ensuremath{\alpha}}
für das α zum Beispiel. Dabei steht 03B1 für die Unicodebezeichnung, die man
irgendwo im Internet (z. B. auf Wikipedia) oder mit Programmen wie „gucharmap“
findet.


