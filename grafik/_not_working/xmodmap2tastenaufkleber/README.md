# xmodmap2tastenaufkleber.sh 

Autor: Martin Engel  
__Die Benutzung erfolgt auf eigene Gefahr!__


Dieses Skript generiert aus einer xmodmap-Datei eine SVG-Datei, die Tastenaufkleber für die Tastaturbelegung Neo[^1] erzeugt.
Alternativ gibt es für Neo auch einen Aufsteller, der die Tasten darstellt, und eine Einführung, die die ersten Ebenen über Eselsbrücken einprägt. Beides ist auf der Neo-Seite zu finden.


## Abhängigkeiten

- awk
- sed
- bash


## Anwendung


Man entpacke das Archiv in ein Verzeichnis und wechsele in das Verzeichnis mit der xmodmap2tastenaufkleber.sh-Datei. Zum Erzeugen der SVG-Datei benutze man das folgende Kommando, falls die xmodmap-Datei »neo_de.xmodmap« heißt:

```
bash ./xmodmap2tastenaufkleber.sh neo_de.xmodmap
```

Bei erfolgreicher Beendigung des Programmes befindet sich danach eine SVG-Datei mit dem Namen der xmodmap-Datei und angehängtem Suffix ».svg«, in unserem Beispiel also »neo_de.xmodmap.svg«, im selbigen Verzeihnis.
Ein Programm, das mit SVG-Dateien umgehen kann ist Inkscape[^2]. Mit diesem kann auch in eine PDF-Datei exportiert werden. 

Der Druck erfolgt am besten mit einem Laserdrucker, da dann scharfe Ausdrucke entstehen. Es gibt Papier zu erwerben, das auf der Unterseite schon eine Klebefläche aufweist. Es bietet sich an, darauf eine Lage durchsichtige Klebefolie anzubringen, um Abnutzungserscheinungen zu unterdrücken.
Eine billigere Möglichkeit ist das Ausdrucken auf Normalpapier und Fixierung auf der Taste durch Klebestreifen. Man sollte sich davor vergewissern, wie breit der Kleberstreifen sein muss, damit nacher nichts übersteht. Weil die Tasten meistens eine nach innen weisende Form in waagerechter Richtung aufweisen, bietet es sich an, die Klebestreifen senkrecht anzubringen. Bei normalen Tastaturen sollte man die einzelnen Tasten heraushebeln können, ohne sie zu beschädigen. Das erleichtert die Arbeit (Manchmal unterscheiden sich die Tasten minimal in ihrer Form. So ist darauf zu achten, wo welche Taste genau war).

Viel Spaß mit Neo!


[^1]: http://www.neo-layout.org
[^2]: http://www.inkscape.org


## Rechtliches

### Für keysymdef.h

Copyright 1987, 1994, 1998  The Open Group

Permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of The Open Group shall
not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization
from The Open Group.


Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts

All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Digital not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.
