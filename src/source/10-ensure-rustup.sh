#!/bin/sh

function _ensure_rustup() {
	echo -n "ZSHRC_MODE includes DEVELOP but rustup was not found. install now? (Y/n): "
	read answer
	answer=$(echo ${answer:-y} | tr '[A-Z]' '[a-z]')
	if [ "$answer" != "y" ]; then
	    echo "Skipping rustup installation for now. rust-dependent tools will not be available"
	    return
	fi
	echo "Installing rustup..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
	echo "Restarting shell..."
	exec $SHELL -i
}    

zshrc_flag_check $ZSHRC_MODE $ZSHRC_MODE_DEVELOP && ! command_exists rustup && _ensure_rustup
unset -f _ensure_rustup
