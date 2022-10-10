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
else
  source ~/dotfiles/.zsh/.zshhome;
fi

#* Path configuration
path_append "$HOME/.local/bin"
path_append "/usr/local/bin"
path_append "/usr/bin"
path_append "$HOME/.cargo/bin"
path_append "$HOME/go/bin"
path_append "$HOME/.poetry/bin"

# Util command
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
alias vimconfig="vim $HOME/dotfiles/.config/nvim/init.vim"

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
alias gs='git status'
alias gb='git branch'
alias gl='git clone'
alias cout='git checkout'
# lazygit
alias lg='lazygit'
# git path
function gitroot(){
  export git_root=$(git rev-parse --show-toplevel)
  echo $git_root
}

function gitMain() {
  git config --global user.name "dakesan"
  git config --global user.email dakesan@excel2rlang.com
  # git config --list
}

function gitPri() {
  git config --global user.name "snitch0"
  git config --global user.email snitch@excel2rlang.com
  # git config --list
}

function gitReverse() {
  git reset --soft HEAD\^
}
alias gr='gitReverse'


#* R/Python/SQL
alias sl="sqlite3"

#* exa
alias e='exa --icons'
alias l='e -l'
alias k=l
alias ls=e
alias ea='exa -ag --icons'
alias la=ea
alias ee='exa -aal -g --git --icons'
alias ll=ee
alias et='exa -T -g -L 3 -a -I "node_modules|.git|.cache" --icons'
alias lt=et
alias eta='lt -l --git'
alias lta=eta

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
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.poetry/bin:$PATH"
