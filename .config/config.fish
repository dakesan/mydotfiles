# * Path configuration
set -gx PATH "$HOME/.local/bin:$PATH"
set -gx PATH "/usr/local/bin:$PATH"
set -gx PATH "/usr/bin:$PATH"
set -gx PATH "$HOME/.cargo/bin:$PATH"
set -gx PATH "$HOME/go/bin:$PATH"
set -gx PATH "$HOME/.poetry/bin:$PATH"
set -gx PATH "$HOME/.local/share/bob/nightly/nvim-linux64/bin:$PATH"
# * alias
# ? util command
alias pi 'pip install'
alias ai 'sudo apt install'
alias nf 'nextflow'
# ? axel
alias Axel 'axel -n 10 --insecure'
# ? zellij
alias zelij 'zellij'
alias zl 'zellij list-sessions'
# ? prompt
alias z 'pushd ./ && z > /dev/null'
zoxide init fish | source
alias reload 'fish'
starship init fish | source

# * python
alias ipo 'ipython'
set PYENV_ROOT "$HOME/.pyenv"
command -v pyenv >/dev/null; or export PATH="$PYENV_ROOT/bin:$PATH"
pyenv init - | source

# * fish configuration
set fish_greeting ''
set -gx TERM xterm-256color
# ? theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# * git
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
# function gitroot
#   set -x git_root (git rev-parse --show-toplevel)
#   echo $git_root
# end

function gitmain
  git config --global user.name "dakesan"
  git config --global user.email dakesan@excel2rlang.com
end

function gitsub
  git config --global user.name "snitch0"
  git config --global user.email snitch@excel2rlang.com
end

function gitreverse
  git reset --soft HEAD\^
end
alias gr 'gitreverse'

# * exa
alias la 'exa -ag --icons'
alias ll 'exa -aal -g --git --icons'
alias lt 'exa -T -g -L 3 -a -I "node_modules|.git|.cache" --icons'
alias lta 'lt -l --git'

# * fzf

# * Neovim
alias vim 'nvim'

# * sheldon
# sheldon source | source

# * conda
alias act 'mamba activate'
alias dact 'mamba deactivate'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/mambaforge/bin/conda
    eval $HOME/mambaforge/bin/conda "shell.fish" "hook" $argv | source
end

if test -f "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
    source "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<
