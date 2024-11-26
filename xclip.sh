#!/bin/sh

# xclip aliases

# Pipe into clip to copy text
alias clip='xclip -selection "clipboard"'

#copy current directory
alias cpath='echo $PWD | xclip -selection "clipboard"'

# change to the directory in the clip board
alias cdc='cd "$(xclip -selection "clipboard" -o)"'

