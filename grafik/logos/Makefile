LAYOUTS=neo neoqwertz bone
ICOFILES=$(addsuffix .ico, ${LAYOUTS})
ICNSFILES = $(addsuffix .icns, ${LAYOUTS})
ICONSIZES=16 32 48 128 256
SMALLICONPNGS=$(foreach layout, ${LAYOUTS}, $(foreach size, ${ICONSIZES}, ${layout}-smallicon-${size}.png))

EXTRACLEAN = ${ICOFILES} ${ICNSFILES} ${SMALLICONPNGS}

all: default ico icns
ico: ${ICOFILES}
icns: ${ICNSFILES}

define GENERATE_RULES
${1}-smallicon-%.png: ${1}-icon.svg
	inkscape --export-filename=$$@ --export-height=$$* $$<

${1}.ico: $(foreach size, ${ICONSIZES}, ${1}-smallicon-${size}.png)
	convert $$^ $$@

${1}.icns: $(foreach size, ${ICONSIZES}, ${1}-smallicon-${size}.png)
	png2icns $$@ $$^
endef

$(foreach layout, ${LAYOUTS}, $(eval $(call GENERATE_RULES, ${layout})))

include ../common.mk
