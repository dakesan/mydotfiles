#!/usr/bin/env bash
set -euo pipefail

# Resolve repository root relative to this script so it works from anywhere
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Home-level files
mkdir -p "$HOME"
ln -sfnv "$DOTFILES_DIR/.zshrc"   "$HOME/.zshrc"
ln -sfnv "$DOTFILES_DIR/.bashrc"  "$HOME/.bashrc"
ln -sfnv "$DOTFILES_DIR/.condarc" "$HOME/.condarc"
ln -sfnv "$DOTFILES_DIR/.zshenv"  "$HOME/.zshenv"
ln -sfnv "$DOTFILES_DIR/.zshfunc" "$HOME/.zshfunc"

# fish shell configs
mkdir -p "$HOME/.config/fish"
ln -sfnv "$DOTFILES_DIR/.config/config.fish" "$HOME/.config/fish/config.fish"
ln -sfnv "$DOTFILES_DIR/.config/tmux.fish"   "$HOME/.config/fish/tmux.fish"
ln -sfnv "$DOTFILES_DIR/.config/dotenv.fish" "$HOME/.config/fish/dotenv.fish"

# starship and other configs
mkdir -p "$HOME/.config"
ln -sfnv "$DOTFILES_DIR/.config/starship.toml"       "$HOME/.config/starship.toml"

# procs
mkdir -p "$HOME/.config/procs"
ln -sfnv "$DOTFILES_DIR/.config/procs/config.toml"    "$HOME/.config/procs/config.toml"

# mise
mkdir -p "$HOME/.config/mise"
ln -sfnv "$DOTFILES_DIR/.config/mise/config.toml"     "$HOME/.config/mise/config.toml"

# sheldon
mkdir -p "$HOME/.sheldon"
ln -sfnv "$DOTFILES_DIR/.sheldon/plugins.toml"        "$HOME/.sheldon/plugins.toml"
mkdir -p "$HOME/.config/sheldon"
ln -sfnv "$DOTFILES_DIR/.sheldon/plugins.toml"        "$HOME/.config/sheldon/plugins.toml"

# app configs
mkdir -p "$HOME/.config"
ln -sfnv "$DOTFILES_DIR/.config/nvim"   "$HOME/.config/nvim"
ln -sfnv "$DOTFILES_DIR/.config/vim"    "$HOME/.config/vim"
ln -sfnv "$DOTFILES_DIR/.config/zellij" "$HOME/.config/zellij"
ln -sfnv "$DOTFILES_DIR/.config/yazi"   "$HOME/.config/yazi"
ln -sfnv "$DOTFILES_DIR/.config/bat"    "$HOME/.config/bat"
ln -sfnv "$DOTFILES_DIR/.config/tmux"   "$HOME/.config/tmux"

# oh-my-posh themes
mkdir -p "$HOME/.poshthemes"
ln -sfnv "$DOTFILES_DIR/oh-my-posh/snitch_custom.omp.json"       "$HOME/.poshthemes/snitch_custom.omp.json"
ln -sfnv "$DOTFILES_DIR/oh-my-posh/snitch_custom_home.omp.json"  "$HOME/.poshthemes/snitch_custom_home.omp.json"
ln -sfnv "$DOTFILES_DIR/oh-my-posh/snitch_custom_work.omp.json"  "$HOME/.poshthemes/snitch_custom_work.omp.json"
