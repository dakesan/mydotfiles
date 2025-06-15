# * Path configuration
set -gx PATH "$HOME/.local/bin:$PATH"
for dir in (find ~/.local/bin -type d)
    set -gx PATH $dir $PATH
end
set -gx PATH "/usr/local/bin:$PATH"
set -gx PATH "/usr/bin:$PATH"
set -gx PATH "$HOME/.cargo/bin:$PATH"
set -gx PATH "$HOME/go/bin:$PATH"
set -gx PATH "$HOME/.poetry/bin:$PATH"
set -gx PATH "$HOME/.local/share/bob/nightly/nvim-linux64/bin:$PATH"
set -gx PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
set -gx PATH "$FLYCTL_INSTALL/bin:$PATH"
set -gx PATH "$HOME/.deno/bin:$PATH"
set -gx FLYCTL_INSTALL "/home/oodake/.fly"
set -gx PATH "/usr/local/cuda-12.8/bin:$PATH"
set -x BNB_CUDA_CERSION 128
set -gx LD_LIBRARY_PATH "/usr/local/cuda-12.8/lib64"

set -x PATH $HOME/.nodenv/bin $PATH
status --is-interactive; and source (nodenv init -|psub)

# tmux
alias tmux="tmux -f /home/oodake/.config/tmux/.tmux.conf"

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
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
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

# * Claude Code
if test -f "$HOME/.bun/bin/claude"
    alias claude="$HOME/.bun/bin/claude"
else if test -f "$HOME/.claude/local/claude"
    alias claude="$HOME/.claude/local/claude"
end
alias yolo="claude --dangerously-skip-permissions"
alias yolor="claude --dangerously-skip-permissions --resume"
alias clauder="claude --resume"

# * git
alias gp='git pull'
alias gP='git push'
alias ga='git add .'
alias gc='git checkout'
alias gs='git status'
alias gb='git branch'
alias gl='git clone'
alias gC='git commit -m'
# lazygit
alias lg='lazygit'
# git path
# function gitroot
#   set -x git_root (git rev-parse --show-toplevel)
#   echo $git_root
# end

function gitmain
  git config --global user.name "dakesan"
  git config --global user.email "dakesan@user.noreply.github.com"
end

function gitsub
  git config --global user.name "snitch0"
  git config --global user.email snitch@excel2rlang.com
end

function gitreverse
  git reset --soft HEAD\^
end
alias gr 'gitreverse'

function gitpub
  eval (ssh-agent -c)
  ssh-add ~/.ssh/github
end

function isWinDir
  switch $PW
    case "/mnt/*"
      return 0
    case '*'
      return 1
  end
end

# wrap the git command to either run windows git or linux
function git
  if isWinDir
    git.exe $argv
  else
    /usr/bin/git $argv
  end
end

function start_agent
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end
end

function add_identities
    ssh-add -l > /dev/null 2>&1
    if test $status -ne 0
        ssh-add ~/.ssh/github >/dev/null 2>&1
    end
end

if status --is-interactive
  start_agent
  add_identities
  gitpub
end

# * quarto
function html2pdf
  for file in $argv
    set filename (string replace -r '.html$' '' $file)
    google-chrome-stable --headless --disable-gpu --print-to-pdf=$filename.pdf $file
  end
end

# * zellij
function zla
  zellij attach (zl | head -1)
end

function fmv
  tar c $argv[1] | pv | tar x -C $argv[2]
end

# * aws
function sshaws
  ssh -i "~/aws/rsa_awsssh.pem" ubuntu@$argv
end
source $HOME/dotfiles/hostnames.fish

function sshaws2
  ssh -i "~/aws/rsa_awsssh.pem" ec2-user@$argv
end

function sshaws3
  ssh -i "~/aws/uehara.pem" ubuntu@$argv
end

# * blog
function saveimg
    powershell.exe "(Get-Clipboard -Format Image).Save(\"$argv[1]\")"
    return 1
end

function ec2table
  aws ec2 describe-instances --output=table --query 'Reservations[].Instances[].{InstanceId: InstanceId, PrivateIp: join(`, `, NetworkInterfaces[].PrivateIpAddress), GlobalIP: join(`, `, NetworkInterfaces[].Association.PublicIp), InstanceType: InstanceType, Platform:Platform, State: State.Name, SecurityGroupId: join(`, `, SecurityGroups[].GroupId) ,Name: Tags[?Key==`Name`].Value|[0]}'
end

# * exa
alias la 'eza -ag --icons'
alias ll 'eza -aal -g --git --icons'
alias lt 'eza -T -g -L 3 -a -I "node_modules|.git|.cache" --icons'
alias lta 'lt -l --git'

# * fzf

# * Neovim
alias vim 'nvim'

# * sheldon
# sheldon source | source
# * conda
alias act 'mamba activate'
alias dact 'mamba deactivate'

# * BioInformatics
function count-fastq
  zcat $argv | awk 'BEGIN{sum=0;}{if(NR%4==2){sum+=length($0);}}END{print sum;}'
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/mambaforge/bin/conda
    eval $HOME/mambaforge/bin/conda "shell.fish" "hook" $argv | source
end

if test -f "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
    source "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
end

if test -f "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
    source "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); /usr/local/bin/aws_completer | sed \'s/ $//\'; end)'

# eval "$(register-python-argcomplete s3util)"

# Yazi
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# theme
set -U fish_color_normal normal
set -U fish_color_command F8F8F2
set -U fish_color_quote F1FA8C
set -U fish_color_redirection 8BE9FD
set -U fish_color_end 50FA7B
set -U fish_color_error FFB86C
set -U fish_color_param FF79C6
set -U fish_color_comment 6272A4
set -U fish_color_match normal
set -U fish_color_selection c0c0c0
set -U fish_color_search_match ffff00
set -U fish_color_history_current normal
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd 008000
set -U fish_color_cwd_root 800000
set -U fish_color_valid_path normal
set -U fish_color_autosuggestion BD93F9
set -U fish_color_user 00ff00
set -U fish_color_host normal
set -U fish_color_cancel normal
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
uv generate-shell-completion fish | source

# pnpm
set -gx PNPM_HOME "/home/ubuntu/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/ubuntu/.ghcup/bin $PATH # ghcup-env
