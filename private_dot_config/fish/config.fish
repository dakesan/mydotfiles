# * OS detection
function is_ubuntu
    if test (uname) = "Linux"; and test -f /etc/lsb-release
        # cuda
        set -gx PATH "/usr/local/cuda-12.8/bin:$PATH"
        set -x BNB_CUDA_CERSION 128
        set -gx LD_LIBRARY_PATH "/usr/local/cuda-12.8/lib64"

        # miniforge3
        if test -f $HOME/miniforge3/bin/conda
            eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
        end

        if test -f "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
            source "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
end
    end
end

# * dotenv
source $HOME/.config/dotenv.fish

if test -f ~/.env.global
    load_dotenv ~/.env.global
end

is_ubuntu

# * Path configuration (optimized)
set -gx PATH "$HOME/.local/share/mise/shims:$PATH"
set -gx PATH "$HOME/.local/bin:$PATH"
# findコマンドによる動的PATH設定は重いためコメントアウト
# for dir in (find ~/.local/bin -type d)
#     set -gx PATH $dir $PATH
# end
set -gx PATH "/usr/local/bin:$PATH"
set -gx PATH "/usr/bin:$PATH"
set -gx PATH "$HOME/.cargo/bin:$PATH"
set -gx PATH "$HOME/go/bin:$PATH"

# * tmux
source $HOME/.config/tmux.fish

# * alias
# ? util command
alias pi 'pip install'
# ? axel
alias Axel 'axel -n 10 --insecure'
# ? prompt
alias z 'pushd ./ && z > /dev/null'
# zoxide init fish | source
set --query ZOXIDE_INIT || zoxide init --cmd z fish | source
alias reload 'fish'
# Starship
starship init fish | source
# muCommander (macOS only)
alias mu 'open -a mucommander --args $(pwd)'

# * python
alias ipo 'ipython'

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
set -gx PATH "$HOME/.claude/local:$PATH"
set -g DISABLE_AUTOUPDATER 1
alias clauder="claude -c"

set -g ENABLE_BACKGROUND_TASKS 1

# * chezmoi
alias cm='chezmoi'

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
  # SSH Agent管理を軽量化
  if not set -q SSH_AUTH_SOCK; or test ! -S "$SSH_AUTH_SOCK"
    eval (ssh-agent -c) >/dev/null 2>&1
    ssh-add ~/.ssh/github >/dev/null 2>&1
  end
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


# * quarto
function html2pdf
  for file in $argv
    set filename (string replace -r '.html$' '' $file)
    google-chrome-stable --headless --disable-gpu --print-to-pdf=$filename.pdf $file
  end
end

function fmv
  tar c $argv[1] | pv | tar x -C $argv[2]
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
alias ls /bin/ls
alias la 'eza -ag --icons'
alias ll 'eza -aal -g --git --icons'
alias lt 'eza -T -g -L 3 -a -I "node_modules|.git|.cache" --icons'
alias lta 'lt -l --git'
alias exa 'eza'


# * conda
alias act 'mamba activate'
alias dact 'mamba deactivate'

# * BioInformatics
function count-fastq
  zcat $argv | awk 'BEGIN{sum=0;}{if(NR%4==2){sum+=length($0);}}END{print sum;}'
end

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

# * mise
# miseが ~/.local/bin にあるか、PATHに通っているか確認して実行
if test -x "$HOME/.local/bin/mise"
    "$HOME/.local/bin/mise" activate fish | source
else if type -q mise
    mise activate fish | source
end

# * npm / pnpm / bun (順序はこのままでOK)
set -gx PATH "$HOME/.npm-global/bin:$PATH"
set -gx PNPM_HOME "/home/ubuntu/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# * uv
# uvコマンドが存在する場合のみ補完を読み込む
if type -q uv
    uv generate-shell-completion fish | source
end

# Added by Antigravity
fish_add_path /Users/oodakemac/.antigravity/antigravity/bin
