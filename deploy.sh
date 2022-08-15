#!/bin/bash

dotfiles=(.zshrc .condarc .zshenv)

for file in "${dotfiles[@]}"; do
	ln -svf ~/dotfiles/$file ~/
done
