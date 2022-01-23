# Readme

Die meisten der Neo-Grafiken gibt es in vier Formaten:
 - svg
 - svg mit Text in Pfade umgewandelt
 - png
 - pdf

In diesem Reposity befinden sich aber nur svgs und Skripte, mit denen man noch
mehr svgs (aus Treibern oder Referenzen) und daraus dann die anderen Formate
erstellt. Die fertigen Grafiken befinden sich aber auf
    https://dl.neo-layout.org/grafik .
    
Um alle Bilder erzeugen können, benötigt man eine Vielzahl an Abhängigkeiten:
 - make
 - inkscape
 - optipng
 - imagemagick
 - libicns
 - libreoffice
 - sed
 - ed
 - libxkbcommon (xkbcli)
 - python mit jinja2, numpy, pandas, matplotlib, seaborn und lxml
 - php
 - Linux Libertine
 - Gentium Plus Compact
 - DejaVu Sans Mono
 - vermutlich noch weitere Schriften
 
Sind alle Abhängigkeiten erfüllt, sollte man alle Bilder mit `make` erstellen
können.  Man kann `make` auch in jedem Unterverzeichnis ausführen, um jeweils
weniger Bilder zu generieren.  Außerdem können gewünschte Formate oder gar
Dateinamen direkt als Target übergeben werden•
`
