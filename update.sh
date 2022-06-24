#!/bin/sh

# Pull the latest changes and update submodules
git pull && git submodule update --init --recursive --remote
