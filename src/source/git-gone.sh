#!/bin/sh
# clone/pull git-gone

defer << EOF
    source <(ghr shell bash)
    ghr clone --cd github.com:eed3si9n/git-gone
    git pull
    ln -sf \$PWD/git-gone \$MYBIN_PATH/bin/git-gone
EOF
