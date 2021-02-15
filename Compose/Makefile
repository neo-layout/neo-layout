#
# Neo/Compose/Makefile
# Autor: hcw@gmx.de

# Ort der Modul-Dateien 
#
SRC = ./src
PSEUDO_MODULES_FILES = $(SRC)/enUS.module
MODULES_FILES = $(PSEUDO_MODULES_FILES) $(wildcard $(SRC)/*.module) $(wildcard $(SRC)/*.remove)

# Gewünschte Build-Reihenfolge der Module.  Die in den Listen
# genannten Dateien werden (falls Module dieses Namens existieren) in
# der vorgegebenen Reihenfolge zwingend am Anfang oder am Ende von
# XCompose eingefügt.  Alle nicht erwähnten Module kommen in
# alphabetischer Reihenfolge in die Mitte.
#
MODULE_ORDER_HEAD = pre1 pre2 pre3 pre4 enUS base
MODULE_ORDER_TAIL = user post1 post2 post3 post4

M := $(sort $(notdir $(basename $(MODULES_FILES))))
MODULES := $(foreach i, $(MODULE_ORDER_HEAD), $(findstring $(i),$(M)))
MODULES += $(filter-out $(MODULE_ORDER_HEAD) $(MODULE_ORDER_TAIL), $(M))
MODULES += $(foreach i, $(MODULE_ORDER_TAIL), $(findstring $(i),$(M)))

$(if $(findstring _,$(M)), \
  $(error Unterstrich in Dateinamen $(SRC)/*.module nicht erlaubt))

# Hilfsprogramme
#
CHECKCOMPOSE = ./check-compose.pl
CONFIGURE = /bin/bash ./configure.sh

# Nutzerkonfiguration für Zusammenstellung der Datei XCompose.
# Datei .config wird von 'make config' interaktiv geschrieben.
# Defaultwert, falls .config noch nicht existiert.
#
-include $(wildcard .config)
USER_XCOMPOSE ?= XCompose_enUS_base_cyrillic_diacritics_lang_greek_math_math-font

#
# 'make' bzw. 'make all' erzeugt die Datei XCompose ohne Installation
#

all : XCompose

#
# 'make config' führt interaktive Abfrage der Konfiguration durch 
# und legt Ergebnis in .config ab

.config :
	@echo Kein .config gefunden.  Beginne mit Default.
	@echo "USER_XCOMPOSE = $(USER_XCOMPOSE)" > .config

config : $(PSEUDO_MODULES_FILES) .config
	@$(CONFIGURE) $(MODULES)

#
# 'make XCompose_foo_bar_baz' erzeugt Datei aus Modulen foo bar baz
#
#
XCompose_% : remove_% joined_%
# Entferne Zeilen aus remove_%
# Entferne Leerzeilen und Kommentarzeilen
# Entferne alles ab dem zweiten "
# Normalisiere Whitespace außerhalb von " "
# Sortiere und Entferne Duplikate
	@echo "Erzeuge $@."
	@grep -Fvxf $^ | \
		grep -v -e '^#' -e '^\s*$$' | \
		perl -pe 's/(.*".*").*/\1/' | \
		perl -pe 's{("[^"]*"|[^"\t ]+)|\s+}{$$1 // " "}ge' | \
		sort -u > $@


joined_% : $(MODULES_FILES)
	@echo "Erzeuge $@."
	@echo "#" >$@
	@echo "# Automatically generated file $@.  Do not edit." >>$@
	@echo "#" >>$@
	@for i in \
	`echo $@ | sed -e 's/joined_//;s/_/ /g'` ;\
	do \
	   fn=$(SRC)/$$i.module ;\
	   if [ -e $$fn ]; then \
	      echo "# begin include module $$i" >>$@ ;\
	      cat $$fn >>$@ ;\
	      echo "# end include module $$i" >>$@ ;\
	   else \
	      echo "*** Warnung: Datei $$fn kann nicht eingebunden werden" ;\
	   fi \
	done

remove_% : $(MODULES_FILES) 
	@echo "Erzeuge $@."
	@echo "#" >$@ 
	@echo "# Automatically generated file $@.  Do not edit." >>$@ 
	@echo "#" >>$@ 
	@for i in \
	`echo $@ | sed -e 's/remove_//;s/_/ /g'` ;\
	do \
	   fn=$(SRC)/$$i.remove ;\
	   if [ -e $$fn ]; then \
	      cat $$fn >>$@ ;\
	   fi \
	done

XCompose : $(USER_XCOMPOSE) $(wildcard .config)
	cp $< $@

#
# Regeln für Pseudo-Module
#
# Im Grunde braucht src/en_US.UTF-8 gar nicht in der Neo-Distribution
# enthalten zu sein; man könnte stattdessen auch an dieser Stelle
# die Abhängigkeit
#    $(SRC)/enUS.module : /usr/share/X11/locale/en_US.UTF-8/Compose
# setzen.
#
$(SRC)/enUS.module : $(SRC)/en_US.UTF-8
	@ ( \
	   echo "# File $@, wird aus $< durch Kopieren erzeugt." ;\
	   echo "#configinfo en_US.UTF-8, Standard unabhängig von Neo" ;\
	   cat $< \
	) > $@

#
# Installiere ins Homeverzeichnis
#

install : XCompose
	cp XCompose $${HOME}/.XCompose

#
# Test der XCompose-Dateien auf Korrektheit
#

check : 
	@for i in $(wildcard XCompose*) ; do \
	   $(CHECKCOMPOSE) -q $$i || (\
	   echo Problem in Datei $$i. ;\
	   echo Mehr Informationen mit \`$(CHECKCOMPOSE) $$i\'. ); done

#
# weitere Standard-Targets
#

clean :
	-rm -f XCompose_*
	-rm -f XCompose

distclean : clean
	-rm -f .config
	-rm -f $(SRC)/enUS.module

.PHONY : all config check clean distclean install 

