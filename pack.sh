#!/bin/bash
set -e

if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <kernel> <dtb> <dtbo_citrus> <dtbo_lime> <zip>"
    exit 1
fi

KERNEL="$1"
DTB="$2"
DTBO_CITRUS="$3"
DTBO_LIME="$4"
ZIP="$5"

if [ ! -f "$KERNEL" ]; then
    echo "Error: '$KERNEL' is either not a file or doesn't exist"
    exit 1
fi

if [ ! -f "$DTB" ]; then
    echo "Error: '$DTB' is either not a file or doesn't exist"
    exit 1
fi

if [ ! -f "$DTBO_CITRUS" ]; then
    echo "Error: '$DTBO_CITRUS' is either not a file or doesn't exist"
    exit 1
fi

if [ ! -f "$DTBO_LIME" ]; then
    echo "Error: '$DTBO_LIME' is either not a file or doesn't exist"
    exit 1
fi

mkdir -p AnyKernel3/citrus
mkdir -p AnyKernel3/lime
cp -f "$KERNEL" AnyKernel3/Image
cp -f "$DTB" AnyKernel3/dtb
cp -f "$DTBO_CITRUS" AnyKernel3/citrus/dtbo.img
cp -f "$DTBO_LIME" AnyKernel3/lime/dtbo.img

cd AnyKernel3
zip -r9 "../$ZIP" citrus lime META-INF tools anykernel.sh dtb Image version
