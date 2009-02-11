all: portable grafik linux/bin/installiere_neo windows/kbdneo2/Treiber

# wo befinden sich die zu bearbeitenden Dateien (bzw. eigentlich nur Name
# des Parameters)
windows/kbdneo2/Treiber:
	# wo befindet sich das Makefile
	make -kC windows/kbdneo2/Treiber 

portable:
	make -kC portable deploy

grafik:
	make -kC grafik 

linux/bin/installiere_neo:
	make -kC linux

svnclean:
	make -C portable clean
	make -C linux clean
	make -C windows/kbdneo2/Treiber clean

clean: svnclean 
	make -kC grafik clean

svnupdate: 
	make svnclean
	svn up
	make -k

.PHONY: all clean svnupdate svnclean portable grafik linux/bin/installiere_neo windows/kbdneo2/Treiber
