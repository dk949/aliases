#!/bin/sh

# clipboard

# Copy stdin (or the given files) to the clipboard: pbcopy on macOS,
# wl-copy under Wayland, xclip under X11
clip() {
    if [[ $OSTYPE == darwin* ]]; then
        cat -- "$@" | pbcopy
    elif [[ -n $WAYLAND_DISPLAY ]] && (( $+commands[wl-copy] )); then
        cat -- "$@" | wl-copy
    elif [[ -n $DISPLAY ]] && (( $+commands[xclip] )); then
        cat -- "$@" | xclip -selection clipboard
    else
        print -u2 "clip: no clipboard available (needs pbcopy, wl-copy with Wayland or xclip with X11)"
        return 1
    fi
}
