==Windows-Treiber==
Leider gibt es bislang noch keine eigene Installationsroutine. Zur Installation
muss deshalb zur Zeit noch die MSKLC-Variante installiert werden, anschließend 
muss die NEO20.dll-Datei im Ordner \WINDOWS\system32 mit der hier vorhandenen 
Datei überschrieben werden.

1.) MSKLC-Variante installieren
2.) NEO20.dll nach \WINDOWS\system32 kopieren und die dort vorhandene Version
    überschreiben

Es ist keine Registry-Änderung mehr nötig!



==Einschränkungen des Windows-Treibers==
1.) Einige Steuertasten lassen sich (noch?) nicht belegen und stehen deshalb 
nicht zur Verfügung.
Dazu gehören leider auch die Pfeiltasten, Entf, Seite
hoch/runter, Einfg, Pos1 und Ende.
2.) Ein Einrasten von Modifiern ist leider nicht möglich.
3.) Bei vielen Programmen wird die Kombination Alt+Strg+… für Shortcuts verwendet 
und kann so in Konflikt mit den höheren Ebenen (Ebene 4 und 6) kommen.
4.) Die Belegung des Ziffernblocks ist noch unvollständig.
5.) Es gibt keine Kombo-/Komponier-/Compose-/Multi-Key-Taste.