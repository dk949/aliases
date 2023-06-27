#!/bin/sh


if [ "$(id -u)" = "0" ]; then
    alias rm='rm -i'
fi
