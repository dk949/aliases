#!/bin/sh

export EZA_COMMON_FLAGS="--color-scale size --color=auto --icons --sort=Name --git"

#export EZA_COLORS="da=38;5;074" # light blue
#export EZA_COLORS="da=38;5;102" # dark gray
#export EZA_COLORS="da=38;5;145" # lighter gray (xterm grey69)
export EZA_COLORS="da=38;5;145" # lighter gray (xterm grey69)

# ls aliases
alias l="eza -l $EZA_COMMON_FLAGS"
alias la="eza -a $EZA_COMMON_FLAGS"
alias lg="eza --git --git-ignore -al $EZA_COMMON_FLAGS"
alias ll="eza -al $EZA_COMMON_FLAGS"
alias ls="eza $EZA_COMMON_FLAGS"
