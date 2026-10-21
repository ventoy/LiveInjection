#!/bin/sh

PATH=/ventoy/busybox:$PATH

datadir=$(ls -1 / | grep live_injection_)
ostype=$1

echo "datadir=$datadir"
echo "ostype=$ostype"

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

    if [ -d /var/lib/dracut/hooks ]; then
        echo 'dracut'; return
    fi

    echo 'fallback'
}

if [ ! -f /$datadir/distro/$ostype/hook.sh ]; then
    echo "/$datadir/distro/$ostype/hook.sh not exist, now check possible os type"
    ostype=$(check_possible_os_type)
    echo "check_possible_os_type=$ostype"
fi


CurDir=$(pwd)
if [ -f /$datadir/distro/$ostype/hook.sh ]; then
    cd /$datadir/distro/$ostype/
    sh /$datadir/distro/$ostype/hook.sh
    cd $CurDir
else
    echo "/$datadir/distro/$ostype/hook.sh finally not exist"
fi

