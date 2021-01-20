# Neo 2.0 für Windows
Für viele Windowsversionen sind hier Treiber zu finden. Weitergehende Hinweise und Anleitungen befinden sich im Wiki unter [Neo unter Windows einrichten](https://git.neo-layout.org/neo/neo-layout/wiki/Neo-unter-Windows-einrichten).

## neo-vars
Hier befindet sich ein Treiber, der mit der Autohotkey-Skriptsprache (https://www.autohotkey.com) erstellt wurde. Hierfür muss lediglich eine ausführbare EXE-Datei heruntergeladen und gestartet werden.
Dazu benötigt man insbesondere keine Administratorrechte, wenn man das Programm beispielsweise in dem Verzeichnis „Eigene Dateien“ abspeichert, so dass sich dieser Treiber gut zum schnellen Ausprobieren von NEO eignet. Zudem kann man diesen Treiber etwa von einem USB-Stick aus starten, wenn man auf einem fremden Rechner arbeiten muss/will.

## ahk-auslaufend
Dies ist der »klassische« autohotkey-Treiber. Er ist jedoch als veraltend anzusehen; Nutzer sollten stattdessen seinen Nachfolger neo-vars benutzen.

## kbdneo2
Hier entsteht mit Hilfe des [Windows Driver Kit](https://docs.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk) ein nativer Windowstreiber mit allen 6 Ebenen, um Neo dauerhaft als Tastaturlayout auf einem Windows-PC zu installieren.
In dem Ordner befinden sich der Treiber für viele Windowsversionen und auch die Quelldateien. Bitte die jeweilige README.txt beachten. Dieser Treiber ist der älteren MSKLC-Variante überlegen.

## msklc
Im Verzeichnis msklc befanden sich Dateien, die mit dem MS Keyboard Layout Creator erstellt wurden. Dieser Treiber ist jedoch nicht mehr aktuell, stattdessen sollte der kbdneo2-Treiber installiert werden. In dem Verzeichnis befindet sich lediglich noch eine Anleitung für »Alt-Nutzer«, wie der msklc komplett deinstalliert werden kann.
