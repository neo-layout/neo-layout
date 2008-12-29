SVGFILES=${wildcard *.svg} ${wildcard */*.svg} ${wildcard */*/*.svg}

PDFFILES=${addsuffix .pdf,${basename ${SVGFILES}}}
PNGFILES=${addsuffix .png,${basename ${SVGFILES}}}

pdf: ${PDFFILES}
png: ${PNGFILES}

clean: cleanpng cleanpdf

cleanpng:
	rm -rf ${PNGFILES}

cleanpdf:
	rm -rf ${PDFFILES}

%.pdf: %.svg
	inkscape --without-gui --export-pdf=$@ $<

%.png: %.svg
	inkscape --without-gui --export-png=$@ -w1000 $<

.PHONY: clean cleanpng cleanpdf pdf png
