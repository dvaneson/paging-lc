# paging-lc

A page table written in LC, based on the week 4 and week 5 labs from the
[Languages and Low-Level Programming Course(LLP)](http://web.cecs.pdx.edu/~mpj/llp/).
This lab was originally implemented in C, and can be found [here](https://github.com/dvaneson/paging).

To compile and run this program, you will need a copy of mil-tools
(https://github.com/habit-lang/mil-tools). LC was intended to be used primarily
as an intermediate language for the Habit compiler, which uses mil-tools as its
back end and alb (https://github.com/habit-lang/alb) as its front end. The long
term goal is to transition this example to a Habit implementation, which will
give access to a broader range of language features and avoid some of the
awkward details that can be expected from trying to create programs in an
intermediate language that was not originally intended to be used for
handwritten code. Nevertheless, we hope that the resulting code will be
relatively easy to understand, and that it will help to give some indication of
what will ultimately be possible using Habit.

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

    In this case, the choice of program is set by the `BOOT` variable in
    the top-level `Makefile`. If you prefer, you can also build and run
    each of the programs from within its own directory (which might be
    more convenient if you are planning to browse or edit the code for
    that demo); in that case, be sure to run `make libs` in the top-level
    directory first, as in the following example:

          make libs          # must run in top-level directory
          cd switching-lc
          make

    You can replace `make` with `make run` in either of the examples above
    to build and also run the program inside QEMU, or you can use `make clean`
    to remove temporary files that are generated during the build process.
