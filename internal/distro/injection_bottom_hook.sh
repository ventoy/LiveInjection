#!/bin/sh

PATH=/ventoy/busybox:$PATH

datadir=$(ls -1 / | grep live_injection_)

[ -f /$datadir/done ] && exit 0
echo $0 > /$datadir/done

. $datadir/distro/functions.sh

vroot=/root

chown_for_live "/$datadir/sysroot" $vroot
cp -a /$datadir/sysroot/* $vroot/
