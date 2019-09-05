#!/bin/bash

# source ~/toolchain/setup/arm.sh

export TOOLCHAIN_ROOT=$HOME/toolchain/gcc-arm-none-eabi-8-2018-q4-major
export CROSS_COMPILE=arm-linux-gnueabi
export ARCH=arm
export CC=arm-none-eabi-gcc
export CXX=arm-none-eabi-g++

export PATH=$TOOLCHAIN_ROOT/bin/:$PATH

MCFLAGS="-mcpu=cortex-m4 -mthumb -mfloat-abi=soft -mfpu=fpv4-sp-d16"
OPTIMIZE="-O0"
DEFS="-DSTM32F4 -DSTM32F407VGTx -DDEBUG -DSTM32F40XX -DSTM32F40_41xxx"
CFLAGS="$MCFLAGS -g $DEFS $OPTIMIZE $HEADERS"
LDSCRIPT="memory_layout.ld"
LDFLAGS="-T $LDSCRIPT $MCFLAGS -lm -lc --specs=nano.specs $ARCH_FLAGS $LTO_FLAGS $DEBUG_FLAGS -static -Wl,-gc-sections"

CC="arm-none-eabi-gcc"
SIZE="arm-none-eabi-size"
OBJCOPY="arm-none-eabi-objcopy"

BINARY="app.bin"
HEX="app.hex"
ELF="app.elf"

$CC -o app.elf isr.c main.c $CFLAGS $LDFLAGS
$OBJCOPY -O ihex $ELF $HEX
$OBJCOPY -O binary $ELF $BINARY
