
ventoy_live_injection() {
    local datadir=$(ls -1 / | grep live_injection_)
    
    [ -f /$datadir/done ] && return
    echo $0 > /$datadir/done
    
    . $datadir/distro/functions.sh
    
    vroot=$1

    if [ -d $vroot/etc ]; then
        chown_for_live "/$datadir/sysroot" $vroot
        cp -a /$datadir/sysroot/* $vroot/
    fi
}

ventoy_live_injection $NEW_ROOT

