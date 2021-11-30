#!/bin/sh

install_ubuntu() {
	sudo apt-add-repository ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt install neovim
}

mkdir -p undodir
[ ! -f lib_plug/servers.lua ] && echo "
-- edit the line bellow eg:
-- local servers = { 'gopls', 'yamlls', 'tsserver', 'bashls' }
local servers = {}
return servers
" > lib_plug/servers.lua

nvim -u lib/plug.vim -c ":PlugInstall|:qa!"
