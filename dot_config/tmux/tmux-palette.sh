#!/bin/bash

# tmux command palette - improved version
exec < /dev/tty
exec > /dev/tty

# Extended command list
commands="Next Window [TAB]|next-window
Previous Window [TAB]|previous-window
Create New Window [TAB]|new-window
Choose Window [TAB]|choose-window
Kill Current Window [TAB]|kill-window
Rename Window [TAB]|command-prompt -p \"New window name:\" \"rename-window %%\"
Choose Session [SES]|choose-session
Next Session [SES]|switch-client -n
Previous Session [SES]|switch-client -p
Create New Session [SES]|command-prompt -p \"New session name:\" \"new-session -d -s %%\"
Detach Session [SES]|detach-client
Rename Session [SES]|command-prompt -p \"New session name:\" \"rename-session %%\"
Split Horizontal [PAN]|split-window -h
Split Vertical [PAN]|split-window -v
Zoom/Unzoom Pane [PAN]|resize-pane -Z
Kill Current Pane [PAN]|kill-pane
Switch Pane Layout [PAN]|next-layout
Copy Mode [OTH]|copy-mode
Command Prompt [OTH]|command-prompt
Reload Config [OTH]|source-file ~/.config/tmux/tmux.conf \\; display \"Config reloaded!\"
List All Keys [OTH]|list-keys
Show Sessions [INF]|list-sessions
Show Windows [INF]|list-windows
Show Panes [INF]|list-panes
Show Options [INF]|show-options -g"

# fzfのオプションを全て削除して実行
selected=$(echo "$commands" | fzf)

# 選択後の処理はデバッグのため一旦そのままでOK
if [ -n "$selected" ]; then
    # この段階では delimiter を指定していないので、選択した行全体が command に入る
    command=$(echo "$selected" | cut -d'|' -f2)
    tmux "$command"
fi
