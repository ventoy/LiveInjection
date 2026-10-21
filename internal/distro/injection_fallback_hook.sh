#!/bin/sh

PATH=/ventoy/busybox:$PATH

datadir=$(ls -1 / | grep live_injection_)

[ -f /$datadir/done ] && exit 0
echo $* > /$datadir/done

. $datadir/distro/functions.sh

vroot=$(ventoy_new_root_dir)
if [ -n "$vroot" ]; then
    chown_for_live "/$datadir/sysroot" $vroot
    cp -a /$datadir/sysroot/* $vroot/
fi
