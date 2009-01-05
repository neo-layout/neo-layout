all: 
	make -C portable deploy
	make -C grafik 

clean: 
	make -C portable clean
	make -C grafik clean

svnupdate:
	make -C portable clean
	svn up
	make 

.PHONY: all clean svnupdate
