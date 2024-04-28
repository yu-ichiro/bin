#!/bin/sh
# clone/pull git-gone

export GITGONE_URL=https://github.com/eed3si9n/git-gone
export GITGONE_DIR=$VCS_HOME/${GITGONE_URL#https://}

cmd=(defer)
# cmd=($SHELL)
"$cmd[@]" <<EOF
    if [ ! -d "\$GITGONE_DIR" ]; then
	echo -n "Cloning git-gone..."
	>/dev/null 2>&1 git clone \$GITGONE_URL \$GITGONE_DIR
	echo "done"
    fi
    cd \$GITGONE_DIR
    echo -n "Updating git-gone..."
    >/dev/null 2>&1 git pull
    echo "done"
    ln -sf \$PWD/git-gone \$MYBIN_PATH/bin/git-gone
    ls \$MYBIN_PATH/bin
EOF

unset -v GITGONE_URL
unset -v GITGONE_DIR
