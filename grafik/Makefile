EBENEN=$(foreach i, 1 1Caps 2 2Caps 3 4 5 6, tastatur_neo_Ebene${i}.svg)
EBENENSVG=$(foreach file, ${EBENEN}, tastatur3d/${file})
HAUPT=$(foreach file, ${EBENEN}, tastatur3d/hauptfeld/${file})
ZIFFERN=$(foreach file, ${EBENEN}, tastatur3d/ziffernfeld/${file})
HAUPTZIFFERN=$(foreach file, ${EBENEN}, tastatur3d/haupt_ziffern_feld/${file})
EBENENPDF=$(addsuffix .pdf,$(basename ${EBENENSVG}))
EBENENPNG=$(addsuffix .png,$(basename ${EBENENSVG} ${HAUPT} ${ZIFFERN} ${HAUPTZIFFERN}))

SVGFILES=$(filter-out ./tastatur3d/tastatur_neo_%.svg, $(shell find -name "*.svg")) 
PDFFILES=$(filter-out ./promotion-material/Flyer-fs/neo_logo.pdf, $(addsuffix .pdf,$(basename ${SVGFILES})))
PNGFILES=$(addsuffix .png,$(basename ${SVGFILES})) 

default: pdf png 
pdf: ${PDFFILES} ${EBENENPDF}
png: ${PNGFILES} ${EBENENPNG} www
www: $(addsuffix .png,$(basename $(shell find ../www -name "*.svg")))

clean: cleanpng cleanpdf

cleanebenen:
	rm -f ${EBENENSVG} ${EBENENPNG} ${EBENENPDF}
	$(foreach dir, hauptfeld ziffernfeld haupt_ziffern_feld, if [ -d tastatur3d/${dir} ];then rmdir tastatur3d/${dir}; fi;)

cleanpng: cleanebenen
	rm -f ${PNGFILES}

cleanpdf:
	rm -f ${PDFFILES}

.SECONDARY:

tastatur3d/tastatur_neo_Ebene%.svg: tastatur3d/tastatur_neo_alle_Ebenen.svg
	/bin/echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

tastatur3d/hauptfeld/%.png: tastatur3d/%.svg
	mkdir -p  tastatur3d/hauptfeld
	inkscape --without-gui --export-id="Haupttastaturfeld" --export-png=$@ -h200 tastatur3d/$*.svg
	mogrify -colors 256 -type Palette +dither -alpha off -alpha on $@
	mogrify -depth 8 $@
	optipng $@

tastatur3d/ziffernfeld/%.png: tastatur3d/%.svg
	mkdir -p tastatur3d/ziffernfeld
	inkscape --without-gui --export-id="Ziffernblock" --export-png=$@ -h200 tastatur3d/$*.svg
	mogrify -colors 256 -type Palette +dither -alpha off -alpha on $@
	mogrify -depth 8 $@
	optipng $@

tastatur3d/haupt_ziffern_feld/%.png: tastatur3d/hauptfeld/%.png tastatur3d/ziffernfeld/%.png
	mkdir -p tastatur3d/haupt_ziffern_feld
	convert -splice 20x0 -background transparent -colors 256 -type Palette +dither -alpha off -alpha on tastatur3d/ziffernfeld/$*.png /tmp/$*_tmp.png
	convert +append tastatur3d/hauptfeld/$*.png /tmp/$*_tmp.png $@
	rm /tmp/$*_tmp.png
	mogrify -colors 256 -type Palette +dither -alpha off -alpha on $@
	mogrify -depth 8 $@
	optipng $@

%.pdf: %.svg
	inkscape --without-gui --export-pdf=$@ $<

../www/%.png: ../www/%.svg
	inkscape --without-gui --export-png=$@ $<
	mogrify -colors 256 -type Palette +dither -alpha off -alpha on $@
	mogrify -depth 8 $@
	optipng $@

%.png: %.svg
	inkscape --without-gui --export-png=$@ -w1000 $<
	mogrify -colors 256 -type Palette +dither -alpha off -alpha on $@
	mogrify -depth 8 $@
	optipng $@

.PHONY: default clean pdf cleanpdf png cleanpng ebenen cleanebenen
