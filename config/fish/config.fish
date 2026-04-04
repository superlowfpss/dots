set -g fish_greeting

# fastfetch

if status is-interactive
end

abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'
abbr mkdir 'mkdir -p'
abbr mc 'mc --nosubshell'
abbr clear_ram 'sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
function fish_prompt
    # Store SSH status
    if set -q SSH_CLIENT || set -q SSH_TTY
        set __ssh true
    end

    # Git section - moved to the beginning
    set __git_status (git status 2> /dev/null | head -1)
    set git_display ""

    if test -n "$__git_status"
        string match -q "On branch *" "$__git_status"
        and string replace "On branch " "" "$__git_status" | read -l __git_branch
        and set git_display "$git_display"(set_color A6E22E)"⌥$__git_branch"
        or set git_display "$git_display"(set_color FD971F)"$__git_status"

        # Git ahead/behind info
        set_color F92672
        git status -sb --no-column --porcelain 2>/dev/null | grep -oe "ahead [0-9]*, behind [0-9]*" | string replace "ahead " " ⬆" | string replace ", behind " " ⬇" | read -l git_ahead_behind
        set git_display "$git_display$git_ahead_behind"
    end

    # SSH indicator
    if set -q __ssh
        set_color 909d63 --bold
        # Use built-in hostname or read from system
        if command -q hostname
            set current_host (hostname -s 2>/dev/null || hostname | string split '.' | head -1)
        else
            set current_host (cat /proc/sys/kernel/hostname 2>/dev/null | string split '.' | head -1 || echo "unknown")
        end
        echo -n "[$USER@$current_host] "
    end

    # Current directory
    set_color $fish_color_cwd

    # Calculate width for truncation
    set prompt_width (math (pwd | string length) + (string length "$git_display") + 7)
    if set -q __ssh
        set prompt_width (math $prompt_width + (string length "[$USER@$current_host] "))
    end

    if test $prompt_width -gt $COLUMNS
        echo -n "["(pwd | string sub -s (math $prompt_width - $COLUMNS + 4))"]"
    else
        echo -n "["(pwd)"]"
    end

    # Display git info (if any)
    if test -n "$git_display"
        echo -n " $git_display"
    end

    # Final prompt character
    set_color normal
    echo -n (set_color $fish_color_cwd)
    set -q __ssh && echo '🖧 ' || echo '➤ '
end
