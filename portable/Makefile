neo_portable: autorun.inf autorun.sh ../grafik/logos/neo.ico ../windows/autohotkey/neo20.exe ../linux/xmodmap/neo_de.xmodmap ../mac_osx/neo.keylayout ../freebsd/neo.kbd
	mkdir -p neo_portable/neo
	cp autorun.* neo_portable
	cp ../grafik/logos/neo.ico ../windows/autohotkey/neo20.exe ../linux/xmodmap/neo_de.xmodmap ../mac_osx/neo.keylayout ../freebsd/neo.kbd neo_portable/neo

neo_portable.zip: neo_portable
	cd neo_portable; zip -r neo_portable *
	mv neo_portable/neo_portable.zip .

neo_portable.tar.gz: neo_portable
	tar -czf neo_portable.tar.gz neo_portable

deploy: neo_portable.tar.gz neo_portable.zip

clean: 
	rm -rf neo_portable
	rm -f neo_portable.tar.gz neo_portable.zip

.PHONY: deploy clean
