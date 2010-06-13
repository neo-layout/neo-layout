
default: compile

# Downloading graphics:
fetch:
	curl -O http://neo-layout.org/svn/grafik/logos/Neo-Icon-Schriftzug.pdf
	curl -O http://neo-layout.org/svn/grafik/tastatur3d/tastatur_neo_Ebene1.pdf
	curl -O http://neo-layout.org/svn/grafik/druckvorlage/neo-druckvorlage.pdf

# Generation using pdfLaTeX
compile: fetch
	pdflatex Flyer.tex
	pdflatex Flyer.tex
