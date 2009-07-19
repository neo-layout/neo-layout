#
# Neo/Compose/Makefile
# Autor: hcw@gmx.de

# Ort der Modul-Dateien 
#
SRC = ./src
PSEUDO_MODULES_FILES = $(SRC)/enUS.module
MODULES_FILES = $(PSEUDO_MODULES_FILES) $(wildcard $(SRC)/*.module)
MODULES = $(notdir $(basename $(MODULES_FILES)))

# Liste von Demofiles, werden bei 'make all' erzeugt.
# Im Grunde ist dies seit 'make config' überflüssig.
#
DEMOFILES = \
	XCompose_enUS_base \
	XCompose_enUS_base_math \
	XCompose_enUS_base_math_greek_lang \
	XCompose_enUS_base_greek_lang \
	XCompose_enUS_base_roman

# Hilfsprogramme
#
CHECKCOMPOSE = ./check-compose.pl
CONFIGURE = /bin/bash ./configure.sh

# Nutzerkonfiguration für Zusammenstellung der Datei XCompose.
# Datei .config wird von 'make config' interaktiv geschrieben.
# Defaultwert, falls .config noch nicht existiert.
#
-include ./.config
USER_XCOMPOSE ?= XCompose_enUS_base_math

#
# 'make' bzw. 'make all' erzeugt die Datei XCompose ohne Installation
#

all : XCompose $(DEMOFILES)

#
# 'make config' führt interaktive Abfrage der Konfiguration durch 
# und legt Ergebnis in .config ab


config : $(PSEUDO_MODULES_FILES)
	@if [ ! -f .config ] ; then \
	   echo "USER_XCOMPOSE = $(USER_XCOMPOSE)" > .config ; fi
	$(CONFIGURE) $(MODULES)

#
# 'make XCompose_foo_bar_baz' erzeugt Datei aus Modulen foo bar baz
#

XCompose_% : $(MODULES_FILES) 
	@echo "Erzeuge $@."
	@echo "#" >$@ 
	@echo "# Automatically generated file $@.  Do not edit." >>$@ 
	@echo "#" >>$@ 
	@for i in \
	`echo $@ | sed -e 's/XCompose//;s/_/ /g'` ;\
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

