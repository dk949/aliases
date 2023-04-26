rsync___() {
    if [ -f ./.rsyncignore ]; then
        \rsync  $(awk '{print "--exclude " $0}' .rsyncignore) "$@"
    else
        \rsync "$@"
    fi
}


alias rsync='rsync___'
