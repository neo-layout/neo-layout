# Informationen über Compose
Für die Installation und den Gebrauch der Compose-Funktion siehe [Tote Tasten und Compose](https://neo-layout.org/Benutzerhandbuch/Tote-Tasten-und-Compose/)

Für technische Informationen zur Bearbeitung der Compose-Kombinationen siehe [Erzeugbare Zeichen mit Compose](https://neo-layout.org/Benutzerhandbuch/Tote-Tasten-und-Compose/#erzeugbare-zeichen-mit-compose)

## Dateien in diesem Directory

src/*.module
: Enthält die Quelldateien für verschiedene Module der Compose-Datei.
  Die Gliederung ist thematisch.

src/*.remove
: Enthält Konflikte mit anderen Modulen. Der Inhalt dieser Dateien wird beim
  Laden des entsprechenden Moduls gelöscht.

Makefile
: Erstellt aus den Modulen eine oder mehrere lauffähige
  XCompose-Dateien.

compose_gui.sh
: Graphisches Frontend (je nach System kdialog oder zenity) für
  `make config && make install`

XCompose* 
: Lauffähige Compose-Datei (werden mittels Makefile erzeugt).  Sie ist
  unter Linux unter dem Namen ${HOME}/.XCompose zu speichern.
