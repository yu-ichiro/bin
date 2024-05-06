#!/bin/sh

_ensure_brew() {
	echo -n "brew not found. install now? (Y/n): "
	read answer
	answer=$(echo ${answer:-y} | tr '[A-Z]' '[a-z]')
	if [ "$answer" != "y" ]; then
	    echo "Skipping brew. To supress this check, add the following line to $ZDOTDIR/.env.zsh"
	    echo
	    echo "export ZSHRC_MODE="'$(( ZSHRC_MODE | ZSHRC_MODE_NO_BREW ))'
	    echo
	    return
	fi
	echo "Installing brew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "Restarting shell..."
	exec $SHELL -i
}    

zshrc_flag_check $ZSHRC_MODE $ZSHRC_MODE_NO_BREW || command_exists brew || _ensure_brew
unset -f _ensure_brew
