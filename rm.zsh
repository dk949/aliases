#!/bin/sh


if (( EUID == 0 )); then
    alias rm='rm -i'
fi
