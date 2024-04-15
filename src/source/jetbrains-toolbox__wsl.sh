#!/bin/sh
# create commands that invoke JetBrains/Toolbox generated .cmd files

toolbox_scripts_path=$(echo $PATH | tr ':' '\n' | grep -E 'JetBrains/Toolbox/scripts')
if [ "$MYBIN_PATH" != "" -a "$toolbox_scripts_path" != "" ]; then
    cmds=($(ls $toolbox_scripts_path | sed -E 's/\.cmd//'))
    for cmd in "$cmds[@]"; do
        cat << EOF > $MYBIN_PATH/bin/$cmd && chmod +x $MYBIN_PATH/bin/$cmd
#!/usr/bin/env bash
# generated automatically from $MYBIN_PATH/bin/mybin-bootstrap-source
LINUXPATH=\${PATH} WSLENV=\${WSLENV%:}:LINUXPATH/lw powershell.exe << EOC >/dev/null 2>&1 &
\\\$env:PATH = \\\$env:PATH + \\\$env:LINUXPATH
$cmd \$(for param in "\$@"; do echo \$(wslpath -aw \$param) ' '; done)
EOC
EOF
    done
fi
