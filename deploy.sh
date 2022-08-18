#!/bin/bash

dotfiles=(.zshrc .condarc .zshenv .zshfunc)

for file in "${dotfiles[@]}"; do
	ln -svf $HOME/dotfiles/$file $HOME/
done

rm -rf $HOME/.config/nvim
unlink $HOME/.config/nvim
ln -svf $HOME/dotfiles/.config/nvim $HOME/.config/nvim

mkdir -p $HOME/.config/procs
ln -svf $HOME/dotfiles/.config/procs/config.toml $HOME/.config/procs/config.toml

mkdir -p $HOME/.sheldon
ln -svf $HOME/dotfiles/.sheldon/plugins.toml $HOME/.sheldon/plugins.toml
ln -svf $HOME/dotfiles/.sheldon/plugins.toml $HOME/.config/sheldon/plugins.toml

mkdir -p $HOME/.config/zellij
ln -svf $HOME/dotfiles/.config/zellij/config.yaml $HOME/.config/zellij/config.yaml

ln -svf $HOME/dotfiles/oh-my-posh/snitch_custom.omp.json $HOME/.poshthemes/snitch_custom.omp.json
ln -svf $HOME/dotfiles/oh-my-posh/snitch_custom_home.omp.json $HOME/.poshthemes/snitch_custom_home.omp.json
ln -svf $HOME/dotfiles/oh-my-posh/snitch_custom_work.omp.json $HOME/.poshthemes/snitch_custom_work.omp.json
