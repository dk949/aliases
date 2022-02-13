#!/bin/sh


export EXA_COMMON_FLAGS="--color-scale --color=auto --no-icons --sort=Name --git"

# ls aliases
alias l="exa -l $EXA_COMMON_FLAGS"
alias la="exa -a $EXA_COMMON_FLAGS"
alias ll="exa -al $EXA_COMMON_FLAGS"
alias ls="exa $EXA_COMMON_FLAGS"
alias lg="exa --git --git-ignore -l $EXA_COMMON_FLAGS"
