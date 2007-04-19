== Installation ==
Hierfür braucht man keine Administratorrechte, es muss jedoch zuerst ein
Programm namens „autohotkey“
(http://www.autohotkey.com/download/AutohotkeyInstall.exe) installiert werden.
Dazu benötigt man KEINE Administratorrechte, wenn man das Programm
beispielsweise in das Verzeichnis „Eigene Dateien/NEO“ installiert.

=== ahk-Dateien ===
Danach kann man .ahk-Skripte mit einem Doppelklick starten. Man erhält dann ein Systray-Icon, mit dem man das Skript vorübergehend deaktivieren (Suspend) oder
komplett beenden kann.
Wenn das Öffnen nicht direkt funktioniert: Öffnen mit -> Autohotkey.exe
auswählen -> Immer mit diesem Programm öffnen.

=== Automatischer Start ===
Bei Bedarf kann man sich eine Verknüpfung mit neo20.ahk in den Autostart-Ordner
legen, dann hat man das Layout direkt bei der Anmeldung.

== Wie es funktioniert ==
Das Programm kann alle Tastendrucke abfangen und statt dessen andere Tasten
simulieren. Die Zeile
  a::send b
fängt z. B. die Taste a ab und sendet statt dessen ein b.
Die ahk-Dateien lassen sich mit einem Texteditor bearbeiten, man muss dann nur
das Skript neu starten um die Änderungen zu übernehmen.

== Bekannte Fehler ==
AltGr scheint recht buggy zu sein, siehe
http://www.autohotkey.com/forum/topic10169.html. Vielleicht hilft es, die
Umbelegung von AltGr in eine Extra-Datei zu schreiben.

