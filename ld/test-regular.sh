#!/bin/bash

ld \
-dynamic-linker /lib64/ld-linux-x86-64.so.2 \
/usr/lib/gcc/x86_64-linux-gnu/7/../../../x86_64-linux-gnu/Scrt1.o \
/usr/lib/gcc/x86_64-linux-gnu/7/../../../x86_64-linux-gnu/crti.o \
-L/usr/lib/x86_64-linux-gnu \
main.o \
-lc \
/usr/lib/gcc/x86_64-linux-gnu/7/../../../x86_64-linux-gnu/crtn.o
