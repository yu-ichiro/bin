#!/usr/bin/env sh
# define completion for `open` and `xdg-open`
function _open_completion {
  _files
  return 1;
}

compdef _open_completion open
compdef _open_completion xdg-open
