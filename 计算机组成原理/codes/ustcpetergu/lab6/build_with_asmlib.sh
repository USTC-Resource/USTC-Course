#!/bin/bash
# usage ./build_with_lib.sh asm_file_name
set -e

mipsel-linux-gnu-as $1.asm -o $1.o -EB -O0
mipsel-linux-gnu-as ./mylib/mylib.asm -o mylib.o -EB -O0

mipsel-linux-gnu-ld -nostdlib --script linker.ld mylib.o $1.o -o $1.elf -EB
mipsel-linux-gnu-objcopy -O binary $1.elf $1.bin
cat > result_$1.coe << EOF
memory_initialization_radix  = 16;
memory_initialization_vector =
EOF
xxd -c 4 -p $1.bin >> result_$1.coe
mipsel-linux-gnu-objdump -d $1.elf
