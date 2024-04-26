#!/bin/sh

which st-flash

if [ $? -ne 0 ]
then
    echo "You have to install stlink (including st-flash) to run this."
    exit -1
fi

if [ ! -f "build/main.bin" ]
then
    echo "You need to run ./build.sh to get main.bin in build/ directory first"
    exit -1
fi

st-flash write build/main.bin 0x8000000