#!/usr/bin/env sh
# define functions to explicitly load Windows PATH

# Add a function to get PATHs set on Windows host-side
function get-winpath () {
    /mnt/c/Windows/system32/cmd.exe /c powershell.exe -command 'echo $env:PATH' 2>/dev/null | tr ';' '\n' | sed -E 's/\\/\\\\/g' | xargs -I{} wslpath -au '{}' 
}

# Add a function to export Windows PATH to PATH
function load-winpath() {
    OIFS=$IFS
    IFS=$'\n'
    export PATH=$PATH:
    for _path in $(get-winpath); do
        export PATH=${PATH//$_path:}:$_path    
    done
    export PATH=${PATH//::/:}
    IFS=$OIFS
}

# explicitly load Windows PATH
load-winpath
