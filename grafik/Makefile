# directories to recursively 
SUBDIRS=\
	aufkleber \
	aufsteller \
	bilder-einzeln \
	bilder-uebersicht \
	handbuch-cover \
	heatmap \
	logos \
	maskottchen 

default_rule: all

TARGETS=all svg svg-path pdf png clean

.PHONY: ${TARGETS}

# build the target of the same name in each subdirectory
$(TARGETS):
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@; \
	done
