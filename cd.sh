#!/bin/sh
cdd(){
    if [ $# -ne 1 ]; then
        echo "Usage: $(basename "$0") DIR"
        return 1
    fi

    mkdir -p "$1"
    cd "$1" || return 1
}



save() {
    if [ $# -gt 1 ]; then
        echo "Usage: $(basename "$0") [TAG]"
        return 1
    fi

    echo "$PWD" > "/tmp/dirsave_$1"
}

goback() {
    if [ $# -gt 1 ]; then
        echo "Usage: $(basename "$0") [TAG]"
        return 1
    fi

    if [ ! -f "/tmp/dirsave_$1" ]; then
        echo "Tag file /tmp/dirsave_$1 does not exist"
        return 1
    fi

    cd "$(cat "/tmp/dirsave_$1")" || return 1
}
