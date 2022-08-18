#!/bin/bash

dotfiles=(.zshrc .condarc .zshenv .zshfunc)

for file in "${dotfiles[@]}"; do
	ln -svf $HOME/dotfiles/$file $HOME/
done

rm -rf $HOME/.config/nvim
unlink $HOME/.config/nvim
ln -svf $HOME/dotfiles/.config/nvim $HOME/.config/nvim

mkdir $HOME/.config/procs
ln -svf $HOME/dotfiles/.config/procs/config.toml $HOME/.config/procs/config.toml

mkdir $HOME/.sheldon
ln -svf $HOME/dotfiles/.sheldon/plugins.toml $HOME/.sheldon/plugins.toml
ln -svf $HOME/dotfiles/.sheldon/plugins.toml $HOME/.config/sheldon/plugins.toml
