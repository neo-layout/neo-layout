all: heatmap.png

neo.png:
	$(MAKE) -C "../bilder-einzeln/flat/" neo-1-tkl.png
	cp ../bilder-einzeln/flat/neo-1-tkl.png neo.png

heatmap.png: heatmap.py faust.txt neo.png
	./heatmap.py

EXTRAPNG=heatmap.png neo.png

include ../common.mk
