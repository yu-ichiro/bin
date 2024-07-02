#!/usr/bin/env bash

export HOMEBREW_HOME="${XDG_DATA_HOME:-$VIRTUAL_HOME/.local/share}/brew"
export HOMEBREW_CASK_OPTS="--appdir=${HOMEBREW_HOME}/app --caskroom=${HOMEBREW_HOME}/caskroom"
