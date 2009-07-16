SRC = ./src

DEFAULTS = \
	base \
	base_math \
	base_greek \
	base_math_greek_lang \
	base_greek_lang \
	base_roman

MODULES_SRC = $(wildcard $(SRC)/*.module)
MODULES = $(notdir $(basename $(MODULES_SRC)))

CHECKCOMPOSE = ./check-compose.pl

help : 
	@echo Available modules: $(MODULES).
	@echo Type \`make XCompose_mod1_mod2_mod3\' to create 
	@echo "   " compose file from modules \`mod1\', \`mod2\', and \`mod3\'.
	@echo Type \`make all\' to create default file set.
	@echo Type \`make clean\' to cleanup directory.
	@echo Copy the file XCompose_mod1_mod2_mod3 to \~/.XCompose afterwards.

all : $(addprefix XCompose_, $(DEFAULTS))

XCompose%: $(MODULES_SRC) 
	@echo Creating file $@
	echo "#" >$@ 
	echo "# Automatically generated file.  Do not edit." >>$@ 
	echo "#" >>$@ 
	for i in \
	`echo $@ | sed -e 's/XCompose//;s/_/ /g'`;\
	do \
	   fn=$(SRC)/$$i.module;\
	   if [ -e $$fn ]; then \
	      echo "# begin include module $$i" >>$@ ;\
	      cat $$fn >>$@ ;\
	      echo "# end include module $$i" >>$@ ;\
	   else \
	      echo "*** Warning: file $$fn not found";\
	   fi \
	done

XCompose : XCompose_base
	cp $< $@

check :
	@for i in XCompose*; do \
	   $(CHECKCOMPOSE) -q $$i || (\
	   echo Problem in file $$i. ;\
	   echo Run \`$(CHECKCOMPOSE) $$i\' for more details. ); done

clean :
	-rm -f XCompose_*
	-rm -f XCompose



.PHONY : clean help check

