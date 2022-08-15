# oh-my-posh
export PATH=$PATH:~/.local/bin
export VIRTUAL_ENV_DISABLE_PROMPT=1
eval "$(oh-my-posh init zsh --config ~/.poshthemes/snitch_custom.omp.json)"

# manをnvimで開く
# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="nvim +'set ft=man' -"
export MANPAGER='nvim +Man!'

# alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias zshconfig="vim ~/.zshrc"
alias act="mamba activate"
alias dact="mamba deactivate"
alias vimconfig="vim ~/.config/nvim/init.vim"
alias python="python3"
alias pip="pip3"
alias r="radian"
alias reload="exec zsh"
alias z="~/.local/bin/zellij"
alias K="k -h"
alias ka="k -ah"
alias lg="lazygit"

# genie -i
function startrstudio(){
    sudo rstudio-server start
    sudo genie -i
}

### bracket
setopt auto_param_keys
### color
autoload -Uz colors
colors
### autocomplete
autoload -Uz compinit; compinit -C
setopt magic_equal_subst
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
setopt correct
### key binding ###
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
### glob
setopt extended_glob
### wdchar
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

### snippets ###
function peco-snippets() {

    local line
    if [ ! -e ~/.snippets ]; then
        echo "~/.snippets is not found." >&2
        return 1
    fi

    line=$(grep -v "^#" ~/.snippets | peco --query "$LBUFFER")
    if [ -z "$line" ]; then
        return 1
    fi

    snippet=$(echo "$line" | sed "s/^\[[^]]*\] *//g")
    if [ -z "$snippet" ]; then
        return 1
    fi

    BUFFER=$snippet
    zle clear-screen
}
zle -N peco-snippets
bindkey '^x^x' peco-snippets

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/root/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/root/miniconda3/etc/profile.d/conda.sh" ]; then
    "/root/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
# export PATH="/root/miniconda3/bin:$PATH"  # commented out by conda initialize  # commented out by conda initialize
    fi
fi
unset __conda_setup
# <<< conda initialize <<
#

# source ~/miniconda3/etc/profile.d/conda.sh  # commented out by conda initialize

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true

# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# source ~/desktop/enhancd/init.sh

# path
export PATH=$PATH:/mnt/c/Users/dakes/AppData/Local/Programs/Microsoft\ VS\ Code/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/home/oodake/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# git path
function gitroot(){
    export git_root=$(git rev-parse --show-toplevel)
    echo $git_root
}

function gitMain() {
  git config --global user.name "dakesan"
  git config --global user.email dakesan@excel2rlang.com
  git config --list
}

function gitPri() {
  git config --global user.name "snitch0"
  git config --global user.email snitch@excel2rlang.com
  git config --list
}

# source /home/oodake/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)

zinit light zdharma-continuum/zinit-annex-as-monitor
zinit light zdharma-continuum/zinit-annex-bin-gem-node
zinit light zdharma-continuum/zinit-annex-patch-dl
zinit light zdharma-continuum/zinit-annex-rust
zinit blockf lucid light-mode for \
    zdharma/history-search-multi-word \
    marlonrichert/zsh-autocomplete \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    supercrabtree/k \
    dakesan/git-use-ssh
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust \
#     zsh-users/zsh-syntax-highlighting \
#     zdharma/history-search-multi-word \
#     marlonrichert/zsh-autocomplete

# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

# autocomplete settings
bindkey '^I'   complete-word       # tab          | complete
# bindkey '^E' autosuggest-accept  # shift + tab  | autosuggest
bindkey '^E' end-of-line  # shift + tab  | autosuggest
# python genzshcomp function
funciton genpycomp() {
    bn=$(basename $1)
    python $1 --help > .tmp
    genzshcomp .tmp > ~/.zsh/completion/_${bn}
    rm .tmp
}
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/oodake/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/oodake/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/oodake/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/oodake/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/oodake/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/oodake/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
