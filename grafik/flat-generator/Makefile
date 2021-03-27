VARIANTS=neo bone neo_qwertz neo_qwerty koy adnw
LAYERS=1 2 3 4 5 6 Pseudoebene
VERSIONS=numpad tkl
SUFFIXES=$(foreach version, ${VERSIONS}, $(foreach layer, ${LAYERS}, -Ebene-${layer}-${version}.svg))
SVG_TARGETS=$(foreach suffix, ${SUFFIXES}, $(foreach variant, ${VARIANTS}, ${variant}${suffix}))
PDF_TARGETS=$(addsuffix .pdf,$(basename ${SVG_TARGETS}))
PNG_TARGETS=$(addsuffix .png,$(basename ${SVG_TARGETS}))
SOURCES=generate-graphics.py replacements.py base.svg.template

svg: ${SVG_TARGETS}
pdf: ${PDF_TARGETS}
png: ${PNG_TARGETS}

$(foreach suffix, ${SUFFIXES}, %${suffix}) &: ${SOURCES}
	@echo "Erzeuge $@."
	./generate-graphics.py `echo $@ | cut -d - -f 1` numpad
	./generate-graphics.py `echo $@ | cut -d - -f 1`
	inkscape --export-filename=$@ -T $@

%.pdf: %.svg
	inkscape --export-filename=$@ $<

%.png: %.svg
	inkscape --export-filename=$@ --export-height=183 $<
	optipng $@

all: svg pdf png

cleansvg:
	rm -f ${SVG_TARGETS}

cleanpng: 
	rm -f ${PNG_TARGETS}

cleanpdf:
	rm -f ${PDF_TARGETS}

clean: cleansvg cleanpng cleanpdf
