#!/bin/sh

dvm(){
    ___CMD="$HOME/.local/bin/dlang/install.sh --path $HOME/.local/bin/dlang"
    doActivate(){
        ___PATH="$(eval "$___CMD get-path $1")"
        # shellcheck disable=SC1090 disable=SC1091
        if [ "$1" = "dmd" ] || [ -z "$1" ]; then
            . "$(dirname "$___PATH")/../../activate"
            return
        elif  [ "$1" = "ldc" ] || [ "$1" = "gdc" ]; then
            . "$(dirname "$___PATH")/../activate"
            return
        else # TODO: handle gdc
            echo "Unknown compiler " "$1"
            return 1
        fi

    }

    case "$1" in
        activate)
            shift
            doActivate "$1"
            return
            ;;
        deactivate)
            deactivate
            ;;
        *)
            eval "$___CMD $*"
            ;;
    esac
}
