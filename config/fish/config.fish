if status is-interactive
    set -g fish_greeting

    # colors that i might use in various locations
    set -l main "#fa694e"
    set -l accent "#fdf087"

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

    function _conditional_fetch
        if not set -q TERM_PROGRAM || test "$TERM_PROGRAM" != vscode
            fetch
        end
    end

    function code
        set -lx ELECTRON_OZONE_PLATFORM wayland
        /usr/bin/code --force-device-scale-factor=1 $argv
    end

    fish_vi_key_bindings

    alias fetch "fastfetch | lolcat --spread 0.8"
    alias ^ command
    alias snF "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\" ~"
    alias snf "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\" ."
    alias snD "__fzf_helper d \"tree -C\" \"nvim\" ~"
    alias snd "__fzf_helper d \"tree -C\" \"nvim\" ."
    alias cds "__fzf_helper d \"tree -C\" \"z\" ~"
    alias hamil "kitty +kitten ssh orl6135@hamilton.se.rit.edu"
    alias clear "command clear && _conditional_fetch"
    # alias code "ELECTRON_OZONE_PLATFORM=wayland code --force-device-scale-factor=1"
    alias gt lazygit
    alias cd z
    alias ci zi
    alias ls "eza --icons"
    alias la "eza -la --icons --group-directories-first --time-style=iso"
    alias lt "eza -T --icons"

    # Abbreviations

    #PATH variables
    #Most of these are done in my zshrc because its my system shell

    #python environment, i keep reusing pypr_env just cuz
    fish_add_path ~/py-env/bin
    fish_add_path ~/lolcat/bin

    # Miscellanious configuration
    # General fzf color scheme
    set -l fzf_fg "#d8dee9"
    set -l fzf_bg "#2e2e2e"
    set -l fzf_header "#5e81ac"

    set -gx FZF_DEFAULT_OPTS \
        "--color=fg:$fzf_fg,hl:$main,fg+:$fzf_fg,bg+:$fzf_bg,hl+:$main" \
        "--color=info:$main,prompt:$main,pointer:$main,spinner:$main,header:$fzf_header"

    export LS_COLORS=$(vivid generate lava)
    # set -gx FZF_DEFAULT_OPTS "--color=fg:#d8dee9,hl:#fa694e,fg+:#d8dee9,bg+:#2e2e2e,hl+:#fa694e \
    #     --color=info:#fa694e,prompt:#fa694e,pointer:#fa694e,spinner:#fa694e,header:#5e81ac"
    zoxide init fish | source
    starship init fish | source
    _conditional_fetch
end
