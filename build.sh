#!/bin/sh
set -e -u -x
cd "$(dirname "$0")"/qemu
./configure --prefix=/usr --static --disable-system --enable-linux-user
make -j "$(nproc)"
destdir=$PWD/../releases
rm -rf "$destdir"
make install DESTDIR="$destdir"
for x in "$destdir"/usr/bin/qemu-*; do
    mv "$x" "$x"-static
done
