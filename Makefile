all: 	portable \
	grafik \
	linux/bin/installiere_neo \
	windows/kbdneo2/Treiber \
	Compose

# wo befinden sich die zu bearbeitenden Dateien (bzw. eigentlich nur Name
# des Parameters)
windows/kbdneo2/Treiber:
	-make -kC windows/kbdneo2/Treiber 

portable:
	-make -kC portable deploy

grafik:
	-make -kC grafik 

linux/bin/installiere_neo:
	-make -kC linux

Compose:
	-make -C Compose XCompose

svnclean:
	-make -C portable clean
	-make -C linux clean
	-make -C windows/kbdneo2/Treiber clean
	-make -C Compose clean

clean: svnclean 
	-make -kC grafik clean

svnupdate: 
	make svnclean
	svn up
	make -k

.PHONY: all clean svnupdate svnclean portable grafik linux/bin/installiere_neo windows/kbdneo2/Treiber Compose
