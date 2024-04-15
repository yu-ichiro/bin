#!/bin/sh
# define `git` function to exec `git-func` for `git func
function git() {
    local subcommand
    subcommand="git-$1"

    if typeset -f $subcommand >/dev/null; then
        shift 1
        eval $subcommand "$@"
    else
        command git "$@"
    fi
}

# define `git-cd` function that cds to a directory relative to `git-root`
function git-cd() {
    local gitroot
    gitroot=$(git root)
    ( exit $? ) || return $?
    if [ "$1" != "" ]; then
        cd $gitroot/$1
    else
        cd $gitroot
    fi
}
