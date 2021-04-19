all: default neo-bunt-123456.pdf neo-bunt-123456.png

neo-bunt-123456.pdf: neo-bunt-123456.ods
	 libreoffice --convert-to pdf $<

neo-bunt-123456.png: neo-bunt-123456.ods
	 libreoffice --convert-to png $<

neo20-grau-123456.svg: 
	 ./all-grau-123456.php neo20

bone-grau-123456.svg: 
	 ./all-grau-123456.php bone

neoqwertz-grau-123456.svg: 
	 ./all-grau-123456.php neoqwertz

EXTRASVG=\
	neo20-grau-123456.svg \
	bone-grau-123456.svg \
	neoqwertz-grau-123456.svg

EXTRAPDF=neo-bunt-123456.pdf

EXTRAPNG=neo-bunt-123456.png

include ../common.mk
