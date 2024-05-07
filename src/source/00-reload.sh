#!/bin/sh

function _cleanup_exec_shell() {
    shell=${1:-$SHELL}
    mybin-event abort
    exec $shell -i
}

alias reload='_cleanup_exec_shell $0'
