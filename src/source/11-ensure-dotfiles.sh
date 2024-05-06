#!/bin/sh

_dotfiles_repo="https://github.com/s3i7h/yadm.git"
_dotfiles_branch="v1"

_install_yadm() {
    platform=$(mybin-platform)
    case ":${platform}:" in
	*:debian:*)
	    command=(sudo apt install yadm)
	    echo '> '"${command[@]}"
	    "${command[@]}"
	    ;;
	*:macos:*)
	    command=(brew install yadm)
	    echo '> '"${command[@]}"
	    "${command[@]}"
	    ;;
	*)
	    echo "installation method for ${platform} not found"
	    return 1
	    ;;
    esac
}

_ensure_dotfiles() {
    case $VIRTUAL_HOME in
	$Z4H*)
	    if [ ! -d "$VIRTUAL_HOME/.git" ]; then
		(
		    cd $VIRTUAL_HOME
		    echo "overlaying yadm at $VIRTUAL_HOME"
		    git overlay $_dotfiles_repo -b $_dotfiles_branch
		) || return $?
		echo "reloading shell..."
		reload
	    fi
	    echo "cd \$VIRTUAL_HOME; git pull" | defer
	    ;;
	*)
	    if ! command_exists yadm; then
		echo -n "yadm not found. install? (Y/n):"
		read answer
		answer=$(echo ${answer:-y} | tr '[A-Z]' '[a-z]')
		if [ "$answer" != "y" ]; then
		    echo "skipping yadm. personal settings may not be available"
		    return
		fi
		_install_yadm || return $?
	    fi
	    if [ ! -d "$XDG_DATA_HOME/yadm/repo.git" ]; then
		yadm clone $_dotfiles_repo -b $_dotfiles_branch || return $?
		echo "reloading shell..."
		reload
	    fi
	    echo "yadm pull" | defer
	    ;;
    esac
}


_ensure_dotfiles
unset -v _dotfiles_repo
unset -v _dotfiles_branch
unset -f _install_yadm
unset -f _ensure_dotfiles
