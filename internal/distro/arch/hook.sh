#!/bin/sh

PATH=/ventoy/busybox:$PATH

cp -a ../injection_common_hook.sh /hooks/
sed "/run_latehook/a sh /hooks/injection_common_hook.sh /new_root" -i /init
