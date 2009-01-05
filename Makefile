all: 
	make -C portable deploy
	make -C grafik 
	make -C linux/bin/installiere_neo

svnclean:
	make -C portable clean
	make -C linux/bin/installiere_neo clean

clean: svnclean 
	make -C grafik clean

svnupdate: 
	make svnclean
	svn up
	make 

.PHONY: all clean svnupdate svnclean
