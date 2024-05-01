#!/bin/sh
# nvim aliases

alias nvim='nvim $([ -n "$NVIM" ] && echo "--server $NVIM") --remote'

if [ "$(id -u)" = "0" ]; then
    n() { \nvim -u "$XDG_CONFIG_HOME/vim/vimrc" --noplugin "$@"; }
else
    n() { nvim; }

    alias nt="n +'term' -c 'startinsert'"
    alias nb="n +':NvimTreeOpen'"
    alias ns='sudo nvim -u $XDG_CONFIG_HOME/vim/vimrc --noplugin'
    alias ses='nvim -S Session.vim'
    alias vimwiki='n +VimwikiIndex'
    alias vim='nvim -u $XDG_CONFIG_HOME/vim/vimrc --noplugin'

    ncpp() {
        FILE_NAME="$(echo "$1" | cut -d'.' -f 1)"
        n "${FILE_NAME}.hpp" "${FILE_NAME}.cpp" -O
        unset FILE_NAME
    }


    nre() {
        # Get two unique strings
        ___F=$(echo "$1" | md5sum | cut -d' ' -f 1)
        ___R=$(echo "$1" | rev | md5sum | cut -d' ' -f 1)
        # replace ( -> \(, ) -> \), \( -> ( and \) -> )
        n $(rg "$1" -l) +"silent /$(echo "$1" | sed "s/\\\\(/$___F/g;s/\\\\)/$___R/g;s/(/\\\\(/g;s/)/\\\\)/g;s/$___F/(/g;s/$___R/)/g;")"
        unset ___F
        unset ___R
    }

fi
