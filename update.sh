#!/bin/bash

# Prefix data and color for every command.
PS4='\033[1;31m$(date +%H:%M:%S)\033[0m '
set -exo pipefail

# Pull the latest changes and update submodules.
git pull && git submodule update --init --recursive --remote

# Keep track on master.
# https://stackoverflow.com/a/18799234/4562968
# git submodule foreach -q --recursive 'echo $name; git switch $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master) && git pull'
# Resolve each branch inside foreach, where $toplevel is the parent repo (after
# cd-ing into the submodule, `git rev-parse --show-toplevel` is the submodule).
git submodule foreach -q --recursive 'echo "$displaypath" "$(git config -f "$toplevel/.gitmodules" submodule."$name".branch || echo master)"' | xargs -P10 -n2 bash -c 'echo "Updating $1 ($2) ..." && cd "$1" && git switch "$2" && git pull' bash

# Record updated submodule pointers so they don't show as dirty
git add -A && git diff-index --quiet HEAD || git commit -m "update submodules"

