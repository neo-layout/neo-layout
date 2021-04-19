EBENENNAMEN=1 1Caps 2 2Caps 3 4 5 6
BONE=$(foreach i, ${EBENENNAMEN}, bone-ebene${i}.svg)
NEO=$(foreach i, ${EBENENNAMEN}, neo-ebene${i}.svg)
KYRILLISCH=$(foreach i, ${EBENENNAMEN}, kyrillisch-ebene${i}.svg)

EBENENSVG=${BONE} ${NEO} ${KYRILLISCH}
HAUPT=$(foreach file, ${EBENENSVG}, hauptfeld/${file})
ZIFFERN=$(foreach file, ${EBENENSVG}, ziffernfeld/${file})
HAUPTZIFFERN=$(foreach file, ${EBENENSVG}, haupt_ziffern_feld/${file})
EBENENPDF=$(addsuffix .pdf,$(basename ${EBENENSVG}))
EBENENPNG=$(addsuffix .png,$(basename ${EBENENSVG} ${HAUPT} ${ZIFFERN} ${HAUPTZIFFERN}))
EBENENSVGPATH=$(addsuffix .path.svg,$(basename ${EBENENSVG}))

all: svg pdf png svg-path
svg: ${EBENENSVG}
svg-path: ${EBENENSVGPATH}
pdf: ${EBENENPDF}
png: ${EBENENPNG}

clean:
	rm -f ${EBENENSVG} ${EBENENPNG} ${EBENENPDF} ${EBENENSVGPATH}
	$(foreach dir, hauptfeld ziffernfeld haupt_ziffern_feld, if [ -d ${dir} ];then rmdir ${dir}; fi;)

$(BONE): bone-ebene%.svg: bone.svg.template
	echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

$(NEO): neo-ebene%.svg: neo.svg.template
	echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

$(KYRILLISCH): kyrillisch-ebene%.svg: kyrillisch.svg.template
	echo -e '/inkscape:label="Ebene $*"\n.+1\ns/none/inline/g\nw $@'|ed $<

hauptfeld/%.png: %.svg
	mkdir -p  hauptfeld
	inkscape --export-id="Haupttastaturfeld" --export-filename=$@ --export-height=200 $<
	optipng $@

ziffernfeld/%.png: %.svg
	mkdir -p ziffernfeld
	inkscape --export-id="Ziffernblock" --export-filename=$@ --export-height=200 $<
	optipng $@

haupt_ziffern_feld/%.png: hauptfeld/%.png ziffernfeld/%.png
	mkdir -p haupt_ziffern_feld
	convert -splice 20x0 -background transparent -colors 256 -type Palette +dither -alpha off -alpha on ziffernfeld/$*.png /tmp/$*_tmp.png
	convert +append hauptfeld/$*.png /tmp/$*_tmp.png $@
	rm /tmp/$*_tmp.png
	optipng $@

%.pdf: %.svg
	inkscape --export-filename=$@ $<

%.png: %.svg
	inkscape --export-filename=$@ --export-width=1000 $<
	optipng $@

%.path.svg: %.svg
	inkscape --export-filename=$@ -T $<
