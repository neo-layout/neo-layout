LAYOUTS = neo neoqwertz bone
ICOFILES = $(addsuffix -icon.ico, ${LAYOUTS})
ICNSFILES = $(addsuffix -icon.ico, ${LAYOUTS})

EXTRACLEAN = ${ICOFILES} ${ICNSFILES}

all: default ico

ico: ${ICOFILES}

ico: ${ICNSFILES}

%.ico: %.png
	convert $< -define icon:auto-resize=16,32,48,128,256 $@

# TODO: find a way to generate icns icons a normal loonix machine

include ../common.mk
