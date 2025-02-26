#!/bin/sh
# Extra fucntionality aliases

# clears selected file

alias o='xdg-open'

comp() {
    if [ $# -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: comp [COMPILER]"
        return 2
    fi

    case $1 in
        gcc|g++)
            export CC=gcc CXX=g++
            return 0
            ;;

        clang|clang++)
            export CC=clang CXX=clang++
            return 0
            ;;
        default)
            unset CC CXX
            export CC CXX
            ;;
        *)
            echo "Unsupported compiler $1"
            return 1
            ;;
    esac

}
