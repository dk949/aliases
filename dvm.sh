#!/bin/sh

dvm(){
    ___CMD="install.sh --path $HOME/.local/bin/dlang"

    case "$1" in
        activate)
            shift
            # shellcheck disable=SC1090 disable=SC1091
            . "$(dirname "$(eval "$___CMD get-path $1")")/../../activate"
            ;;
        deactivate)
            deactivate
            ;;
        *)
            eval "$___CMD $*"
            ;;
    esac
}
