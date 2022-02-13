#!/bin/sh
# Extra fucntionality aliases

# clears selected file
clearfile() {
    echo "" > "$1"
}

alias reboot='sudo reboot'

alias o='xdg-open'

comp() {
    if [ $# -ne 1 ]; then
        echo "Usage: comp [COMPILER]"
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
        *)
            echo "Unsupported compiler $1"
            return 1
            ;;
    esac

}
