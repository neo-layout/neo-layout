ALL=$(filter-out ./tastatur3d/tastatur_neo_alle_Ebenen.svg, $(shell find -name "*.svg")) 
EBENENSVG=$(foreach i, 1 2 3 4 5 6, tastatur_neo_Ebene${i}.svg)
EBENEN=$(foreach file, ${EBENENSVG}, tastatur3d/${file})
SVGFILES=${ALL} ${EBENEN}

PDFFILES=$(addsuffix .pdf,$(basename ${SVGFILES}))

HAUPT=$(foreach file, ${EBENENSVG}, tastatur3d/hauptfeld/${file})
ZIFFERN=$(foreach file, ${EBENENSVG}, tastatur3d/ziffernfeld/${file})
HAUPTZIFFERN=$(foreach file, ${EBENENSVG}, tastatur3d/haupt_ziffern_feld/${file})
PNGFILES=$(addsuffix .png,$(basename ${SVGFILES} ${HAUPT} ${ZIFFERN} ${HAUPTZIFFERN})) 

default: pdf png 
pdf: ${PDFFILES}
png: ${PNGFILES}

clean: cleanpng cleanpdf
	rm -f $(EBENEN)

cleanpng:
	rm -f ${PNGFILES}
	$(foreach dir, hauptfeld ziffernfeld haupt_ziffern_feld, if [ -d tastatur3d/${dir} ];then rmdir tastatur3d/${dir}; fi;)

cleanpdf:
	rm -f ${PDFFILES}

.SECONDARY:

tastatur3d/tastatur_neo_Ebene%.svg: tastatur3d/tastatur_neo_alle_Ebenen.svg
	/bin/echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

tastatur3d/hauptfeld/%.png: tastatur3d/%.svg
	mkdir -p  tastatur3d/hauptfeld
	inkscape --without-gui --export-id="Haupttastaturfeld" --export-png=$@ -h200 tastatur3d/$*.svg
	mogrify -colors 256 -depth 8 -quality 100 +dither $@

tastatur3d/ziffernfeld/%.png: tastatur3d/%.svg
	mkdir -p tastatur3d/ziffernfeld
	inkscape --without-gui --export-id="Ziffernblock" --export-png=$@ -h200 tastatur3d/$*.svg
	mogrify -colors 256 -depth 8 -quality 100 +dither $@

tastatur3d/haupt_ziffern_feld/%.png: tastatur3d/%.svg tastatur3d/hauptfeld/%.png tastatur3d/ziffernfeld/%.png
	mkdir -p tastatur3d/haupt_ziffern_feld
	convert -splice 20x0 -background transparent tastatur3d/ziffernfeld/$*.png /tmp/$*_tmp.png
	convert +append tastatur3d/hauptfeld/$*.png /tmp/$*_tmp.png $@
	rm /tmp/$*_tmp.png
	mogrify -colors 256 -depth 8 -quality 100 +dither $@

%.pdf: %.svg
	inkscape --without-gui --export-pdf=$@ $<

%.png: %.svg
	inkscape --without-gui --export-png=$@ -w1000 $<
	mogrify -colors 256 -depth 8 -quality 100 +dither $@

.PHONY: clean cleanpng cleanpdf default pdf png
