#!/bin/sh
# define `defer` function that defers execution of script asyncronously

function defer() {
    ( nohup $SHELL "$@" >/dev/null 2>&1 & )
}
