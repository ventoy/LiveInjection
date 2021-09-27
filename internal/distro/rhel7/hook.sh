#!/bin/sh

PATH=/ventoy/busybox:$PATH

cp -a ../injection_dracut_hook.sh /lib/dracut/hooks/pre-pivot/99-injection_dracut_hook.sh
dos2unix /lib/dracut/hooks/pre-pivot/99-injection_dracut_hook.sh
chmod +x /lib/dracut/hooks/pre-pivot/99-injection_dracut_hook.sh
