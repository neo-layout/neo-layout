#
# Neo/Compose/Makefile
# Autor: hcw@gmx.de

# Ort der Modul-Dateien 
#
SRC = ./src
MODULES_FILES = $(wildcard $(SRC)/*.module)
MODULES = $(notdir $(basename $(MODULES_FILES)))

# Liste von Demofiles, werden bei 'make all' erzeugt.
# Im Grunde ist dies seit 'make config' überflüssig.
#
DEMOFILES = \
	XCompose_base \
	XCompose_base_math \
	XCompose_base_math_greek_lang \
	XCompose_base_greek_lang \
	XCompose_base_roman

# Hilfsprogramme
#
CHECKCOMPOSE = ./check-compose.pl
CONFIGURE = /bin/bash ./configure.sh

# Nutzerkonfiguration für Zusammenstellung der Datei XCompose.
# Datei .config wird von 'make config' interaktiv geschrieben.
# Defaultwert, falls .config noch nicht existiert.
#
-include ./.config
USER_XCOMPOSE ?= XCompose_base_math

#
# 'make' bzw. 'make all' erzeugt die Datei XCompose ohne Installation
#

all : XCompose $(DEMOFILES)

#
# 'make config' führt interaktive Abfrage der Konfiguration durch 
# und legt Ergebnis in .config ab
#

config :
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

.PHONY : all config check clean distclean install 

