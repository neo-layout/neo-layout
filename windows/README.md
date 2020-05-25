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

## Eingabe beliebiger Unicode-Zeichen unter Windows
Hierzu muss in der Registry der Schlüssel
`HKEY_Current_User/Control Panel/Input Method/EnableHexNumpad`
angelegt und auf den Wert `1` (vom Typ REG_SZ, d.h. »Zeichenkette«) gesetzt sein. Diese Änderung wird erst nach einem Neustart wirksam.

Anschließend können beliebige Unicode-Zeichen über die Angabe des heximalen Unicode-Wertes eingeben werden, beispielsweise das Unendlich-Zeichen ∞ (=U+221E): Alt herunterdrücken, 2 2 1 E, Alt loslassen 

Alternativ (oder wenn die Eingabe ein bischen komfortabler erfolgen soll) kann auch das folgende kleine Programm genutzt werden:
[UnicodeInput](http://www.fileformat.info/tool/unicodeinput/index.htm) — a utility to enter Unicode characters on Microsoft Windows



## Windows 95 und 98
Für Windows 95 und 98 gibt es nur die Version 1 von NEO. Und zwar hier: [Link fehlt!]

[Zu klären/testen: Funktioniert der ahk oder der kbdneo2 auch noch unter Windows 95? Benutzt das noch jemand?]

Der AHK funktioniert afaik nicht unter Windows 95/98.

