#!/bin/sh

function reload() {
    shell=${ZSHRC_SHELL:-$SHELL}
    mybin-event abort
    exec $shell
}
