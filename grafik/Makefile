EBENENSVG=$(foreach i, 1 2 3 4 5 6, tastatur_neo_Ebene${i}.svg)
SVGFILES=$(filter-out ./tastatur3d/tastatur_neo_alle_Ebenen.svg, $(shell find -name "*.svg")) $(foreach file, ${EBENENSVG}, tastatur3d/${file})

PDFFILES=$(addsuffix .pdf,$(basename ${SVGFILES}))
PNGFILES=$(addsuffix .png,$(basename ${SVGFILES}))

default: pdf png www
pdf: ${PDFFILES}
png: ${PNGFILES}

clean: cleanpng cleanpdf cleanwww

cleanpng:
	rm -f ${PNGFILES}

cleanpdf:
	rm -f ${PDFFILES}

tastatur3d/tastatur_neo_Ebene%.svg: tastatur3d/tastatur_neo_alle_Ebenen.svg
	/bin/echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

WWWPIC=$(addsuffix .png, $(basename $(foreach file, ${EBENENSVG}, ../www/${file})))
www: ${WWWPIC}
../www/%.png: tastatur3d/%.svg
	inkscape --without-gui --export-area=0:0:1360,747:457,673 --export-png=$@ -w650 $<

cleanwww:
	rm -f ${WWWPIC}

%.pdf: %.svg
	inkscape --without-gui --export-pdf=$@ $<

%.png: %.svg
	inkscape --without-gui --export-png=$@ -w1000 $<

.PHONY: clean cleanpng cleanpdf default pdf png
