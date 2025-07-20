# Python aliases

# Creates a new python virtual environment and activtes it upon creation
# Note: use "virtualenv [environment name]" to create an environment without activating it

venv() {
    if [ $# -gt 1 ]; then
        echo "Usage: $(basename "$0") [VENV_NAME]"
        return 1
    fi

    if [ -n "$1" ]; then
        ___VENV_NAME="$1"
    else
        ___VENV_NAME="venv"
    fi

    if [ -d "$___VENV_NAME" ] && [ -f "$___VENV_NAME/bin/activate" ]; then
        activate "$___VENV_NAME"
    else
        python -m venv "$___VENV_NAME"
        activate "$___VENV_NAME"
    fi
}

# Checks if the current directory has a venv. If it does, it gets activated. If no then a message is printed

activate() {
    if [ $# -gt 1 ]; then
        echo "Usage: $(basename "$0") [VENV_NAME]"
        return 1
    fi

    local activate_path
    if [ -n "$1" ]; then
        if [ -d "$1" ] && [ -f "$1/bin/activate" ]; then
            activate_path=$1/bin/activate
        else
            echo "($1) is not a valid virtual environment"
            return 1
        fi
    else
        if ! activate_path=$(find . -wholename '*/bin/activate' -type f | grep .); then
            echo "No virtual environment found"
            return 1
        fi
    fi
    local print_name=$(sed -E 's|^(\./)?([^/]*).*$|(\2)|g' <<< "$activate_path")
    if [ "$(wc -l <<< "$activate_path")" -ne 1 ]; then
        printf "Multiple candidate virtual environments found:\n\n%s\n\nSelect one explicitly\n" "$print_name"
        return 1
    fi
    
    if [ -z "$activate_path" ]; then
        echo "Internal error, could not find virtual environment"
        return 2
    fi
    echo "Activating $print_name virtual environment"
    . "$activate_path"

    if [ -n "$ZSH_VERSION" ]; then 
        rehash # zsh needs to explicitly update PATH cache
    fi
}

alias bpy='bpython'
