# mybin

make your personal bin/source portable

# installation

1. clone this repo
2. add to your shell's rc file
```
MYBIN_PATH=path/to/clone
PATH=$PATH:$MYBIN_PATH/bin
mybin-bootstrap-bin
source <(mybin-bootstrap-source)
```

# adding new bin/source

add files to src/

the folders are categorized as:

`(arch)/(kernel)/(os)` for bins
`(arch)/(kernel)/(os)/(shell)` for sources

`_any` is a special name for each field and it will be loaded regardless of the platform.

e.g. `_any/linux/wsl` is for wsl specific but agnostic of architecture

the behavior of detecting platforms can be changed by modifing bin/mybin-platform

# use me as a template

this repo has my own scripts/bins/sources in it. suggestions are welcomed but modifications are preferrably done on your own repo. use this repo as a template and create your own :)


