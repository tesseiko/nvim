#!/bin/sh

mkdir -p undodir
nvim -u lib/plug.vim -c ":PlugInstall|:qa!"
