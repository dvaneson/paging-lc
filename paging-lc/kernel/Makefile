include ../../Makefile.common

KERNEL_SPACE    = 0xc0000000      # Kernel space starts at 3GB
KERNEL_LOAD     = 0x00100000      # Kernel loads at 1MB

CCDEFS  = -DKERNEL_SPACE=${KERNEL_SPACE} -DKERNEL_LOAD=${KERNEL_LOAD}

LDDEFS  = --defsym KERNEL_SPACE=${KERNEL_SPACE} --defsym KERNEL_LOAD=${KERNEL_LOAD}

all: kernel

#----------------------------------------------------------------------------
# A simple protected mode kernel that context switches between a kernel and
# two user mode programs.

KOBJS   = init.o opt-combined.o

kernel: ${KOBJS} kernel.ld
	$(LD) ${LDDEFS} -T kernel.ld -o kernel ${KOBJS} ${LIBPATH} --print-map > kernel.map
	strip kernel

init.o: init.S
	$(CC) ${CCDEFS} -c -o init.o init.S

kernel.ll: kernel.llc widgets.llc
	milc $(MILOPTS) kernel.llc -lkernel.ll -i../../libs-lc \
		-mkernel.mil \
		--llvm-main=kernel --mil-main=kernel

kernel.bc: kernel.ll
	llvm-as -o=kernel.bc kernel.ll

combined.bc: kernel.bc
	llvm-link -o=combined.bc kernel.bc ../../libs-lc/ia32.bc

opt-combined.bc: combined.bc
	opt -always-inline -o=opt-combined.bc combined.bc

opt-combined.o: opt-combined.bc
	clang -c -m32 ${CCOPTS} ${CCDEFS} -o opt-combined.o opt-combined.bc
	llc -O2 -march=x86 opt-combined.bc  # for debugging/inspection of .s

#----------------------------------------------------------------------------
# tidy up after ourselves ...
clean:
	-rm -r kernel kernel.mil opt-combined.s *.bc *.o *.map *.ll

#----------------------------------------------------------------------------
