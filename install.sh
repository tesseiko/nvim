#!/bin/sh

function install_ubuntu() {
	sudo apt-add-repository ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt install neovim
}

mkdir -p undodir
nvim -u lib/plug.vim -c ":PlugInstall|:qa!"
