#!/bin/bash

dotfiles=(.zshrc .condarc .zshenv .zshfunc)

for file in "${dotfiles[@]}"; do
	ln -svf ~/dotfiles/$file ~/
done

ln -svf ~/dotfiles/.config/nvim ~/.config/nvim

mkdir ~/.config/procs
ln -svf ~/dotfiles/.config/procs/config.toml ~/.config/procs/config.toml

mkdir ~/.sheldon
ln -svf ~/dotfiles/.sheldon/plugins.toml ~/.sheldon/plugins.toml
ln -svf ~/dotfiles/.sheldon/plugins.toml ~/.config/sheldon/plugins.toml
