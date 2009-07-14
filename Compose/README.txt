= Informationen über Compose =
Für die Installation und den Gebrauch der Compose-Funktion siehe
https://wiki.neo-layout.org/wiki/Tote%20Tasten%20und%20Compose

Für technische Informationen zur Bearbeitung der Compose-Kombinationen siehe
https://wiki.neo-layout.org/wiki/Treiber-Know-How#Compose

= Dateien in diesem Directory =

src/*.module
  Enthält die Quelldateien für verschiedene Module der Compose-Datei.
  Die Gliederung ist thematisch.

Makefile
  Erstellt aus den Modulen eine oder mehrere lauffähige
  XCompose-Dateien.  Details mit `make help'

XCompose* 
  Lauffähige Compose-Datei (werden mittels Makefile erzeugt).  Sie ist
  unter Linux unter dem Namen ${HOME}/.XCompose zu speichern.

contrib/*
  enthält Informationen, die veraltet sind, nicht mehr gepflegt
  werden, oder aus einem anderen Grund nicht Teil der offiziellen
  Release zu sein brauchen.

