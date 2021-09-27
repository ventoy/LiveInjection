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
chmod -R 777 /$datadir/sysroot




check_possible_os_type() {
    if [ -d /lib/dracut/hooks/pre-pivot ]; then
        echo 'rhel7'; return
    fi
    
    if grep -q 'mount_handler=' /init; then
        if [ -d /hooks ]; then
            echo 'arch'; return
        fi
    fi
    
    if [ -d /scripts ]; then
        if ls -1 /scripts/ | grep -q bottom; then
            echo 'debian'; return
        fi
    fi

    if [ -d /live/custom ]; then
        echo 'debian'; return
    fi

    echo 'xxx'
}

if [ ! -f /$datadir/distro/$ostype/hook.sh ]; then
    ostype=$(check_possible_os_type)
fi

echo "ostype=$ostype" >> /$datadir/log

CurDir=$(pwd)
if [ -f /$datadir/distro/$ostype/hook.sh ]; then
    cd /$datadir/distro/$ostype/
    sh /$datadir/distro/$ostype/hook.sh
    cd $CurDir
fi

