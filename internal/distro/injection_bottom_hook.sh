#!/bin/sh

PATH=/ventoy/busybox:$PATH

datadir=$(ls -1 / | grep live_injection_)

[ -f /$datadir/done ] && exit 0
echo $* > /$datadir/done

. $datadir/distro/functions.sh

vroot=/root

vtlive_log "======================================"
vtlive_log "$0 called ..."

if [ -d $vroot/etc ]; then    
    chown_for_live "/$datadir/sysroot" $vroot
    
    vtlive_log "Copy /$datadir/sysroot/* to $vroot/"
    cp -a /$datadir/sysroot/* $vroot/
else
    vtlive_log "$vroot/etc not exist"
fi

if [ -d "$vroot/var/log" ]; then
    cat /ventoy/log > $vroot/var/log/ventoy.log
fi

vtlive_log "======================================"
