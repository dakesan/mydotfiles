# Interactive prefix shell: run commands prefixed by a program/subcommands
function with --description 'Interactive prefix shell: run commands prefixed by a program/subcommands'
    if test (count $argv) -eq 0
        echo "Usage: with <program> [args...]"
        echo "Examples:"
        echo "  with git"
        echo "  with java Primes"
        return 1
    end

    # Base prefix parts (program + initial args)
    set -l base $argv
    # Dynamic subcommands stack (added via +sub, replaced via !sub, removed via -)
    set -l subs
    # Last executed full command (for empty-line re-run)
    set -l last_cmd ""

    # Interactive loop
    while true
        # Build current prefix
        set -l pfx $base $subs
        set -l pfx_str (string join ' ' $pfx)

        # Read a line with prompt (Ctrl-D ends)
        # Use fish's command color, magenta for >
        set -l prompt (set_color $fish_color_command)"$pfx_str"(set_color magenta)">"(set_color normal)" "
        if not read -P "$prompt" line
            echo
            break
        end

        # Trim whitespace
        set line (string trim $line)

        # Exit commands
        if test "$line" = ":q" -o "$line" = ":exit"
            break
        end

        # Empty line: repeat last command
        if test -z "$line"
            if test -n "$last_cmd"
                eval $last_cmd
            end
            continue
        end

        # ":"-prefixed raw shell command
        if string match -q ":*" -- $line
            set -l raw (string replace -r '^:' '' -- $line)
            set last_cmd $raw
            eval $raw
            continue
        end

        # "+" add subcommand (append)
        if string match -q "+*" -- $line
            set -l sub (string replace -r '^\+' '' -- $line)
            if test -n "$sub"
                set -a subs $sub
            end
            continue
        end

        # "!" replace last subcommand (or set if none)
        if string match -q "!*" -- $line
            set -l sub (string replace -r '^\!' '' -- $line)
            if test -n "$sub"
                if test (count $subs) -gt 0
                    set subs $subs[1..-2] $sub
                else
                    set subs $sub
                end
            end
            continue
        end

        # "-" remove last subcommand
        if test "$line" = "-"
            if test (count $subs) -gt 0
                set subs $subs[1..-2]
            end
            continue
        end

        # Otherwise: treat as arguments to the current prefix
        set -l cmd_str "$pfx_str $line"
        set last_cmd $cmd_str
        eval $cmd_str
    end
end
