#!/bin/zsh

# pacman aliases
sizeof() {
    pacman -Qi "$@" | grep -i size
}

pacstat() {
    old="$IFS"
    IFS='|'
    str="${*:2}"
    IFS=$old
    pacman -Qi "$1" | grep -iE "$str"
}

safetoremove() {
    if [ $# -ne 0 ]; then
        echo "Usage: $(basename "$0")"
        exit 1
    fi
    pacman -Qeq | xargs pacman -Qi | awk '{if($1 == "Name") name = $3 ;if($1 == "Required" && $4 == "None") print name }'
}
