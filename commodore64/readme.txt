C=64 NEO-Tastaturtreiber

Auch für den alten 64er ist jetzt ein NEO-Tastaturtreiber zu haben. Der Treiber befindet sich in einem Alphastadium, also ist weitgehend ungetestet, da ich hier zur Zeit noch keine Möglichkeit habe, die Dateien auf einen echten C64 zu übertragen. Deshalb beschränkt sich der (erfolgreiche) Test bislang auf den C64-Emulator >>VICE.

Programmiert sind sie mit Hilfe von >>ACME, mehr zum 65xx-Crossassembler ACME findet man in der 64er-Ecke. Zu dem Treiber ist nicht viel zu sagen, außer dass er ganz normal mit »LOAD "NEO-TREIBER.PRG", 8« geladen werden kann und mit RUN gestartet. Die Treiberroutine kopiert sich daraufhin nach $c000 (12*4096) und aktiviert sich.

Ausschalten läßt sich der Treiber einfach durch den Run/Stop-Restore Warmstart.
Probleme und ToDo

Da der 64er-Emulator VICE, den ich für die Entwicklung benutzt habe, sein Keyboard etwas seltsam belegt, läßt sich für mich nicht eindeutig bestimmen, ob alle Tasten richtig kommen. Außerdem enthält das NEO-Layout normalerweise deutsche Sonderzeichen, die beim C64 allerdings nicht vorhanden sind. Daher wurden auf die entsprechenden Tasten Klammern und dergleichen gelegt.

Ebenfalls wurde die CTRL-Ebene für die Alpharelease noch nicht angepasst. Erstmal abwarten, ob sich jemand dafür interessiert, bevor ich mir die Mühe mache.

Es macht ebenfalls kaum Mühe ein entsprechend gepatchtes Kernel zu stellen, indem man die Layout-Tabellen einfach an die entsprechende Stelle kopiert. Für eine Alpharelease ging mir das allerdings erstmal zu weit.
Randbemerkungen

Man findet als Anfang vom Assemblerprogramm einen trickreichen Aufbau, der auch auf andere solche Programme übertragbar ist. Der Basic-Aufruf der Startroutine per SYS und Zeilennummern und die ganze Struktur ist schon in der Assemblerdatei fertig gemacht.

Wenn man "dest" anders legt, kann der NEO-Treiber eigentlich an jede beliebige Stelle im Speicher installiert werden, solange keine Bankswitches und Memorymappings über das Prozessoreregister dafür notwendig werden.

In den Keytabellen habe ich die Originalzeilen mit ";" als Kommentar ausgeklammert, damit man sehen kann auf welche Originalzeichen die entsprechenden NEO-Zeichen belegt wurden. Fehler lassen sich so leichter finden und korrigieren.
