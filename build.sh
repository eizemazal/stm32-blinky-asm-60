#!/bin/sh

SLUG=stminimal

which docker

if [ $? -ne 0 ]
then
    echo "You have to install Docker to run this."
    exit -1
fi

docker build ./toolchain -t "$SLUG-builder"

rm -rf ./build
mkdir -p ./build
docker run --rm -v $(pwd)/build:/build -v $(pwd)/src:/src -v $(pwd)/toolchain/asm.sh:/asm.sh "$SLUG-builder" /asm.sh