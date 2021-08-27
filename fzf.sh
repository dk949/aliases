#!/bin/sh

# fzf aliases
# FIXME: why does this exist? I never use it

# A terminal based run launcher.
prog() {
    eval "$(echo "$PATH_FILES" | fzf)"
}

