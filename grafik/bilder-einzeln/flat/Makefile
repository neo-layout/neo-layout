VARIANTS=neo bone neo_qwertz neo_qwerty koy adnw
LAYERS=1 2 3 4 5 6 Pseudoebene
VERSIONS=numpad tkl
SUFFIXES=$(foreach version, ${VERSIONS}, $(foreach layer, ${LAYERS}, -${layer}-${version}.svg))
SVG_TARGETS=$(foreach suffix, ${SUFFIXES}, $(foreach variant, ${VARIANTS}, ${variant}${suffix}))
SVG_PATH_TARGETS=$(addsuffix .path.svg,$(basename ${SVG_TARGETS}))
PDF_TARGETS=$(addsuffix .pdf,$(basename ${SVG_TARGETS}))
PNG_TARGETS=$(addsuffix .png,$(basename ${SVG_TARGETS}))
SOURCES=generate-graphics.py replacements.py base.svg.template

default: all cleansvg cleanpycache

svg-path: ${SVG_PATH_TARGETS}
svg: ${SVG_TARGETS}
pdf: ${PDF_TARGETS}
png: ${PNG_TARGETS}

$(foreach suffix, ${SUFFIXES}, %${suffix}) &: ${SOURCES}
	@echo "Erzeuge $@."
	./generate-graphics.py `echo $@ | cut -d - -f 1` numpad
	./generate-graphics.py `echo $@ | cut -d - -f 1`

%.path.svg: %.svg
	inkscape --export-filename=$@ -T $<

%.pdf: %.svg
	inkscape --export-filename=$@ $<

%.png: %.svg
	inkscape --export-filename=$@ --export-height=183 $<
	optipng $@

all: svg-path svg pdf png

cleansvgpath:
	rm -f ${SVG_PATH_TARGETS}

cleansvg:
	rm -f ${SVG_TARGETS}

cleanpng: 
	rm -f ${PNG_TARGETS}

cleanpdf:
	rm -f ${PDF_TARGETS}
cleanpycache:
	rm -rf __pycache__

clean: cleansvgpath cleansvg cleanpng cleanpdf cleanpycache
