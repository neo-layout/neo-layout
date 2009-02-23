Neo-Projekt: Maschinenlesbare Referenz (neo_yaml)

Martin Roppelt (m.p.roppelt ät web in Deutschland)

Ressourcen:
- https://svn.neo-layout.org/grafik/xml-vorschlag/@200
- http://www.eigenheimstrasse.de/~ben/layoutgen/layoutgen/
- svn://svn.tuxfamily.org/svnroot/dvorak/svn/pilotes/trunk/configGenerator/
- http://pyyaml.org/

E-Mails:
   07/07 [neo_layout] Autohotkey und ein paar Ideen
   07/07 [neo_layout] neo.xml
11-12/08 [neo] Referenz als XML für automatische Layout-Generierung
   01/09 Maschinenlesbare Referenz

Funktionsweise:
Menschenlesbare Referenz, Unicode-Hex-Ansicht
<=> Maschinenlesbare Referenz
<=> Treiber, Grafiken:

- XkbMap
- XModMap -> Konsolen-Map, Tastenaufkleber
- KbdNeo
- AHK, Bildschirmtastatur/SVGs
- Mac-Treiber
- Aufsteller, Tabellen
- KTouch-Lektion

Um einen Treiber usw. zu erzeugen, wird ein View benötigt, der die zur 
Darstellung zusätzlich benötigten Daten enthält. Dieser kann auch aus den 
bereits bestehenden Treibern erstellt werden. Wenn man also an der Neo-Belegung 
etwas ändert, kann man so alle Treiber synchronisieren. So lassen sich auch 
rasch aus Belegungen Neo-3-Treiber und Forks erstellen. 

Projektstatus:
Zur Zeit entwickele ich einen Parser für die Referenz. Danach möchte ich ein 
Skript für die Erstellung der neo20.txt aus der maschinenlesbaren Referenz 
schreiben. Dann soll ein Skript zur Umwandlung des Models in xkbmap, xmodmap, 
ahk und kbdneo folgen, unter berücksichtigung der verwendeten Tastatur (Qwertz, 
Qwerty, Plum, Kbdneo). Danach nehme ich die Erzeugung der svgs und odss in 
Angriff.

Abriss:
neo_import.py
parse_neo.py
make_neo.py
parse_hex.py
edit_neo.py
parse_ahk.py
parse_kbd.py
parse_mac.py
parse_map.py
parse_mod.py
parse_xkb.py
parse_grup.py
make_ahk.py
make_kbd.py
make_mac.py
make_map.py
make_mod.py
parse_svg.py
make_svg.py
make_grup.py
layoutify_neo.py