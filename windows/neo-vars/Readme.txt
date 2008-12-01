NEO-vars
========

NEO-vars ist die nunmehr zweite Implementierung des NEO-Tastaturlayouts
in der Programmiersprache AutoHotKey (auch AHK), www.autohotkey.com.
Statt mit langen if-then-else-Bäumen auf getrennten Key-Hooks
arbeitet neo-vars mit einem globalen, für (fast) alle Tasten
durchlaufenen Key-Hook (keyhooks.ahk), der nicht nur für key-press
sondern auch für key-release (up) verwendet wird.

Der Key-Hook durchläuft die Funktion AllStar (varsfunctions.ahk), in
der der Name der gedrückten Taste (PhysKey, dann ActKey) um die
aktuelle Ebenennummer erweitert wird und das Ergebnis als Variable
abgefragt wird. Diese Variable (gespeichert in char) sagt nun, was
sich hinter dem Tastendruck für ein Zeichen (z.B. „U0041“ für ein
großes A) oder auch Sonderzeichen (z.B. „SComp“ für Compose), oder
auch Unterprogrammaufruf (z.B. „P_EHt“ für das Umschalten des
Einhand-Modus) verbirgt. Dieser „Lookup“, den man in „besseren“
Programmiersprachen mit assoziativen Hash-Arrays implementiert, wird
in AHK über dynamische Variablenabfragen gemacht, wobei diese Variablen
vorher definiert wurden.

Variablen werden aber nicht nur für die Zuweisung Ebene+Taste=Zeichen
(keydefinitions.ahk) verwendet, sondern auch für Shortcuts
(shortcuts.ahk), die später dazu dienen, aus abstrakten Zeichen
wieder von Programmen verwendbare Tastendrücke zu machen: Aus
„SHome“ wird beispielsweise über »send« wieder „{Home down}“ für den
Tastendruck und „{Home up}“ für das Loslassen. Auch für Buchstaben
und Sonderzeichen wird diese Methode verwendet, um größtmögliche
Kompatibilität mit normalen Programmen zu gewährleisten. Alles,
wofür es keine Shortcuts gibt, wird als unicode-Zeichen an die
Applikation geschickt. Ein paar wenige Zeichen können nicht oder nur
schwer durch getrennte Down-Up-Sequenzen umgesetzt werden; an diesen
Stellen wird auf den getrennten Key-Release verzichtet und das
Zeichen bzw. eine dafür notwendige Zeichenfolge über das gute alte
»send« geschickt.

Zweiter wichtiger und auch für den Benutzer spürbarer Unterschied
zum alten AHK-Skript ist die Unterstützung von Key-Press und
-Release (down- und up-events), wodurch z.B. manche Programme erst
benützbar werden wie z.B. Spiele, die die Dauer messen, für die eine
Taste niedergedrückt ist. Dafür muss sich das Skript aber für jede
Taste merken, was es bei einem späteren Release für ein Zeichen
schicken muss, damit keine Taste „hängen“ bleibt. Auch diese
Informationen werden in Variablen gespeichert, deren Namen mit dem
Scancode/Virtualcode der Taste zusammenhängen.

Ähnlich werden Compose-Sequenzen unterstützt: Ist eine Variable
definiert, die darauf hinweist, dass die bisherige Sequenz ein
Compositum ist, wird dieses dargestellt. Ist eine andere Variable
definiert, die sagt, dass bis zu einem fertigen Compositum noch mehr
Zeichen kommen können, wird das aktuelle Zeichen nicht ausgegeben
und stattdessen dem Compositum angehängt. Die dafür nötigen
Variablen werden von einem Extra-Skript aus den definierten
Compose-Sequenzen erstellt und als AHK-Code abgespeichert
(compose.generated.ahk). Hier ist von Vorteil, dass AHK fast beliebig
lange Variablennamen unterstützt.

Mit der Verwendung von Unterprogrammen, sowohl beim Drücken von
Tasten, als auch bei Composita, eröffnen sich interessante
Möglichkeiten, die z.T. noch garnicht ausgeschöpft sind. Ein paar
Schmankerln sind aber jetzt schon eingebaut, wofür aber z.T.
auch Hooks bemüht werden müssen.

Erst diese Key-Hooks an mehreren Stellen machen Spezial-Modi
möglich: Es gibt einen Physical-Key-Hook, der z.B. für die
Implementierung des einhand-Neo verwendet wird (einhandneo.ahk). Er
kann unter entsprechenden Nebenbedingungen, wie hier dem
Gedrückthalten der Space-Taste, Tastencodes austauschen. Ein weiterer
Key-Hook ermöglicht das Abfangen sämtlicher Tastendrücke für z.B.
einen Römische-Zahlen-Modus (tools.ahk), um den gewohnten Ablauf zu
ändern, um also hier die gedrückten Ziffern als Dezimalzahl zu
interpretieren und in die für sie nötigen römischen
Zahlen-Buchstaben umzuwandeln. Ähnlich funktioniert auch der
generische Unicode-Zeichengenerator über ♫uu.

Eine weitere Stelle für Hooks ist die Ausgabefunktion, die derzeit
für das Decodieren von Unicode-Zeichen verwendet wird: ♫dd und dann
ein Zeichen eingeben, das auch über ein Compositum entstanden sein
kann, und ein kleiner ToolTip gibt den entsprechenden
Unicode-Codepoint aus (tools.ahk).

Die Bildschirmtastatur (M3+F1) reagiert nunmehr dynamisch auf die
verschiedenen aktivierten Ebenen, d.h. mit dem Drücken eines
Modifiers wird automatisch die entsprechende Ebene angezeigt, ohne
dass man diese manuell wählen müsste. Im CapsLock-Modus funktioniert
das noch nicht richtig, da sich dort Buchstaben und Sonderzeichen
unterschiedlich verhalten und wir dafür noch zwei zusätzliche PNG-
Dateien brauchen. Abgesehen davon gibt es Überlegungen, die
Bildschirmtastatur komplett dynamisch zu machen, das heißt, dass man
auch die zu erwartenden Compose-Sequenzen sehen kann. Wenn man also
das tote Hochkomma ́ tippt, würde die Bildschirmtastatur für die
solcherart unterstützten Tasten die Buchstaben mit Apostroph
darstellen. Ob das aber so einfach geht, ist nicht ganz klar:
Erstens muss die Ausgabe ausreichend gut ausschauen, zweitens muss
die Existenz eines dafür ausgelegten Unicode-Fonts sichergestellt
sein, und schließlich muss man die entsprechenden Windows-Funktionen
umständlich über DLL-Calls aufrufen, um die AHK-Beschränkung auf die
System-Codepage zu überwinden. Ob diese Funktion dann auch die
benötigte Performance hat, müsste sich erst weisen.

Das AHK-Skript (leider nicht das EXE) bindet jetzt eine eventuell
bestehende individuelle Datei aus dem NEO2-Applikationsverzeichnis
ein (custom.ahk). Überhaupt sind die Spezialmodi wie EinHand-Neo,
Lernmodus und Lang-s-Tastatur in eigene „Module“ ausgelagert worden,
die den restlichen Code überhaupt nicht mehr tangieren. Das bedeutet
einerseits, dass man sie einfacher warten kann, andererseits auch,
dass sie durch diese leicht zu durchschauende Kapselung als Vorlage
für individuelle Erweiterungen zur Verfügung stehen. So wäre
denkbar, dass man auch die normale Belegung in ein Modul packt, das
dann recht einfach und unabhängig vom restlichen Code gewartet
werden kann. Auch die etwas eingeschlafene Diskussion über die
Tastenbelegung von NEO3 kann über diesen übersichtlichen Mechanismus
schnell wieder aufgenommen werden.

Auf kurze Sicht steht eine automatische Tasten-Layout-Generierung
auf dem Plan, mit der man über einen Klick die aktuelle
Tastenbelegung aus der Referenz erzeugen kann. Zuvor sollte ein
vernünftiges Dateiformat für die Referenz gefunden werden, dann kann
mit der Erstellung des Konverters begonnen werden.

Last, but not least gehört für die vielen Konfigurationsoptionen ein
entsprechender Dialog her. Der Kapselung wegen könnten die einzelnen
Module hier separate Dialogboxen oder Tabs erhalten.

Übrigens stellt neo-vars seine Informationen (z.B. über die
Aktivierung des Mod4-Lock) über Tray-Tips dar, die mitunter im
Explorer oder über die Registry aktiviert werden müssen. Diese
Einstellung zu ändern, wäre auch ein heißer Kandidat für die
Config-Dialoge.

Nur ein kleiner Teil des Codes wurde vom alten Neo-AHK übernommen,
darunter die kaum benutzten Keyboard-LEDs und die stark angepassten
Unicode-Zeichenausgaben und Ebenenfunktionen. Mittlerweile werden
sogar die Modifier über die normalen Keyboard-Hooks geleitet,
wodurch man im Prinzip auch diese Zeichen generisch umlegen kann.
Einen Strich durch die Rechnung macht uns AHK mit einer recht
unflexiblen Handhabung der Alt-Taste, die zwar ge-hookt aber nicht
so einfach gesendet werden kann (AHK sendet bona fide automatisch
Key-release-Events und simuliert Strg-Tastendrücke). Strg, Win und
Konsorten wären hingegen kein Problem.

Wir hatten recht lang ein generelles Performance-Problem, das zur
Folge hatte, dass hie und da ein Zeichen nicht vom AHK-Skript
verarbeitet wurde und stattdessen direkt zur Applikation weiter
gereicht wurde. Dieses Problem ist offenbar auf AHK und dessen
Funktion SendInput in seiner derzeitigen Version zurückzuführen. Mit
SendEvent (bzw. »SendMode Event« am Beginn des Skripts) haben wir
aber keine Probleme mehr, weshalb neo-vars nun auch die offizielle
AHK-Version ist.

