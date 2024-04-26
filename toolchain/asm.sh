#!/bin/sh

arm-none-eabi-as /src/main.s -o /build/main.o
arm-none-eabi-ld /build/main.o -T /src/target.ld -o /build/main.elf
arm-none-eabi-objcopy -O binary /build/main.elf /build/main.bin
