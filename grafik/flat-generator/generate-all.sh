#!/bin/sh

rm -r osterblau-with{,out}-numpad
mkdir osterblau-with{,out}-numpad

for layout in neo neo_qwertz bone adnw koy; do
    ./generate-graphics.py "de $layout" base.svg.template;
done;
./generate-graphics.py "de vou" vou-base.svg.template;
mv *.svg osterblau-without-numpad

for layout in neo neo_qwertz bone adnw koy; do
    ./generate-graphics.py "de $layout" numpad.svg.template;
done;
./generate-graphics.py "de vou" vou-numpad.svg.template;
mv *.svg osterblau-with-numpad

inkscape -T --export-plain-svg osterblau-*-numpad/*.svg
