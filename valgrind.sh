#!/bin/sh

findleak(){
    mkdir -p valgrind-logs
    eval 'valgrind '\
        '--leak-check=full '\
        '--track-origins=yes ' \
        '--show-leak-kinds=all ' \
        '--num-callers=15 ' \
        '--log-file=./valgrind-logs/valgrind-out.txt '\
        "$*"
}

