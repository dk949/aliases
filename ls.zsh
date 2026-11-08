#!/bin/sh

export EZA_COMMON_FLAGS="--color-scale size --color=auto --icons --sort=Name --git --hyperlink auto"

#export EZA_COLORS="da=38;5;074" # light blue
#export EZA_COLORS="da=38;5;102" # dark gray
#export EZA_COLORS="da=38;5;145" # lighter gray (xterm grey69)
export EZA_COLORS="da=38;5;145" # lighter gray (xterm grey69)

# ls aliases
if (( $+commands[eza] )); then
    alias l="eza -l $EZA_COMMON_FLAGS"
    alias la="eza -a $EZA_COMMON_FLAGS"
    alias lg="eza --git --git-ignore -al $EZA_COMMON_FLAGS"
    alias ll="eza -al $EZA_COMMON_FLAGS"
    alias ls="eza $EZA_COMMON_FLAGS"
    alias lt="eza $EZA_COMMON_FLAGS -al --sort=new "
else
    # Fallback to the system ls. The aliases below expand `ls`, so they get colour too.
    if [[ $OSTYPE == darwin* ]]; then
        alias ls='ls -G'
    else
        alias ls='ls --color=auto'
    fi
    alias l='ls -lh'
    alias la='ls -A'
    alias lg='ls -lhA' # no equivalent of --git-ignore
    alias ll='ls -lhA'
    alias lt='ls -lhAtr' # newest last, like eza --sort=new
fi
