#!/bin/sh

get_live_uid_gid() {
    vnewroot=$1
    
    if [ ! -f $vnewroot/etc/passwd ]; then
        echo ""; return
    fi
    
    vusercnt=$(ls -1 $vnewroot/home/ | wc -l)
    if [ $vusercnt -ne 1 ]; then
        echo ""; return
    fi
    
    vlive=$(ls -1 $vnewroot/home/)
    grep "^$vlive" $vnewroot/etc/passwd | awk -F: '{print $3":"$4}'    
}

chown_for_live() {
    vdir=$1
    vnewsys=$2
    
    vid=$(get_live_uid_gid $vnewsys)
    if [ -z "$vid" ]; then
        return
    fi

    volddir=$(pwd)
    cd $vdir    
    find . | while read line; do
        if [ "$line" = "." ]; then
            continue
        fi

        if [ -f "$line" ]; then
            chown $vid "$line"
        elif [ -d "$line" ]; then
            vpath=${line#*/}
            if [ ! -d "$vnewsys/$vpath" ]; then
                chown $vid "$line"
            fi
        fi
    done
    cd $volddir
}
