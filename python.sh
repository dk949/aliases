#!/bin/sh

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
    if [ -n "$1" ]; then
        if [ -d "$1" ] && [ -f "$1/bin/activate" ]; then
            echo "Activating ($1) virtual environment"
            . "$1/bin/activate"
            return 0
        else
            echo "$1 is not a valid virtual environment"
            return 1
        fi
    fi
    for i in *; do
        if [ -d "$i" ]; then
            if [ -f "$i/bin/activate" ]; then
                # the ${i%?} thing takes the last character off the venv name (its a '/')
                echo "Activating (${i%?}) virtual environment"
                . "$i/bin/activate"
                return 0
            fi
        fi
    done
    echo "No virtual environment found"
    return 1
}

alias bpy='bpython'
