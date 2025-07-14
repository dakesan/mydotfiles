#* zsh speed checker
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

#* custom functions
source $HOME/dotfiles/.zsh/.zshfunc
# if hostname contains "DESKTOP" -> my home desktop
# else if contains "hpc" -> hpc cluster machine
# else -> WTH?
if [[ "$HOST" =~ "^DESKTOP-DLL*" ]]; then
  source ~/dotfiles/.zsh/.zshhome
  source $HOME/dotfiles/.zsh/hpcfunctions.zsh
  useproxy
elif [[ "$HOST" =~ "^hpc*" ]]; then
  source ~/dotfiles/.zsh/.zshwork
  source $HOME/dotfiles/proxy/proxy_adress.zsh
  source $HOME/dotfiles/.zsh/hpcfunctions.zsh
elif [[ "$HOST" =~ "^ip*" ]]; then
  source ~/dotfiles/.zsh/.zshaws
elif [[ "$HOST" =~ "^hodake*" ]]; then
  source ~/dotfiles/.zsh/.zshhome
else
  source ~/dotfiles/.zsh/.zshhome;
fi

#* Path configuration
path_append "$HOME/.local/bin"
path_append "/usr/local/bin"
path_append "/usr/bin"
path_append "$HOME/.cargo/bin"
path_append "$HOME/go/bin"
path_append "$HOME/.local/share/pypoetry/venv/bin"
path_append "$HOME/.local/share/bob/nvim-bin"
path_append "$HOME/.fly/bin"
path_append "$HOME/.deno/bin"
path_append "$HOME/.config/claude/bin"
path_append "/usr/local/cuda-12.4/bin"

#* Util command
alias pwdc='pwd | tr -d "\n" | pbcopy'
alias pi="pip install"
alias ai="sudo apt install"

#* axel
alias Axel="axel -n 10 --insecure"

#* Zellij
alias zl="zellij list-sessions"
alias zelij=zellij

#* Prompt
# disable showing conda environment on prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
# posh theme
eval "$(oh-my-posh init zsh --config $poshpath)"
# eval "$(starship init zsh)"
#* zoxide
eval "$(zoxide init zsh)"
alias z="pushd ./ && z"
alias ..="cd .."
alias ...="cd ../.."

#* NeoVim
# open man with vim
export MANPAGER="nvim -c 'set ft=man' -"
export EDITOR='nvim'
# alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimconfig='cd ~/.config/nvim && $EDITOR .'

#* Python
alias ipo="ipython"

#* Zsh configuration
# alias
alias zshconfig="vim $HOME/dotfiles/.zshrc"
alias reload="exec zsh"
# settings
### beep
setopt no_beep
### bracket
setopt auto_param_keys
### color
#? colors has gone to sheldon
# autoload -Uz colors && colors
### autocomplete
#? compinit has gone to sheldon
# autoload -Uz compinit && compinit -C
setopt magic_equal_subst
### word select per slash
autoload -U select-word-style
select-word-style bash
### share history
setopt histignorealldups
setopt sharehistory
setopt hist_no_store
setopt hist_ignore_space
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
LISTMAX=1000
### move without cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
### auto correct ###
# setopt correct
### key binding ###
bindkey '^[[1;5C' forward-word #? Ctrl + ->
bindkey '^[[1;5D' backward-word #? Crtl + <-
bindkey  '^[[H'   beginning-of-line #? Home
bindkey  '^[[F'   end-of-line #? End
bindkey  '^[[3~'  delete-char #? Delete
bindkey '^I'   complete-word #? tab complete
bindkey '^E' end-of-line #? Ctrl + e = End
bindkey '^q' push-line-or-edit
bindkey '^x' push-line-or-edit
### glob
setopt extended_glob
### wdchar
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#* Git
alias gp='git pull'
alias gP='git push'
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status -sb'
alias gb='git branch'
alias gl='git log --oneline --graph --decorate'
alias gC='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='git restore'
alias grs='git restore --staged'
alias gR='git reset'
alias gRh='git reset --hard'
alias gst='git stash'
alias gstp='git stash pop'
alias gf='git fetch'
alias gm='git merge'
alias grb='git rebase'
alias gcl='git clone'
alias gco='git checkout -b'
alias gsh='git show'
alias gbl='git blame'
alias gcp='git cherry-pick'
alias grv='git revert'
alias gtag='git tag'
alias gclean='git clean -fd'
alias gwt='git worktree'
alias gbs='git bisect'
alias grm='git remote'
alias grmv='git remote -v'
alias glp='git log -p'
alias glg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gsu='git submodule update --init --recursive'
# lazygit
alias lg='lazygit'

#* tmux
alias tmux="tmux -f $HOME/.config/tmux/tmux.conf"
alias t="tmux"
alias ta="tmux a"
alias ts="tmux new -s"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
alias tka="tmux kill-server"

#* Claude
alias yolo='claude code -A -w -n'
alias yolor='claude code --resume'
alias clauder='claude code --resume'

#* Other tools
alias conda='micromamba'
alias mamba='micromamba'
# git path
function gitroot(){
  export git_root=$(git rev-parse --show-toplevel)
  echo $git_root
}

function gitmain() {
  git config --global user.email "naitomeaFunLIve@gmail.com"
  git config --global user.name "oodakehideto"
  echo "git email : naitomeaFunLIve@gmail.com"
  echo "git name  : oodakehideto"
}

function gitsub() {
  git config --global user.email "hideto.odake@openlogi.com"
  git config --global user.name "hodake-openlogi"
  echo "git email : hideto.odake@openlogi.com"
  echo "git name  : hodake-openlogi"
}

function gitreverse() {
  if [ -z "$1" ]; then
    echo "Usage: gitreverse <commit-hash>"
    return 1
  fi
  git diff "$1"^ "$1" | git apply
}

function gitpub() {
  local comment="$@"
  git add . && git commit -m "$comment" && git push
}


#* R/Python/SQL
# alias sl="sqlite3"

#* eza (modern ls replacement)
if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias ll='eza -lh --icons'
    alias la='eza -a --icons'
    alias lla='eza -lha --icons'
    alias lt='eza --tree --level=2 --icons'
    alias lta='eza --tree --level=2 -a --icons'
else
    alias ll='ls -lh'
    alias la='ls -a'
    alias lla='ls -lha'
fi

#* fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zstyle ':autocomplete:*' insert-unambiguous yes
# no:  Tab inserts the top completion.
# yes: Tab first inserts a substring common to all listed completions, if any.

# zstyle ':autocomplete:*' fzf-completion yes
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# ⚠️ NOTE: This setting can NOT be changed at runtime and requires that you
# have installed Fzf's shell extensions.

# zstyle ':autocomplete:recent-dirs' backend zoxide
# cdr:  Use Zsh's `cdr` function to show recent directories as completions.
# no:   Don't show recent directories.
# zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).
# ⚠️ NOTE: This setting can NOT be changed at runtime.

#* sheldon
eval "$(sheldon source)"

#* zinit
### Added by Zinit's installer
# if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
#     print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
#     command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
#     command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
#         print -P "%F{33} %F{34}Installation successful.%f%b" || \
#         print -P "%F{160} The clone has failed.%f%b"
# fi
#
# source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
#
# # Load a few important annexes, without Turbo
# # (this is currently required for annexes)
#
# zinit light zdharma-continuum/zinit-annex-as-monitor
# zinit light zdharma-continuum/zinit-annex-bin-gem-node
# zinit light zdharma-continuum/zinit-annex-patch-dl
# zinit light zdharma-continuum/zinit-annex-rust
# zinit blockf lucid light-mode for \
#     zdharma/history-search-multi-word \
#     marlonrichert/zsh-autocomplete \
#     zsh-users/zsh-autosuggestions \
#     zdharma-continuum/fast-syntax-highlighting \
#     supercrabtree/k \
#     dakesan/git-use-ssh
# # zinit light-mode for \
# #     zdharma-continuum/zinit-annex-as-monitor \
# #     zdharma-continuum/zinit-annex-bin-gem-node \
# #     zdharma-continuum/zinit-annex-patch-dl \
# #     zdharma-continuum/zinit-annex-rust \
# #     zsh-users/zsh-syntax-highlighting \
# #     zdharma/history-search-multi-word \
# #     marlonrichert/zsh-autocomplete
#
# # zinit ice depth=1
# # zinit light jeffreytse/zsh-vi-mode
#
# pyenv disabled - using mise instead
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

#* Environment variables
export FLYCTL_INSTALL="$HOME/.fly"
export BNB_CUDA_VERSION=124
export LD_LIBRARY_PATH="/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH"

#* pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    path_append "$PNPM_HOME"
fi

#* bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    path_append "$BUN_INSTALL/bin"
fi

#* ghcup-env
if [ -f "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env"
fi

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/work1/oodake/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/work1/oodake/mambaforge/etc/profile.d/conda.sh" ]; then
#         . "/work1/oodake/mambaforge/etc/profile.d/conda.sh"
#     else
#         export PATH="/work1/oodake/mambaforge/bin:$PATH"
#     fi
# fi
# unset __conda_setup
#
# if [ -f "/work1/oodake/mambaforge/etc/profile.d/mamba.sh" ]; then
#     . "/work1/oodake/mambaforge/etc/profile.d/mamba.sh"
# fi
# # <<< conda initialize <<<
#
#

# # aws
# if type "aws" > /dev/null; then
#   autoload
#   complete -C '/usr/local/bin/aws_compiler' aws
# fi
#
setopt autocd
autoload -Uz compinit
compinit

#* Conda/Mamba initialization
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
    
    for conda_path in $conda_paths; do
        if [ -d "$conda_path" ]; then
            if [ -f "$conda_path/etc/profile.d/conda.sh" ]; then
                . "$conda_path/etc/profile.d/conda.sh"
            elif [ -f "$conda_path/etc/profile.d/mamba.sh" ]; then
                . "$conda_path/etc/profile.d/mamba.sh"
            fi
            
            if [ -f "$conda_path/bin/conda" ]; then
                eval "$("$conda_path/bin/conda" shell.zsh hook)"
            fi
            break
        fi
    done
}

init_conda
