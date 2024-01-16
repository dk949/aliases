zigup() {
    for VER in "$@"; do :; done
    /opt/zigup/zigup --install-dir ~/.cache/zigup --path-link ~/.local/bin/zig "$@" || return
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
