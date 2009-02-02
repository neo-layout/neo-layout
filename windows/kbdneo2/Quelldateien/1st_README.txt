1. WinDDK installieren (Bestandteil von WDK, über das MSDN zu erhalten).

2. Im Ordner \src\input\layout\all_kbds\ des WDKs einen neuen Ordner namens 'kbdneo2' anlegen.

3. Alle Quelldateien in diesen Ordner kopieren.

4. Die Datei 'dirs' im Ordner \src\input\layout\all_kbds\ des WinnDDKs um die Zeile 'kbdneo2' erweitern. Die Datei könnte nun so aussehen:

***Anfang der Datei***
 DIRS= \
     kbdfr \
     kbdgr \
     kbdneo2
***Ende der Datei***

Bei der neusten Version des WDKs ist dies anscheinend nicht mehr nötig

5. Mit einem normalem Texteditor können nun die Quelldateien bearbeitet werden. Kommentare befinden sich in den jeweiligen Dateien.

6. Zum kompilieren des Treibers die 'Checked Build Environment' starten und zum Ordner mit den Quelldateien wechseln und den Befehl »Build« ausführen.

cd src\input\layout\all_kbds\kbdneo2
build
