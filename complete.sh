#!/bin/zsh
# complete
# completions
#shell="$(readlink -f /proc/$$/exe | rev | cut -d'/' -f 1 | rev)"
compdef _path_commands run

_comp() {
    local -a compilers
    compilers=(gcc clang default)
    _describe 'compilers' compilers
}
compdef _comp comp
