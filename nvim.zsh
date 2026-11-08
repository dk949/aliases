#!/bin/bash
# nvim aliases

# Without nvim, leave vim, git's editor, etc. alone
(( $+commands[nvim] )) || return 0

export GIT_EDITOR='nvim'

if (( EUID == 0 )); then
    alias n=vim
else
    alias n=nvim

    alias nt="n +'term' -c 'startinsert'"
    alias nn="n ."
    alias ns='sudo vim'
fi
