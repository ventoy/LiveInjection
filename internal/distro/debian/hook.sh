#!/bin/sh

PATH=/ventoy/busybox:$PATH

if [ -d /scripts ]; then
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
elif [ -d /live/custom ]; then
    echo "/live/custom exist ..."
    ls -1 /live/custom/ | while read line; do
        echo "Copy injection_antix_hook.sh --> /live/custom/$line/7.sh"
        cat ../injection_antix_hook.sh >> /live/custom/$line/7.sh
    done
else
    echo "###### unsupported hook type #########"
fi

