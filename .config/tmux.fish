# tmux configuration and session management

# tmux alias
alias tmux="tmux -f $HOME/.config/tmux/tmux.conf"
alias tm 'tmux-select'     # セッション選択・復帰
alias tmn 'tmux-new'       # 新規セッション作成
alias tmk 'tmux-kill'      # セッション削除
alias tmr 'tmux-rename'    # セッション名変更
alias tms 'tmux-switch'    # セッション切り替え
alias tmx 'tmux-next'      # 次のセッション
alias tmz 'tmux-prev'      # 前のセッション
alias tmw 'tmux-new-window'  # 新しいウィンドウ（タブ）
alias tml 'tmux-window-list' # ウィンドウ一覧
alias tmh 'tmux-help'      # ヘルプ表示

# * tmux session management
function tmux-select
    set sessions (tmux list-sessions -F "#{session_name}" 2>/dev/null)
    if test (count $sessions) -eq 0
        echo "No tmux sessions found"
        return 1
    end
    set selected (printf '%s\n' $sessions | fzf --height=40% --border --prompt="Select tmux session: " --preview="tmux list-windows -t {}")
    if test -n "$selected"
        tmux attach-session -t "$selected"
    end
end

function tmux-new
    if test (count $argv) -eq 0
        set session_name (basename (pwd))
    else
        set session_name $argv[1]
    end

    # Check if we're inside tmux
    if set -q TMUX
        # Inside tmux: create detached session and optionally switch
        tmux new-session -d -s "$session_name"
        echo "Created detached session: $session_name"
        read -P "Switch to new session? (y/n): " choice
        if test "$choice" = "y" -o "$choice" = "Y"
            tmux switch-client -t "$session_name"
        end
    else
        # Outside tmux: create and attach normally
        tmux new-session -s "$session_name"
    end
end

function tmux-kill
    set sessions (tmux list-sessions -F "#{session_name}" 2>/dev/null)
    if test (count $sessions) -eq 0
        echo "No tmux sessions found"
        return 1
    end
    set selected (printf '%s\n' $sessions | fzf --height=40% --border --prompt="Kill tmux session: " --preview="tmux list-windows -t {}")
    if test -n "$selected"
        tmux kill-session -t "$selected"
        echo "Killed session: $selected"
    end
end

function tmux-rename
    set current (tmux display-message -p "#{session_name}" 2>/dev/null)
    if test -z "$current"
        echo "Not in a tmux session"
        return 1
    end
    echo "Current session: $current"
    read -P "New name: " new_name
    if test -n "$new_name"
        tmux rename-session "$new_name"
        echo "Renamed to: $new_name"
    end
end

function tmux-help
    echo "🚀 Modern tmux session manager"
    echo ""
    echo "Session Commands:"
    echo "  tm / tmux-select    📋 Select and attach to session (fzf)"
    echo "  tmn / tmux-new      ➕ Create new session (current dir name)"
    echo "  tmk / tmux-kill     🗑️  Kill session (fzf)"
    echo "  tmr / tmux-rename   ✏️  Rename current session"
    echo "  tms / tmux-switch   🔄 Switch session (choose-session)"
    echo "  tmx / tmux-next     ⏭️  Next session"
    echo "  tmz / tmux-prev     ⏮️  Previous session"
    echo ""
    echo "Window (Tab) Commands:"
    echo "  tmw / tmux-new-window  ➕ Create new window (tab)"
    echo "  tml / tmux-window-list 📋 List windows"
    echo "  tmh / tmux-help        ❓ Show this help"
    echo ""
    echo "Keybindings (inside tmux):"
    echo "  Prefix + n/p        ⏭️⏮️  Next/Previous window (tab)"
    echo "  Prefix + c          ➕ Create new window (tab)"
    echo "  Prefix + 0-9        🔢 Direct window switch"
    echo "  Prefix + w          📋 Choose window"
    echo "  Prefix + s/Tab      📋 Choose session"
    echo "  Prefix + )/( 	      ⏭️⏮️  Next/Previous session"
    echo "  Prefix + F1-F8      🔢 Direct session switch (0-7)"
    echo "  Prefix + Ctrl+s     ➕ Create new session with name"
    echo ""
    echo "Mouse Operations:"
    echo "  Click on tab        🖱️  Select window (tab)"
    echo "  Wheel on status     🖱️  Next/Previous window"
    echo "  Right-click status  🖱️  Create new window"
    echo ""
    echo "Help & Reference:"
    echo "  Prefix + Ctrl+P     🎯 tmux command palette (fzf)"
    echo "  Prefix + ?          🎯 tmux command palette (alias)"
    echo ""
    echo "Usage examples:"
    echo "  tm                  # Select session interactively"
    echo "  tmn myproject       # Create session named 'myproject'"
    echo "  tmw editor          # Create new window named 'editor'"
    echo "  tmw                 # Create new window (default name)"
    echo "  tml                 # List all windows in current session"
    echo "  tmx / tmz           # Quick next/prev session switch"
end

# Quick session switching functions
function tmux-switch
    tmux choose-session
end

function tmux-next
    tmux switch-client -n
end

function tmux-prev
    tmux switch-client -p
end

# Window (tab) management functions
function tmux-new-window
    if test (count $argv) -eq 0
        tmux new-window
    else
        tmux new-window -n "$argv[1]"
    end
end

function tmux-window-list
    tmux list-windows
end
