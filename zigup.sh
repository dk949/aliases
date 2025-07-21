zigup() {
    for VER in "$@"; do :; done
    /usr/bin/zigup --install-dir ~/.cache/zigup --path-link ~/.local/bin/zig "$@" || return
    case $VER in list|--help) unset VER;return; ;;
    esac
    if [ -d "$XDG_CACHE_HOME/zigup/zls" ]; then
        if [ -f "$XDG_CACHE_HOME/zigup/zls/zls-$VER" ]; then
            ln -sf "$XDG_CACHE_HOME/zigup/zls/zls-$VER" "$XDG_DATA_HOME/../bin/zls"
        else
            echo "WARN: no zls built for version $VER"
        fi
    else
        echo "WARN: no zls versions found"
    fi
    unset VER
}
