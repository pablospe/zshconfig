#!/bin/bash

# Prefix data and color for every command.
PS4='\033[1;31m$(date +%H:%M:%S)\033[0m '
set -exo pipefail

# Pull the latest changes and update submodules.
git pull && git submodule update --init --recursive --remote

# Keep track on master.
# https://stackoverflow.com/a/18799234/4562968
git submodule foreach -q --recursive 'echo $name; git switch $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master) && git pull'
