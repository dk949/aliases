#!/bin/sh

export EZA_COMMON_FLAGS="--color-scale size --color=auto --icons --sort=Name --git"

#export EZA_COLORS="da=38;5;074" # light blue
#export EZA_COLORS="da=38;5;102" # dark gray
#export EZA_COLORS="da=38;5;145" # lighter gray (xterm grey69)
export EZA_COLORS="da=38;5;145" # lighter gray (xterm grey69)

# ls aliases
alias l="exa -l $EZA_COMMON_FLAGS"
alias la="exa -a $EZA_COMMON_FLAGS"
alias lg="exa --git --git-ignore -al $EZA_COMMON_FLAGS"
alias ll="exa -al $EZA_COMMON_FLAGS"
alias ls="exa $EZA_COMMON_FLAGS"
