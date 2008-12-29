SVGFILES=${wildcard *.svg} ${wildcard */*.svg} ${wildcard */*/*.svg} $(foreach i, 1 2 3 4 5 6, tastatur3d/tastatur_neo_Ebene${i}.svg)

PDFFILES=${addsuffix .pdf,${basename ${SVGFILES}}}
PNGFILES=${addsuffix .png,${basename ${SVGFILES}}}

pdf: ${PDFFILES}
png: ${PNGFILES}

clean: cleanpng cleanpdf

cleanpng:
	rm -rf ${PNGFILES}

cleanpdf:
	rm -rf ${PDFFILES}

tastatur3d/tastatur_neo_Ebene%.svg: tastatur3d/tastatur_neo_alle_Ebenen.svg
	/bin/echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

%.pdf: %.svg
	inkscape --without-gui --export-pdf=$@ $<

%.png: %.svg
	inkscape --without-gui --export-png=$@ -w1000 $<

.PHONY: clean cleanpng cleanpdf pdf png
