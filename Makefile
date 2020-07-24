#----------------------------------------------------------------------------
include Makefile.common

.phony: all run libs clean

BOOT = paging-lc
# BOOT = switching-lc

all:	libs
	make -C ${BOOT}

run:	libs
	make -C ${BOOT} run

libs:
	make -C simpleio
	make -C mimg
	make -C libs-lc

clean:
	-make -C simpleio         clean
	-make -C mimg             clean
	-make -C libs-lc          clean
	-make -C paging-lc        clean
	-make -C switching-lc     clean

#----------------------------------------------------------------------------
