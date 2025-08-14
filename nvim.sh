#!/bin/bash
# nvim aliases

export GIT_EDITOR='nvim'

if [ "$(id -u)" = "0" ]; then
    alias n='nvim -u "$XDG_CONFIG_HOME/vim/vimrc" --noplugin'
else
    alias n=nvim

    alias nt="n +'term' -c 'startinsert'"
    alias nn="n ."
    alias ns='sudo nvim -u $XDG_CONFIG_HOME/vim/vimrc --noplugin'
    alias vim='nvim -u $XDG_CONFIG_HOME/vim/vimrc --noplugin'
    alias neorg='n +"Neorg index"'

    ncpp() {
        FILE_NAME="$(echo "$1" | cut -d'.' -f 1)"
        nvim "${FILE_NAME}.hpp" "${FILE_NAME}.cpp" -O
        unset FILE_NAME
    }


    nre() {
        # Get two unique strings
        ___F=$(echo "$1" | md5sum | cut -d' ' -f 1)
        ___R=$(echo "$1" | rev | md5sum | cut -d' ' -f 1)
        # replace ( -> \(, ) -> \), \( -> ( and \) -> )

        old_ifs=$IFS

        IFS=$'\n'
        #shellcheck disable=SC2207 # no
        files=($(rg "$1" -l))

        nvim "${files[@]}" +"silent /$(echo "$1" | sed "s/\\\\(/$___F/g;s/\\\\)/$___R/g;s/(/\\\\(/g;s/)/\\\\)/g;s/$___F/(/g;s/$___R/)/g;")"

        IFS=$old_ifs
        unset old_ifs
        unset ___F
        unset ___R
    }
fi
