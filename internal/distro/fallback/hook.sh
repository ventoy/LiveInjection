#!/bin/sh

PATH=/ventoy/busybox:$PATH

if grep -q 'run_latehook' /init; then
    echo 'run_latehook exist ...'
    cp -a ../injection_common_hook.sh /hooks/
    sed "/run_latehook/a sh /hooks/injection_fallback_hook.sh" -i /init
elif [ -d /scripts ]; then
    echo "/scripts exist ..."
    ls -1 /scripts/ | grep bottom | while read line; do
        if [ -d /scripts/$line ]; then
            cp -a ../injection_bottom_hook.sh /scripts/$line/99injection_bottom_hook.sh
            dos2unix /scripts/$line/99injection_bottom_hook.sh
            chmod +x /scripts/$line/99injection_bottom_hook.sh
            
            echo "Copy injection_bottom_hook.sh --> /scripts/$line/99injection_bottom_hook.sh"
            
            if [ -f /scripts/$line/ORDER ]; then
                echo "/scripts/$line/99injection_bottom_hook.sh" >> /scripts/$line/ORDER
            fi
        fi
    done
fi

