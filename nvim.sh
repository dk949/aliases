#!/bin/sh
# nvim aliases
alias n='nvim'
alias nt='nvim .'
alias ns='sudo nvim'
alias ses='nvim -S Session.vim'
alias vimwiki='nvim +VimwikiIndex'

ncpp() {
    FILE_NAME="$(echo "$1" | cut -d'.' -f 1)"
    nvim "${FILE_NAME}.hpp" "${FILE_NAME}.cpp" -O
    unset FILE_NAME
}


nre() {
    nvim $(rg $1 -l) -p
}
