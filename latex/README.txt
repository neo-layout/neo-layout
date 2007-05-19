== Kleine Anleitung ==
In der Datei unicode.sty werden die Unicodebezeichnungen zu Latex-Symbolen
gemacht, man kann also direkt sämtliche Sonderzeichen eingeben, die in der
unicode.sty erfasst sind.

=== Kopieren ===
Wenn man auch seine tex-Dateien mit Neos Zeichenvielfalt beschreiben will (zum
Beispiel griechische Buchstaben oder sonstige mathematische Sonderzeichen),
dann muss man sich die Datei
	unicode.sty
in das gleiche Verzeichnis, wie die tex-Datei kopieren.

=== Wichtige Zeile ===
Außerdem muss man natürlich noch die Zeile
	\usepackage[utf8]{inputenc}
in seine tex-Datei schreiben (statt \usepackage[latin-1]{inputenc} oder
Ähnlichem).

=== Erweitern ===
Um die Datei mit weiteren Zeichen zu erweitern, muss man einfach weitere
Zeilen nach diesem Schema einfügen:
	\DeclareUnicodeCharacter{03B1}{\ensuremath{\alpha}}
für das α zum Beispiel. Dabei steht 03B1 für die Unicodebezeichnung, die man
irgendwo im Internet (z. B. auf Wikipedia) oder mit Programmen wie „gucharmap“
findet.


