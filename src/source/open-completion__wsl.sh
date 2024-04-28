#!/usr/bin/env sh
# define completion for `open` and `xdg-open`
function _open {
  _files
  return 1;
}

mybin-event hook completion compdef _open open
mybin-event hook completion compdef _open xdg-open
