## Dateien

| Datei | Beschreibung |
| --- | --- |
|neo_de.xmodmap          | Normale Version für die meisten Benutzer (für eine normale deutsche
|bone_de.xmodmap         | ISO PC-Tastatur entworfen, aber auch mit Variationen verwendbar)
|neoqwertz_de.modmap     | 
|neo_mac.xmodmap         | Version für ältere Apple-Tastaturen mit Nichtstandard-Keycodes.
|bone_mac.xmodmmap       |
|neoqwertz_mac.modmap    |

### Hinweis

Heutzutage ist es aus einer Vielzahl von Gründen (bessere
Softwareunterstützung, Hotplugging von Tastaturen, nicht Xorg-spezifisch (quasi
alle Wayland-Compositors nutzen xkbmaps) weniger Installatinosaufwand für den
Benutzer) besser, die xkbmaps zu nutzen, die bei den Distributionen bereits
mitgeliefert werden.

Diese xmodmaps sind primär aus historischen Gründen und ihrer Verwendbarkeit in
Scripten noch verfügbar.

### Aktivieren
Zu aktivieren mit dem Kommando (im Verzeichnis, in dem sich die Datei befindet): `xmodmap <dateiname>`

Besser ist jedoch die Verwendung des Skripts ›asdf‹, da so (mögliche) Probleme
vermieden werden.  Siehe dazu auch die README im Ordner /linux/bin.

#### Automatisch aktivieren
Um die NEO-Tastaturbelegung automatisch zu aktivieren, gibt es mehrere
(alternative) Wege:
- die Xmodmap nach ~/.Xmodmap kopieren, wo sie automatisch geladen wird
- die Befehlszeile in ein  Datei eingeben, die automatisch ausgeführt wird,
  z.B.:
    - gnome-session-properties
    - ~/GNUstep/Library/WindowMaker/autostart
    - ~/.Xsession

Der bessere Weg ist jedoch das Skript ›asdf‹ in der Datei ›~/.profile‹
einzutragen.  Siehe dazu auch die README im Ordner /linux/bin.

#### Automatischen Linux-NEO-USB-Stick erstellen
Diese Datei auf einen USB-Stick kopieren
```
cp neo.xmodmap /media/<USBSTICK>
```

Auf dem USB-Stick eine ausführbare Datei mit dem Namen .autorun, autorun oder 
autorun.sh anlegen, die die Datei automatisch lädt. Dazu zum Beispiel den
folgenden zweizeiligen Befehl eingeben (erstellt automatisch die ausführbare
Datei auf dem USB-Stick – wobei /media/<USBSTICK> durch den echten Pfad des
USB-Sticks ersetzt werden muss):
```
echo -e "#!/bin/sh\nsetxkbmap lv && xmodmap neo_de.xmodmap" > \
    /media/<USBSTICK>/autorun
```

### Deaktivieren
Zurück zu qwertz geht es mit: `setxkbmap de`

Besser ist auch hier die Verwendung des Skripts ›uiae‹.

## FAQ
Bei Problemen erst mal in die FAQ schauen, das meiste ist bekannt.

### Wo ist die neo_de_evdev.xmodmap hin verschwunden?

Für evdev wird keine eigene xmodmap mehr benötigt.
Es kann die normale neo_de.xmodmap verwendet werden.
