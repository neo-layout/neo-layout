# AHK-Ergänzung für kbd-Layout

Das AHK-Skript »kbd*.ahk« (* steht für neo, bone oder qwertz) schließt die letzten Lücken vom jeweils nativen Treiber (kbd*)

## Erweiterungen

### Caps- und ModLock
* CapsLock durch Shift+Shift
* Mod4Lock durch Mod4+Mod4


### Funktionstasten
| Funktionstaste | Ebene 4 (Neo) | Ebene 4 (Bone) | Ebene 4 (Qwertz) |
| -------------- | ------ | ------ | ------ |
| »Bild auf«     | Mod4+X | Mod4+J | Mod4+Q |
| »Löschen«      | Mod4+V | Mod4+D | Mod4+W |
| »Pfeil hoch«   | Mod4+L | Mod4+U | Mod4+E |
| »Entfernen«    | Mod4+C | Mod4+A | Mod4+R |
| »Bild runter«  | Mod4+W | Mod4+X | Mod4+T |

| »Pos 1«        | Mod4+U | Mod4+C | Mod4+A |
| »Pfeil links«  | Mod4+I | Mod4+T | Mod4+S |
| »Pfeil runter« | Mod4+A | Mod4+I | Mod4+D |
| »Pfeil rechts« | Mod4+E | Mod4+E | Mod4+F |
| »Ende«         | Mod4+O | Mod4+O | Mod4+G |

| »Escape«       | Mod4+Ü | Mod4+F | Mod4+Y |
| »Shift+Tab«    | Mod4+Ö | Mod4+V | Mod4+X |
| »Einfügen«     | Mod4+Ä | Mod4+Ü | Mod4+C |
| »Enter«        | Mod4+P | Mod4+Ä | Mod4+V |
| »Undo«         | Mod4+Z | Mod4+Ö | Mod4+B |

## Kompilieren

- ggf. Dateipfad für AutoHotkey in `make-build.bat` anpassen
- `make-build.bat`ausführen

Anschließend liegen im \bin-Order die drei kbd*-Skripte.
