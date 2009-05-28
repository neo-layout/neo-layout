FILES=bin/installiere_neo/installiere_neo xmodmap/neo_de_x-prog.xmodmap \
xmodmap/neo_de_alternative.xmodmap xmodmap/neo_de.xmodmap.referenz X/xkb.tgz

all:${FILES}

bin/installiere_neo/installiere_neo: xmodmap/neo_de.xmodmap xmodmap/neo_de_alternative.xmodmap xmodmap/neo_de_x-prog.xmodmap console/neo.map bin/asdf bin/uiae ../A-REFERENZ-A/neo20.txt bin/neo bin/num bin/wiemitneo bin/beschreibe ../Compose/Compose.neo etc/neo.conf bin/installiere_neo/erzeuge.installiere_neo bin/installiere_neo/installiere_neo.1 bin/installiere_neo/installiere_neo.2 
	cd bin/installiere_neo; ./erzeuge.installiere_neo > installiere_neo
	chmod a+x $@

xmodmap/neo_de_x-prog.xmodmap:xmodmap/neo_de.xmodmap
	sed -e 's/\x09Up/\x9KP_Up/g' \
	-e 's/BackSpace/NoSymbol/g' \
	-e 's/\x09Delete/\x09KP_Delete/g' \
	-e 's/\x09Insert/\x09KP_Insert/g' \
	-e 's/\x09Home/\x09KP_Home/g' \
	-e 's/\x09Left/\x09KP_Left/g' \
	-e 's/\x09Down/\x09KP_Down/g' \
	-e 's/\x09Right/\x09KP_Right/g' \
	-e 's/\x09End/\x09KP_End/g' \
	-e 's/\x09Next/\x09KP_Next/g' \
	-e 's/\x09KP_Add/\x09plus/g' \
	-e 's/\x09KP_Substract/\x09minus/g' \
	-e 's/\x09Return/\x09KP_Enter/g' $< > $@


xmodmap/neo_de_alternative.xmodmap:xmodmap/neo_de.xmodmap
	sed -e 's/U202F/NoSymbol/g' \
	-e 's/dead_stroke/NoSymbol/g' \
	-e 's/dead_doublegrave/U02F5/g' \
	-e 's/dead_dasia/U1FFE/g' $< > $@

xmodmap/neo_de.xmodmap.referenz:xmodmap/neo_de.xmodmap
	cd xmodmap; ./erzeuge_neo_de_referenz > neo_de.xmodmap.referenz

X/xkb.tgz:X/compat/* X/rules/* X/symbols/* X/types/*
	cd X; \
	chmod u=rw,g=r,o=r compat/* rules/* symbols/* types/*; \
	tar -cz --transform='s,^,xkb/,' \
	-f xkb.tgz compat/neo_mods rules/base rules/base.xml rules/evdev rules/evdev.xml symbols/de symbols/level3 symbols/level5 symbols/shift types/level5

clean: 
	rm -f ${FILES}

.PHONY: clean
