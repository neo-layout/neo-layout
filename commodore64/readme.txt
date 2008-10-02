= C64 Neo-Tastaturtreiber =
Auch für den alten 64er ist jetzt ein Neo-Tastaturtreiber zu haben. Der Treiber (Version 1.0 von Neo, nicht das aktuellen Neo 2) befindet sich in einem Alphastadium, also ist weitgehend ungetestet, da ich hier zur Zeit noch keine Möglichkeit habe, die Dateien auf einen echten C64 zu übertragen (bitte berichten, wenn es Erfolge gibt). Deshalb beschränkt sich der (erfolgreiche) Test bislang auf den C64-Emulator VICE.

Programmiert sind sie mit Hilfe von ACME (mehr zum 65xx-Crossassembler ACME findet man in der 64er-Ecke).

== Treiberdateien ==
Die Treiberdateien und Quellen dazu gibt es hier: commodore64. Benötigt wird für den Betrieb nur die Datei neo-layout.prg.

== Wie aktivieren ==
Zum Treiber ist nicht viel zu sagen, außer dass er ganz normal mit
  LOAD "NEO-LAYOUT.PRG", 8
geladen werden kann und mit
  RUN
gestartet wird. Die Treiberroutine kopiert sich daraufhin nach $c000 (12*4096) und aktiviert sich.

== Wie deaktivieren ==
Ausschalten lässt sich der Treiber einfach durch den Run/Stop-Restore-Warmstart.

== Probleme und TODO ==
Da der 64er-Emulator VICE, den ich für die Entwicklung benutzt habe, seine Tastatur etwas seltsam belegt, lässt sich für mich nicht eindeutig bestimmen, ob alle Tasten richtig kommen. Außerdem enthält das Neo-Layout normalerweise deutsche Sonderzeichen, die beim C64 allerdings nicht vorhanden sind. Daher wurden auf die entsprechenden Tasten Klammern und dergleichen gelegt.

Ebenfalls wurde die CTRL-Ebene für diesen Alphaversion noch nicht angepasst. Erstmal abwarten, ob sich jemand dafür interessiert, bevor ich mir die Mühe mache.

Es macht ebenfalls kaum Mühe einen entsprechend gepatchten Kernel zu erstellen, indem man die Layout-Tabellen einfach an die entsprechende Stelle kopiert. Für eine Alphaversion ging mir das allerdings erstmal zu weit.

== Randbemerkungen ==
Man findet als Anfang vom Assemblerprogramm einen trickreichen Aufbau, der auch auf andere solche Programme übertragbar ist. Der Basic-Aufruf der Startroutine per SYS und Zeilennummern und die ganze Struktur ist schon in der Assemblerdatei fertig gemacht.

Wenn man dest anders legt, kann der Neo-Treiber eigentlich an jede beliebige Stelle im Speicher installiert werden, solange keine Bankswitches und Memorymappings über das Prozessorregister dafür notwendig werden.

In den Keytabellen habe ich die Originalzeilen mit einem Semikolon (;) als Kommentar ausgeklammert, damit man sehen kann auf welche Originalzeichen die entsprechenden Neo-Zeichen belegt wurden. Fehler lassen sich so leichter finden und korrigieren.
