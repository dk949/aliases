# Python aliases

# Creates a new python virtual environment and activtes it upon creation
# Note: use "virtualenv [environment name]" to create an environment without activating it

venv() {
    if [ $# -gt 1 ]; then
        echo "Usage: venv [VENV_NAME]"
        return 1
    fi
    local venv_name
    local activate_error
    local activate_code
    activate_error=$(___get_venv_activate_path $1 2>&1)
    activate_code=$?
    case "$activate_code" in
        0) activate $1; return 0 ;;
        2) venv_name=$1 ;;
        3) venv_name=venv ;;
        *) echo "$activate_error"; return "$activate_code" ;;
    esac

    echo "DBG: venv_name='$venv_name'"
    python -m venv "$venv_name"
    activate "$venv_name"
}

# Checks if the current directory has a venv. If it does, it gets activated. If no then a message is printed

___get_venv_activate_path() {
    local activate_path
    if [ -n "$1" ]; then
        if [ -d "$1" ] && [ -f "$1/bin/activate" ]; then
            activate_path=$1/bin/activate
        else
            echo "($1) is not a valid virtual environment" 1>&2
            return 2
        fi
    else
        if ! activate_path=$(find . -wholename '*/bin/activate' -type f | grep .); then
            echo "No virtual environment found"  1>&2
            return 3
        fi
    fi
    local print_name=$(sed -E 's|^(\./)?([^/]*).*$|\2|g' <<< "$activate_path")
    
    if [ -z "$activate_path" ]; then
        echo "Internal error, could not find virtual environment" 1>&2
        return 255
    fi
    printf "%s" "$activate_path":"$print_name"
}

activate() {
    if [ $# -gt 1 ]; then
        echo "Usage: activate [VENV_NAME]"
        return 1
    fi

    local path_print_name
    local path_print_code
    path_print_name=$(___get_venv_activate_path $1)
    path_print_code=$?
    if [ "$path_print_code" -ne 0 ]; then
        return "$path_print_code"
    fi

    activate_path=$(cut -d: -f1 <<< "$path_print_name")
    print_name=$(cut -d: -f2 <<< "$path_print_name")

    echo "Activating $print_name virtual environment"
    . "$activate_path"

    if [ -n "$ZSH_VERSION" ]; then 
        rehash # zsh needs to explicitly update PATH cache
    fi
}

alias bpy='bpython'
