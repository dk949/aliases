#!/bin/sh

findleak(){
    mkdir -p valgrind-logs
        #'--verbose '\
        #'--track-origins=yes' \
    eval 'valgrind '\
        '--leak-check=full '\
        '--show-leak-kinds=all' \
        '--log-file=./valgrind-logs/valgrind-out.txt '\
        "$*"
}

