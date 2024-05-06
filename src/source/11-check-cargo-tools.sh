#!/bin/sh

_check_cargo_tools () {
    cargo_installs="$(cargo install --list | grep : )"
    cargo_tools=(ghr fd-find xsv bat eza)
    for tool in $cargo_tools; do
	if ! ( echo "$cargo_installs" | grep "$tool" >/dev/null ) ; then
	    echo -n "$tool not found. would you like to install with cargo? (Y/n): "
	    read answer
	    answer=$(echo ${answer:-y} | tr '[A-Z]' '[a-z]')
	    [ "$answer" != "y" ] && continue
	    echo -n "cargo install $tool |"
	    cargo install $tool 2>&1 1>/dev/null | nlprogress
	    echo "| done"
	fi
    done
}

zshrc_flag_check $ZSHRC_MODE $ZSHRC_MODE_DEVELOP && _check_cargo_tools
unset -f _check_cargo_tools
