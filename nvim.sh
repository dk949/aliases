#!/bin/bash
# nvim aliases

# shellcheck disable=2016,2139
# alias nvim='nvim $([ -n "$NVIM" ] && echo "--server $NVIM") --remote'
export GIT_EDITOR='nvim $([ -n "$NVIM" ] && echo "--server $NVIM --remote" || echo "--remote")'
alias nvim="$GIT_EDITOR"

if [ "$(id -u)" = "0" ]; then
    n() { \nvim -u "$XDG_CONFIG_HOME/vim/vimrc" --noplugin "$@"; }
else
    n() { nvim "$@"; }

    alias nt="n +'term' -c 'startinsert'"
    alias nb="n +':NvimTreeOpen'"
    alias ns='sudo nvim -u $XDG_CONFIG_HOME/vim/vimrc --noplugin'
    alias ses='n -S Session.vim'
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

        old_ifs=$IFS

        IFS=$'\n'
        #shellcheck disable=SC2207 # no
        files=($(rg "$1" -l))

        n "${files[@]}" +"silent /$(echo "$1" | sed "s/\\\\(/$___F/g;s/\\\\)/$___R/g;s/(/\\\\(/g;s/)/\\\\)/g;s/$___F/(/g;s/$___R/)/g;")"

        IFS=$old_ifs
        unset old_ifs
        unset ___F
        unset ___R
    }

fi
