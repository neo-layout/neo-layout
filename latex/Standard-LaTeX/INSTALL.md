# Anleitung zur Benutzung von Unicode-Zeichen in LaTeX

Einige seltenere Unicodezeichen werden schon von aktuellen LaTeX-Distributionen
unterstützt, jedoch sind auf der NEO-Tastaturbelegung noch einige, die noch
nicht direkt unterstützt werden, z.B. griechische Buchstaben oder
sonstige mathematische Sonderzeichen.
Wenn man jedoch die hier bereitgestellte `uniinput.sty` verwendet (welche erst
noch automatisiert aus den hier mitgelieferten Quellen erstellt werden muss),
kann man fast alle in Neo enthaltenen Unicode-Zeichen direkt in sein LaTeX-Dokument
(.tex-Datei) eingeben.

## Installation

### Schritt 1: Kompilieren
Kompiliert man die uniinput.ins mit
`latex uniinput.ins`, wird die benötigte uniinput.sty erzeugt.

Kompiliert man die uniinput.dtx mit
`pdflatex uniinput.dtx` (man erhält eine PDF-Datei) oder `latex uniinput.dtx` (man erhält eine dvi-Datei), so erhält man die Dokumentation zum uniinput-Paket.

### Schritt 2: Kopieren
Nun muss man die Datei `uniinput.sty`
in das gleiche Verzeichnis wie die tex-Datei kopieren.

Soll die Datei ständig auf dem Rechner sein und immer verfügbar, so muss man sie
in einen von LaTeX durchsuchten Ordner kopieren und danach mit dem Befehl
`mktexlsr` die LaTeX-Bibliothek aktualisieren.

### Schritt 3: Einbinden
Außerdem muss man noch die Zeile
```
\usepackage{uniinput}
```
in die Präambel seiner tex-Datei schreiben (statt `\usepackage[latin1]{inputenc}`
oder Ähnlichem).  Ferner ist zu beachten, dass keine Kombination mit dem
unicode-math Paket (bei XeTeX oder LuaTex) sinnvoll ist.

### Optional: uniinput selbst erweitern
Um die Datei mit weiteren Zeichen zu ergänzen, muss man weitere Zeilen in die
`uniinput.dtx` nach diesem Schema einfügen:
```
\DeclareUnicodeCharacter{03B1}{\ensuremath{\alpha}}
```
für das α (kleines Alpha) zum Beispiel. Dabei steht 03B1 für die
Unicodebezeichnung, die man irgendwo im Internet (z. B. auf Wikipedia) oder mit Programmen wie „gucharmap“ findet.

## Weitere Infos
Weitere und ausführlichere Dokumentation ist in der in Schritt 1 erzeugten
Dokumentation zu finden.

## FAQ
Bei Problemen erst mal in die FAQ schauen, das meiste ist bekannt.
