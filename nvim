#!/bin/sh
# nvim aliases
alias n='nvim'
alias nt='nvim .'
alias ns='sudo nvim'
alias ses='nvim -S Session.vim'
alias vimwiki='nvim +VimwikiIndex'

ncpp() {
    ___FILE_NAME="$(echo "$1" | cut -d'.' -f 1)"
    nvim "${___FILE_NAME}.hpp" "${___FILE_NAME}.cpp" -O
    unset ___FILE_NAME
}
