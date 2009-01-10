== Hinweise für Entwickler ==

=== AutoHotkey herunter laden ===
Man sollte als erstes das Programm namens »AutoHotkey« (http://www.autohotkey.com/download/AutoHotkeyInstall.exe) herunterlanden. Es wird empfohlen, dieses Programm möglichst in dem vorgeschlagenen Standardverzeichnis zu installieren.
Wenn man jedoch über KEINE Administratorrechte verfügt, kann man das Programm beispielsweise auch in das Verzeichnis »Eigene Dateien/Neo«  (oder in ein anderes Verzeichnis, für das man Schreibrechte hat) installieren.
In diesem Fall muss dann für eine Kompilierung des Skriptes noch die Datei Build-Update.bat lokal entsprechend angepasst werden (diese lokale Änderung der Build-Update.bat aber bitte nicht einchecken, da die allermeisten Entwickler Autohotkey im vorgeschlagenen Standardverzeichnis installiert haben!).

=== Die ausführbare Datei aktualisieren ===
Um die neo20.exe auf den neuesten Stand zu bringen, reicht (wenn Autohotkey im Standardverzeichnis installiert wurde) ein Doppelklick auf die Batch-Datei Build-Update.bat
Es ist empfehlenswert, diese Batch-Datei stets vor einem Commit auszuführen, damit die .exe-Datei immer auf dem aktuellsten Stand ist.

=== Den Sourcecode bearbeiten ===
Die Datei neo20.ahk sollte auf keinen Fall mehr direkt bearbeitet werden, da sie inzwischen automatisch generiert und regelmäßig überschrieben wird.

Stattdessen müssen die Dateien/Module im Source-Unterverzeichnis bearbeitet werden, etwa:
Source\Keys-Neo.ahk
Source\Keys-Qwert-to-Neo.ahk
Source\Methods-Layers.ahk
Source\Methods-Lights.ahk

Um die gemachten Änderungen zu testen, sollte die Datei Source\All.ahk verwendet werden, die alle Module einbindet und regulär durch einen Doppelklick mit dem AHK-Interpreter gestartet werden kann.

Der große Vorteil dieser Methode liegt darin, dass sich die Zeilennummern eventueller Fehlermeldungen nicht mehr auf die große »vereinigte« AHK-Datei, sondern auf die tatsächlich relevanten Module beziehen, z. B. :
Error at line 64 in #include file "C:\...\autohotkey\Source\Methods-Lights.ahk"
Line Text: CTL_CODE_LED(p_device_type, p_function, p_method, p_access)
Error: Functions cannot contain functions.
The programm will exit.

=== Links zur AHK/Autohotkey-Skriptsprache ===
Eine kurze Einführung (Installation und Beispielskript) findet man etwa auf
http://www.kikizas.net/en/usbapps.ahk.html

Eine alphabetische Liste aller erlaubten Kommandos findet man online unter
http://www.autohotkey.com/docs/commands.htm

=== Coding-Style ===
Der Programmcode sollte möglichst einheitlich formatiert werden, um mögliche Fehlerquellen auszuschließen und um optimale Lesbarkeit zu erreichen:

== Zuweisungen mit ":=" ==
AHK erlaubt mehrere Arten der Zuweisung. Um Missverständnissen vorzubeugen, möge ausschließlich die Zuweisung mittels ":=" Verwendung finden. Die Zuweisung mit einem "=" funktioniert zwar auch und erspart bei Zuweisung konstanter Zeichenfolgen auch die Anführungszeichen, sorgt aber spätestens bei Berechnungen für Verwirrung.

== Funktionale If-Abfrage ==
Abfragen mittels "if" können in AHK auf zwei unterschiedliche Arten erfolgen, die sich durch die Klammerung des Ausdrucks unterscheiden. Um auch hier Missverständnissen vorzubeugen, mögen sämtliche Abfragen in eine gemeinsame Klammer gefasst werden.

== Möglichst auf %-Variablen verzichten ==
Gibt es von einer Funktion oder Methode zwei Varianten, so ist die Variante vorzuziehen, bei der Variablen nicht mit %varname% escaped werden müssen (analog zur Zuweisung mit ":="), um Missverständnissen vorzubeugen.

== Einrückung ==
Einrückung einheitlich 2 Zeichen vor dem Beginn der Zeile, dazwischen einheitlich 1 Zeichen. Dient es der Lesbarkeit, z.B. die Abfragen einer "if"-Abfrage mit der darunter liegenden "else if"-Abfrage auszurichten, darf dies stattfinden.

== Geschwungene Klammern ==
Geschwungene Klammern zum Zusammenhalten eines Funktionsblocks oder If-Zweiges mögen dem Funktionsnamen bzw. if-Zweig folgen. Bei If-Abfragen möge "else" mit einem Leerzeichen Abstand an die schließende Klammer angehängt werden, woran dann gegebenenfalls die nächste öffnende Klammer mit einem Leerzeichen angehängt wird.