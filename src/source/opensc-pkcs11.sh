#!/usr/bin/env bash

if command_exists opensc-tool; then
    opensc_home=$(which opensc-tool | sed -E 's/\/bin\/opensc-tool//')
    if [ -f $opensc_home/lib/opensc-pkcs11.so ]; then
	ln -sf $opensc_home/lib/opensc-pkcs11.so $XDG_LOCAL_LIB/opensc-pkcs11.so
	export SSH_COMMAND="${SSH_COMMAND} -I $XDG_LOCAL_LIB/opensc-pkcs11.so"
    fi
fi
