#!/bin/sh

# Python aliases

# Creates a new python virtual environment and activtes it upon creation
# Note: use "virtualenv [environment name]" to create an environment without activating it

venv() {
    if [ $# -ne 1 ]; then
        echo "Usage: $(basename "$0") VENV_NAME"
        exit 1
    fi
    virtualenv "$1"
    . "$1"/bin/activate
}

# Checks if the current directory has a venv. If it does, it gets activated. If no then a message is printed

activate() {
    if [ $# -ne 0 ]; then
        echo "Usage: $(basename "$0")"
        return 1
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
}

alias bpy='bpython'
