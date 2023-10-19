#!/bin/bash
addpath() {
    [[ " $* " == *" --help "* ]] && { echo "Usage: addpath [PATH [back|front]]"; return; }

    local path_to_add="$(realpath -- "${1:=$PWD}")"
    local pos="${2:=back}"
    case "$pos" in
        front) export PATH="$path_to_add:$PATH";;
        back)export PATH="$PATH:$path_to_add";;
        *) echo "Invalid position '$pos', expected 'front' or 'back'"; return 1;;
    esac
    echo "added $path_to_add to PATH"
}
