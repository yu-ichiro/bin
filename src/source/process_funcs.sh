#!/bin/sh
# define functions to display informations about a process
function ppid() {
    pid=${1:-$$}
    ps -p $pid -o ppid= | sed -E 's/\s//g'
}

function pcomm() {
    pid=${1:-$$}
    ps -p $pid -o comm=
}

function rppid() {
    pid=${1:-$$}
    while true; do
        echo $pid $(pcomm $pid)
        pid=$(ppid $pid 2>/dev/null)
        [ $pid != "" -a $pid != 0 ] || break
    done
}

