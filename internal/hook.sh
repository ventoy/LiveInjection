#!/bin/sh

PATH=/ventoy/busybox:$PATH

datadir=$(ls -1 / | grep live_injection_)
ostype=$1

if [ -d "/$datadir" -a -n "$ostype" ]; then
    :
else
    exit 0
fi

tar -xzf /$datadir/sysroot.tar.gz -C /$datadir/ && rm -f /$datadir/sysroot.tar.gz
chmod -R 755 /$datadir/sysroot


CurDir=$(pwd)
if [ -f /$datadir/distro/$ostype/hook.sh ]; then
    cd /$datadir/distro/$ostype/
    sh /$datadir/distro/$ostype/hook.sh
    cd $CurDir
fi
