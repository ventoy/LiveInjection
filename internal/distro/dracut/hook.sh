#!/bin/sh

PATH=/ventoy/busybox:$PATH

if [ -d /var/lib/dracut/hooks ]; then
    DRACUTDIR=/var/lib/dracut/hooks
else
    DRACUTDIR=/lib/dracut/hooks
fi

cp -a ../injection_dracut_hook.sh $DRACUTDIR/pre-pivot/99-injection_dracut_hook.sh
dos2unix $DRACUTDIR/pre-pivot/99-injection_dracut_hook.sh
chmod +x $DRACUTDIR/pre-pivot/99-injection_dracut_hook.sh

