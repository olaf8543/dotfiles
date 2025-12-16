if status is-interactive
    set -g fish_greeting

    # colors that i might use in various locations
    set -l main "#00ffa7"
    set -l accent "#00ff82"

    # Aliases
    function __fzf_helper
        # Arguments: $argv[1] = fd type (f/d), $argv[2] = preview command, $argv[3] = action command
        set -l type $argv[1]
        set -l preview_cmd $argv[2]
        set -l action $argv[3]
        set -l dir $argv[4]

        set -l selected (fd --type $type --hidden --exclude .git . $dir | fzf \
            --height 40% \
            --reverse \
            --preview "$preview_cmd {}")

        if test -n "$selected"
            set -l path (realpath "$selected")
            eval "$action $path"
        end
    end

    # Yazi wrapper function, allows me to cd with yazi when i want
    function e
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function _conditional_fetch
        if not set -q TMUX
            if not set -q TERM_PROGRAM || test "$TERM_PROGRAM" != vscode
                fetch
            end
        end
    end

    function code
        set -lx ELECTRON_OZONE_PLATFORM wayland
        /usr/bin/code --force-device-scale-factor=1 $argv
    end

    # Compiles and runs a c file, compiles to a file of the same name of the c file
    # Eg. something.c -> something
    function gcrun
        argparse v/valgrind -- $argv
        set -l file $argv[1]
        or return
        # Remove the file type from the file path
        set -l output (string replace -r '\.([^./]+)$' '' -- $file)

        # Determine compiler based on file type
        set -l compiler
        set -l ext (string match -r '\.([^./]+)$' -- "$file" | string lower | head -n 1)

        switch "$ext"
            case '.c'
                set compiler gcc
            case '.cpp' '.cc' '.cxx' '.c++'
                set compiler g++
            case '*'
                echo "Unsupported file type '$ext'"
                return 1
        end

        if test -e $file && test -n "$output"
            eval "$compiler -g -Wall -o $output $file"
            if test $status = 0
                if set -q _flag_v
                    valgrind --leak-check=full $output --debug
                else
                    eval "./$output"
                end
            end
        else
            echo "File does not exist"
        end
    end

    fish_vi_key_bindings

    alias fetch "fastfetch | lolcat --spread 0.8"
    alias sF "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\" ~"
    alias sf "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\" ."
    alias sE "__fzf_helper d \"tree -C\" \"yazi\" ~"
    alias se "__fzf_helper d \"tree -C\" \"yazi\" ."
    alias cd z
    alias cds zi
    alias cdS "__fzf_helper d \"tree -C\" \"z\" ~"
    alias cdh "__fzf_helper d \"tree -C\" \"z\" ."
    alias hamil "wezterm ssh hamilton.se.rit.edu"
    alias clear "command clear && _conditional_fetch"
    alias ls "eza --icons"
    alias la "eza -la --icons --group-directories-first --time-style=iso"
    alias lt "eza -T --icons"
    alias lg lazygit # lazy ahh mf

    # Abbreviations

    #PATH variables
    #Most of these are done in my zshrc because its my system shell
    export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
    fish_add_path ~/scripts/
    fish_add_path ~/pyvenv/bin/
    fish_add_path ~/.dotfiles/scripts/

    # Miscellanious configuration

    # General fzf color scheme
    set -l fzf_fg "#d8dee9"
    set -l fzf_bg "#2e2e2e"
    set -l fzf_header "#5e81ac"

    set -gx FZF_DEFAULT_OPTS \
        "--color=fg:$fzf_fg,hl:$main,fg+:$fzf_fg,bg+:$fzf_bg,hl+:$main" \
        "--color=info:$main,prompt:$main,pointer:$main,spinner:$main,header:$fzf_header"

    export LS_COLORS=$(vivid generate tokyonight-night)
    export EDITOR="nvim"
    zoxide init fish | source
    starship init fish | source
    _conditional_fetch
end
