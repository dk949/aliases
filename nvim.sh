#!/bin/sh
# nvim aliases

n() {
    if [ -n "$NVIM" ]; then
        nvr --servername "$NVIM" "$@"
    else
        nvim "$@"
    fi
}


alias nt="n +'term' -c 'startinsert'"
alias nb='n -s .'
alias ns='sudo nvim'
alias ses='nvim -S Session.vim'
alias vimwiki='n +VimwikiIndex'
alias vim='nvim -u NONE'

ncpp() {
    FILE_NAME="$(echo "$1" | cut -d'.' -f 1)"
    nvr -s "${FILE_NAME}.hpp" "${FILE_NAME}.cpp" -O
    unset FILE_NAME
}


nre() {
    nvr -s $(rg $1 -l)
}
