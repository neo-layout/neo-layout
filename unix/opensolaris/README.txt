= Neo 2 unter OpenSolaris =

== Neo 2 an der Konsole ==

Bisher existiert kein Treiber für die Konsole. Es wird vermutlich auch in
abschaubarer Zeit keiner verfügbar sein durch die Architektur von Solaris,
welche unterschiedliche Layouts im Kernel implementiert. 

Aus man kbd:
  To set the language by default, set the LAYOUT  variable in
  the  file /etc/default/kbd to the expected language. These
  languages supported in kernel can be found by running kbd
  -s. Other values are ignored. 

== Neo 2 unter X ==

Die Verwendung von linux/X/de funktioniert bisher noch nicht.

Die von Linux bekannte xmodmap-Datei enthält eine Änderung von
Super_R auf Meta_R und eine ISO_Level3_Shift-Definition wurde auskommentiert.
Nach dem üblichen Aufruf über xmodmap sollte die Datei
unix/opensolaris/xmodmap/neo_de.xmodmap ohne Probleme Ebene 1-5 ansprechen.
Ebene 6 ist, möglicherweise durch die entfernte Definition, nicht zugänglich.

== Fehlerbehebung ==
Zunächst sollte sichergestellt sein dass die Umgebung eine korrekte Locale
verwendet, da dies sonst an vielen Stellen Probleme verursacht. Am einfachsten
ist dies global möglich in /etc/timezone indem man LANG wie folgt setzt:
LANG=de_DE.UTF-8

Wenn das Setzen der Locale Schwierigkeiten bereitet ist aber StarOffice eine 
gute Möglichkeit Sonderzeichen dargestellt zu bekommen auch ohne die Locale
korrekt zu setzen.

== TODO ==
* Durchtesten der Modifier für Xmodmap
* Fehlersuche für linux/X/de
* Ist NEO 1 in xkb/symbols? (Nein)
* Treiber für Konsolenmodus (bleibt aus)
