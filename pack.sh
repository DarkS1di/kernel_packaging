#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path to kernel binary> <zip name>"
    exit 1
fi

KERNELBIN="$1"
ZIPNAME="$2"

if [ ! -f "$KERNELBIN" ]; then
    echo "Error: '$KERNELBIN' is either not a file or doesn't exist"
    exit 1
fi

cp -f "$KERNELBIN" AnyKernel3/Image

cd AnyKernel3
zip -r9 "../$ZIPNAME" META-INF tools anykernel.sh Image version
