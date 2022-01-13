
VARIANTS := neo bone neo_qwertz neo_qwerty koy adnw

# You can use this line if you have vou and mine installed (not
# included with xkeyboard-config)
#VARIANTS += vou mine

LAYERS = 1 2 3 4 5 6 Pseudoebene
VERSIONS = numpad tkl

BASENAMES ::= $(foreach variant, ${VARIANTS}, \
		$(foreach layer, ${LAYERS}, \
		  $(foreach version, ${VERSIONS}, \
		    ${variant}${suffix}-${layer}-${version})))
BASENAMES += $(foreach variant, ${VARIANTS}, \
		  $(foreach version, ${VERSIONS}, \
		    ${variant}${suffix}-leer-${version}))

SVG_TARGETS=$(addsuffix .svg, ${BASENAMES})
SVG_PATH_TARGETS=$(addsuffix .path.svg, ${BASENAMES})
PDF_TARGETS=$(addsuffix .pdf, ${BASENAMES})
PNG_TARGETS=$(addsuffix .png, ${BASENAMES})

SOURCES = generate-graphics.py replacements.py base.svg.template

default: all cleansvg cleanpycache

svg-path: ${SVG_PATH_TARGETS}
svg: ${SVG_TARGETS}
pdf: ${PDF_TARGETS}
png: ${PNG_TARGETS}

%-tkl.svg: variant=$(shell echo $@ | cut -d - -f 1)
%-tkl.svg: ${SOURCES}
	@echo "Erzeuge $(variant) Hauptfeld."
	./generate-graphics.py $(variant)

%-numpad.svg: variant=$(shell echo $@ | cut -d - -f 1)
%-numpad.svg: ${SOURCES}
	@echo "Erzeuge $(variant) Numpad."
	./generate-graphics.py $(variant) numpad

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
