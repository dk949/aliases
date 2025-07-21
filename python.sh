# Python aliases

# Creates a new python virtual environment and activtes it upon creation

venv() {
    local usage="Usage: venv [VENV_NAME] [-p|--python VERSION]"
    local venv_name=
    local python_ver
    while [ $# -ne 0 ]; do
        case $1 in
            "-p"|"--python")
                shift
                python_ver=$1
                [ -z "$python_ver" ] && { echo "$usage"; return 1; }
                shift
                ;;
            *)
                [ -n "$venv_name" ] && { echo "$usage"; return 1; }
                venv_name=$1
                shift
                ;;
        esac
    done
    local activate_error
    local activate_code
    activate_error=$(___get_venv_activate_path $venv_name 2>&1)
    activate_code=$?
    case "$activate_code" in
        0)
            local need_new_venv
            if [ -n "$python_ver" ]; then
                local print_name=$(printf "%s" "$activate_error" | cut -z -d: -f2 | tr -d '\0')
                local activate_path=$(printf "%s" "$activate_error" | cut -z -d: -f1 | tr -d '\0')
                if [ $(wc -l <<< "$print_name") -ne 1 ]; then
                    venv_name=$(grep -F "$python_ver" <<< "$print_name")
                    if [ -z "$venv_name" ] || [ $(wc -l <<< "$venv_name") -ne 1 ]; then
                        venv_name=
                        local old_ifs=$IFS
                        local a_path
                        IFS=$'\n'
                        for a_path in $(sed 's|/[^/]*$||' <<< "$activate_path"); do
                            if [ -f "$a_path/python$python_ver" ]; then
                                if [ -z "$venv_name" ]; then
                                    venv_name=$(sed -E 's|^(\./)?([^/]*).*$|\2|g' <<< "$a_path")
                                else
                                    # multiple matches for this version found, fall back to `select`
                                    venv_name=
                                    break
                                fi
                            fi
                        done
                        IFS=$old_ifs
                    fi
                else
                    [ -f "$(dirname "$activate_path")/python$python_ver" ] || { need_new_venv=1; }
                fi
            fi
            if [ -z "$need_new_venv" ]; then
                activate $venv_name
                return 0
            fi
            ;;
        2) ;;
        3) ;;
        *) echo "$activate_error"; return "$activate_code" ;;
    esac

    [ -z "$venv_name" ] && venv_name=venv
    venv_name=$venv_name$python_ver

    [ -f "$venv_name/bin/activate" ] || "python$python_ver" -m venv "$venv_name"
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
    local old_ifs=$IFS
    IFS=""

    activate_path=$(printf "%s" "$path_print_name" | cut -z -d: -f1 | tr -d '\0')
    print_name=$(printf "%s" "$path_print_name" | cut -z -d: -f2 | tr -d '\0')

    if [ "$(wc -l <<< "$activate_path")" -ne 1 ]; then
        echo "Multiple candidate virtual environments found:" 1>&2
        local path_list
        local old_ps3=$PS3
        local selected
        IFS=$'\n'
        PS3="Virtual environment: "
        path_list=($(<<< "$print_name"))
        select venv in "${path_list[@]}"; do
            if [ -z "$venv" ]; then
                break
            fi
            selected=1
            print_name=$venv
            activate_path=$print_name/bin/activate
            break
        done
        IFS=$old_ifs
        PS3=$old_ps3
        if [ -z "$selected" ]; then
            echo "Not selecting a virtual environment" 1>&2; 
            return 4
        fi
    fi

    echo "Activating ($print_name) virtual environment"
    . "$activate_path"

    if [ -n "$ZSH_VERSION" ]; then 
        rehash # zsh needs to explicitly update PATH cache
    fi
    IFS=$old_ifs
}

alias bpy='bpython'
