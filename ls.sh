#!/bin/sh


export EXA_COMMON_FLAGS="--color-scale --color=auto --no-icons --sort=Name --git"
#export EXA_COLORS="da=38;5;074" # light blue
#export EXA_COLORS="da=38;5;102" # dark gray
export EXA_COLORS="da=38;5;145" # lighter gray (xterm grey69)

# ls aliases
alias l="exa -l $EXA_COMMON_FLAGS"
alias la="exa -a $EXA_COMMON_FLAGS"
alias lg="exa --git --git-ignore -al $EXA_COMMON_FLAGS"
alias ll="exa -al $EXA_COMMON_FLAGS"
alias ls="exa $EXA_COMMON_FLAGS"
