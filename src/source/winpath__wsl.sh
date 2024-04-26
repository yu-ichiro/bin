#!/bin/bash
# define functions to explicitly load Windows PATH

# Add a function to get PATHs set on Windows host-side
function get-winpath () {
    /mnt/c/Windows/system32/cmd.exe /c powershell.exe -command 'echo $env:PATH' 2>/dev/null | tr ';' '\n' | sed -E 's/\\/\\\\/g' | xargs -I{} wslpath -au '{}' | tr -d $'\r' 
}

# Add a function to export Windows PATH to PATH
function load-winpath() {
    _debug_file=${_debug_file:-/dev/null}
    OIFS=$IFS
    IFS=$'\n'
    # test last letter if it's a colon
    if [ "${PATH: -1}" != ":" ]; then
        export PATH=$PATH:
        colon_added=true
    else
        colon_added=false
    fi

    for _path in $(get-winpath); do
        echo -n "$_path: " > $_debug_file
        case $PATH in
            *$_path:*)
                case $_path in
                    /mnt/c/*)
                        echo "move to last" > $_debug_file
                        export PATH=${PATH//$_path:/}$_path: ;;
                    *)
                        echo "keep untouched" > $_debug_file
                        ;;
                esac ;;
            *)
                echo "add new path" > $_debug_file
                export PATH=$PATH$_path: ;;
        esac
        echo $(echo $PATH | tr ':' '\n' | wc -l) $PATH > $_debug_file
        echo ---- > $_debug_file
    done

    if $colon_added; then
        export PATH=${PATH%:}
    fi

    IFS=$OIFS
}
