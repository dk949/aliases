#!/bin/sh
cdd(){
    if [ $# -ne 1 ]; then
        echo "Usage: $(basename "$0") DIR"
        exit 1
    fi

    mkdir -p "$1"
    cd "$1"
}
