#!/bin/bash

dotfiles=(.zshrc .condarc .zshenv .zshfunc)

for file in "${dotfiles[@]}"; do
	ln -svf $HOME/dotfiles/$file $HOME/
done

mkdir $HOME/.config

rm $HOME/.config/fish/config.fish
ln -svf $HOME/dotfiles/.config/config.fish $HOME/.config/fish/
ln -svf $HOME/dotfiles/.config/starship.toml $HOME/.config/

rm -rf $HOME/.config/nvim
unlink $HOME/.config/nvim
ln -svf $HOME/dotfiles/.config/nvim $HOME/.config/nvim

rm -rf $HOME/.config/vim
unlink $HOME/.config/vim
ln -svf $HOME/dotfiles/.config/vim $HOME/.config/vim

mkdir -p $HOME/.config/procs
ln -svf $HOME/dotfiles/.config/procs/config.toml $HOME/.config/procs/config.toml

mkdir -p $HOME/.sheldon
mkdir -p $HOME/.config/sheldon
ln -svf $HOME/dotfiles/.sheldon/plugins.toml $HOME/.sheldon/plugins.toml
ln -svf $HOME/dotfiles/.sheldon/plugins.toml $HOME/.config/sheldon/plugins.toml

rm -rf $HOME/.config/zellij
unlink $HOME/.config/zellij
ln -svf $HOME/dotfiles/.config/zellij $HOME/.config/zellij

rm -rf $HOME/.config/yazi
unlink $HOME/.config/yazi
ln -svf $HOME/dotfiles/.config/yazi $HOME/.config/yazi

rm -rf $HOME/.config/bat
unlink $HOME/.config/bat
ln -svf $HOME/dotfiles/.config/bat $HOME/.config/bat

mkdir $HOME/.poshthemes
ln -svf $HOME/dotfiles/oh-my-posh/snitch_custom.omp.json $HOME/.poshthemes/snitch_custom.omp.json
ln -svf $HOME/dotfiles/oh-my-posh/snitch_custom_home.omp.json $HOME/.poshthemes/snitch_custom_home.omp.json
ln -svf $HOME/dotfiles/oh-my-posh/snitch_custom_work.omp.json $HOME/.poshthemes/snitch_custom_work.omp.json

rm -rf $HOME/.config/tmux
unlink $HOME/.config/tmux
ln -svf $HOME/dotfiles/.config/tmux $HOME/.config/tmux
