# paging-lc

A page table written in LC, based on the week 4 and week 5 labs from the
[Languages and Low-Level Programming Course(LLP)](http://web.cecs.pdx.edu/~mpj/llp/).
This lab was originally implemented in C, which can be found [here](https://github.com/dvaneson/paging).

To compile and run this program, you will need a copy of
[mil-tools](https://github.com/habit-lang/mil-tools). LC was intended to be
used primarily as an intermediate language for the Habit compiler, which uses
mil-tools as its back end and [alb](https://github.com/habit-lang/alb) as its
front end. The long term goal is to transition this example to a Habit
implementation, which will give access to a broader range of language features
and avoid some of the awkward details that can be expected from trying to create
programs in an intermediate language that was not originally intended to be used
for handwritten code. Nevertheless, we hope that the resulting code will be
relatively easy to understand, and that it will help to give some indication of
what will ultimately be possible using Habit.

Currently, only part of the week 4 lab has been implemented. A compilation error
prevented further development. In its current state the program will compile and
run, setting up a screen for the kernel and displaying various information.
Uncommenting line 47 in `paging-lc/kernel/kernel.llc` will cause the compiler to
throw a null pointer exception.

## Installation Notes:

-   The code in this repository assumes that you have installed
    `mil-tools` and added a copy of the `milc` script to a suitable
    folder on your path (for example, `~/bin/milc` or `~/local/bin/milc`).
    In addition, for the purposes of compiling these programs, you will
    need to modify that script to ensure that the `mil-tools` library
    folder (i.e., `mil-tools/lib`) is referenced when you run `milc`.
    This can be accomplished by editing the script file so that the
    second line matches the following pattern:

          java -jar MILPATH/mil-tools.jar -iMILPATH/lib $*

    where both occurrences of `MILPATH` are replaced with an absolute
    path for your `mil-tools` folder.

-   We typically run these programs in a virtual machine that is
    running Ubuntu 18.04 LTS with the following packages installed:

          gcc make perl linux-headers-$(uname -r) \
          build-essential dkms clang llvm qemu xorriso libc6-x32 \
          parted default-jdk git ant gcc-multilib g++-multilib

    You can find a detailed set of instructions for building a virtual
    machine that is suitable for running these programs by
    [clicking here](http://web.cecs.pdx.edu/~mpj/llp/vminstall/). This
    information may also be useful if you are trying to configure a
    machine with a different version of Linux for the purpose of running
    these programs.

-   We recommend using the provided Makefiles to compile and run these
    programs. For example, you can build a specific demo program using:

          make

    You can replace `make` with `make run` in either of the examples above
    to build and also run the program inside QEMU, or you can use `make clean`
    to remove temporary files that are generated during the build process.

## libs-lc

This program depends on libraries that are packaged together in the libs-lc
folder. (These are used in addition to the standard LC libraries in
`mil-tools/lib` that provide more general functionality). The library files in
libs-lc include:

-   `vram.llc`: A simple video RAM library that includes functions
    for clearing the screen and writing data to screen.

-   `wvram.llc`: An expanded version of `vram.llc` that supports
    the definition and use of multiple "windows" within the video
    RAM

-   `ia32.llc`: A library of functions for working with low-level
    IA32 data structures, including contexts (for capturing CPU
    registers), and page tables and page directories for working
    with the MMU.

-   `cursor.llc`: The beginnings of a general library for using
    "cursor" abstractions to traverse variable size data structures
    in a safe manner.

-   `mimg.llc`: Functions for reading and displaying the bootdata
    information that is passed on by the `mimg` tool.

-   `portio.llc`: Access to IA32 port IO, supported by the
    LLVM and assembly code fragments in `portio.ll`.

-   `pc-hardware.llc`: Functions for working with the programmable
    interrupt controllers (PICs) and the programmable interval
    timer (PIT) on a standard PC platform.

-   `serial.llc`: Functions for printing single characters,
    null-terminated strings, and numeric values on the COM1
    serial port. When these demos are executed with the
    provided `Makefile` settings in `QEMU`, all output that
    is "printed on the serial port" will actually be displayed
    in the main terminal window. This can be useful for viewing
    and capturing program output, especially when there is too
    much to fit on a single video RAM screen.

-   `intervals.llc`: Code for working with sets of intervals (that
    typically represent ranges of available or reserved memory
    addresses).
