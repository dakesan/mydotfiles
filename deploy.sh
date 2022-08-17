#!/bin/bash

dotfiles=(.zshrc .condarc .zshenv .zshfunc)

for file in "${dotfiles[@]}"; do
	ln -svf ~/dotfiles/$file ~/
done

ln -svf ~/dotfiles/.config/nvim ~/.config/nvim

