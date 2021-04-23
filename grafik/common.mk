SVGFILES=$(filter-out $(wildcard *.path.svg */*.path.svg), $(wildcard *.svg */*.svg)) ${EXTRASVG}
SVGPATHFILES=$(addsuffix .path.svg,$(basename ${SVGFILES}))
PDFFILES=$(addsuffix .pdf,$(basename ${SVGFILES})) ${EXTRAPDF}
PNGFILES=$(addsuffix .png,$(basename ${SVGFILES})) ${EXTRAPNG}

default: svg-path svg pdf png

svg: ${EXTRASVG}

svg-path: ${SVGPATHFILES}

pdf: ${PDFFILES}

png: ${PNGFILES}

clean: 
	rm -f ${EXTRASVG} ${SVGPATHFILES} ${PDFFILES} ${PNGFILES} ${EXTRAPDF} ${EXTRAPNG} ${EXTRACLEAN}

%.path.svg: %.svg
	inkscape --export-filename=$@ -T $<

%.pdf: %.svg
	inkscape --export-filename=$@ $<

%.png: %.svg
	inkscape --export-filename=$@ --export-width=2000 $<
	optipng $@
