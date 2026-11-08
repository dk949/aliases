#!/bin/sh

# locate aliases
if [[ $OSTYPE == linux* ]]; then
    alias loc='locate -Aebi'
fi
