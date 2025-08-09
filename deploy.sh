#!/bin/env bash

distro=$(grep -o "Debian\|Arch" /etc/os-release | uniq)

if [[ $distro == "Debian" ]]; then
	sudo apt install -y neovim clangd bear
elif [[ $distro == "Arch" ]]; then
	sudo pacman -S --noconfirm --needed neovim clang bear
fi

ln -s $(pwd)/nvim $HOME/.config/nvim
