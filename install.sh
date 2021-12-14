#!/bin/sh

install_ubuntu() {
	sudo apt-add-repository ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt install neovim
}

local_install() {
	mkdir -p undodir
	[ ! -f lib_plug/servers.lua ] && echo "
	-- edit the line bellow eg:
	-- local servers = { 'gopls', 'yamlls', 'tsserver', 'bashls' }
	local servers = {}
	return servers
	" > lib_plug/servers.lua

	nvim -u lib/plug.vim -c ":PlugInstall|:qa!"
}

if [ $# -eq 1 ]; then
	if [ $1 = "install-ubuntu" ]; then
		install_ubuntu
		local_install
		exit 0
	else
		echo "$0 [help|install-ubuntu]"
		exit 0
	fi
else
	echo "$0 [help|install-ubuntu]"
	exit 0
fi

local_install
