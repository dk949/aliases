# Output format for zsh's builtin `time`.
# %E/%U/%S print seconds with an "s" suffix. %M is ru_maxrss / 1024, which is
# megabytes on Linux (ru_maxrss is in KB) but kilobytes on macOS (it is in bytes).
if [[ $OSTYPE == darwin* ]]; then
    TIMEFMT='Real: %E, User: %U, Sys: %S, Mem: %MK, CPU: %P'
else
    TIMEFMT='Real: %E, User: %U, Sys: %S, Mem: %MM, CPU: %P'
fi
