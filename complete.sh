#!/bin/zsh
# complete
# completions
#shell="$(readlink -f /proc/$$/exe | rev | cut -d'/' -f 1 | rev)"
compdef _path_commands run
