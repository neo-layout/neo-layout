=Neo 2 unter OpenBSD=

==Vorbereitung==

Ohne eine Installation die UTF-8 verwendet kann es zu schwer zu definieren
Problemen beim Testen der Layouts (unter X) kommen. Ein erster Schritt
sollten also die folgenden Variablen in .profile und .cshrc sein:
  export LANG=de_DE.UTF-8
  export LC_ALL=de_DE.UTF-8

Ein relativ guter Testkandidat der auf den meisten Systemen verfügbar sein
sollte ist Firefox. In der Addresszeile kann schnell überprüft werden ob
z.B. überhaupt irgendwelche Zeichen von Ebene 4 & 6 dargestellt werden
können. Xterm dagegen wird kaum hilfreiche Informationen liefern.

==Wscons==

Der OpenBSD-Kernel verwendet das aus NetBSD stammende wscons. Um ein neues
Layout verwenden zu können muss es erst im Quellcode eingebunden werden.
Dabei wird zunächst ein Layout in wsksymdef.h definiert und dann werden die
vordefinierten Zeichen den passenden Tasten des Layouts in wskbdmap_mfii.c 
zugeordnet. 
In wskbdmap_mfii.c werden dabei (ähnlich wie unter FreeBSD) Tasten mit 
Normal,Shifted, AltGr und Shifted-AltGr definiert. Eine Umlegung von AltGr
ermöglicht also die Verwendung von bis zu 4 Ebenen, wobei es sinnvoll scheint
entweder 4&5 oder 5&6 auszuschliessen.

Aktueller Stand: Noch unvollständig, wer Zeit hat kann gerne helfen.

==X==

Theoretisch sollte linux/X/de auch unter OpenBSD funktioneren, da Xorg
auch hier Standard ist. Abgesehen von Fehlermeldungen für dead_psili 
dead_dasia, die durch NoSymbol ersetzt werden können, funktioniert die
xkb-Datei momentan nicht (r1774).

Aktueller Stand: Funktioniert nicht, wer Zeit hat kann gerne helfen.

==Xmodmap==

Unter Umständen muss Zeile 79 auskommentiert werden, der Fehler liess sich
nicht konsisten rekonstruieren. Ebenen 1-6 sind theoretisch alle verwendbar
wenn 79 nicht auskommentiert wurde, aber mehrere Zeichen, besonders die
griechischen Zeichen, führen zu interessanten Fehlern.

Aktueller Stand: Funktioniert grösstenteils, wer Zeit hat kann gerne helfen.
