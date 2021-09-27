#!/bin/sh

PATH=/ventoy/busybox:$PATH

if [ -d /scripts ]; then
    ls -1 /scripts/ | grep bottom | while read line; do
        if [ -d /scripts/$line ]; then
            cp -a ../injection_bottom_hook.sh /scripts/$line/99injection_bottom_hook.sh
            dos2unix /scripts/$line/99injection_bottom_hook.sh
            chmod +x /scripts/$line/99injection_bottom_hook.sh
            if [ -f /scripts/$line/ORDER ]; then
                echo "/scripts/$line/99injection_bottom_hook.sh" >> /scripts/$line/ORDER
            fi
        fi
    done
fi
