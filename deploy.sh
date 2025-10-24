#!/usr/bin/env bash
set -euo pipefail

# Always resolve the repository root relative to this script so we can run it from anywhere.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
	local src_relative="$1"
	local dst_relative="$2"
	local src_path="$DOTFILES_DIR/$src_relative"
	local dst_path="$HOME/$dst_relative"

	if [[ ! -e "$src_path" && ! -L "$src_path" ]]; then
		printf 'missing source: %s\n' "$src_path" >&2
		return 1
	fi

	mkdir -p "$(dirname "$dst_path")"
	ln -snfv "$src_path" "$dst_path"
}

dotfiles=(.zshrc .bashrc .condarc .zshenv .zshfunc)
for path in "${dotfiles[@]}"; do
	link "$path" "$path"
done

while IFS=: read -r src dst; do
	[[ -z "$src" ]] && continue
	link "$src" "$dst"
done <<'EOF'
.config/config.fish:.config/fish/config.fish
.config/tmux.fish:.config/fish/tmux.fish
.config/dotenv.fish:.config/fish/dotenv.fish
.config/starship.toml:.config/starship.toml
.config/procs/config.toml:.config/procs/config.toml
.config/mise/config.toml:.config/mise/config.toml
.sheldon/plugins.toml:.sheldon/plugins.toml
.sheldon/plugins.toml:.config/sheldon/plugins.toml
.config/nvim:.config/nvim
.config/vim:.config/vim
.config/zellij:.config/zellij
.config/yazi:.config/yazi
.config/bat:.config/bat
.config/tmux:.config/tmux
oh-my-posh/snitch_custom.omp.json:.poshthemes/snitch_custom.omp.json
oh-my-posh/snitch_custom_home.omp.json:.poshthemes/snitch_custom_home.omp.json
oh-my-posh/snitch_custom_work.omp.json:.poshthemes/snitch_custom_work.omp.json
EOF
