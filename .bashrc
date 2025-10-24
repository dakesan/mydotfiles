#!/usr/bin/env bash

# PATH configuration
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/share/pypoetry/venv/bin:$PATH"
export PATH="$HOME/.fly/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.config/claude/bin:$PATH"
export PATH="/usr/local/cuda-12.4/bin:$PATH"

# Environment variables
export FLYCTL_INSTALL="$HOME/.fly"
export BNB_CUDA_VERSION=124
export LD_LIBRARY_PATH="/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH"

# pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
fi

# bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# ghcup-env
if [ -f "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

# Conda/Mamba initialization
init_conda() {
    local conda_paths=(
        "$HOME/micromamba"
        "$HOME/mambaforge"
        "$HOME/.local/share/miniconda3"
        "$HOME/miniconda3"
        "$HOME/.pyenv/versions/miniconda3-latest"
        "/opt/miniconda3"
        "/opt/conda"
    )
    
    for conda_path in "${conda_paths[@]}"; do
        if [ -d "$conda_path" ]; then
            if [ -f "$conda_path/etc/profile.d/conda.sh" ]; then
                . "$conda_path/etc/profile.d/conda.sh"
            elif [ -f "$conda_path/etc/profile.d/mamba.sh" ]; then
                . "$conda_path/etc/profile.d/mamba.sh"
            fi
            
            if [ -f "$conda_path/bin/conda" ]; then
                eval "$("$conda_path/bin/conda" shell.bash hook)"
            fi
            break
        fi
    done
}

init_conda

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
