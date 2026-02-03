if status is-interactive
    set -g fish_greeting

    # colors that i might use in various locations
    set -l main "#00ffa7"
    set -l accent "#00ff82"

    # Aliases
    source ~/.config/fish/functions/fzf_helper.fish
    source ~/.config/fish/functions/conditional_fetch.fish
    source ~/.config/fish/functions/yazi.fish
    source ~/.config/fish/functions/zoxide.fish
    source ~/.config/fish/functions/gcrun.fish

    fish_vi_key_bindings

    alias fetch fastfetch
    alias sF "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\" ~"
    alias sf "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\" ."
    alias sE "__fzf_helper d \"tree -C\" \"yazi\" ~"
    alias se "__fzf_helper d \"tree -C\" \"yazi\" ."
    # alias cd z
    alias cds zi
    alias cdS "__fzf_helper d \"tree -C\" \"z\" ~"
    alias cdh "__fzf_helper d \"tree -C\" \"z\" ."
    alias hamil "wezterm ssh hamilton.se.rit.edu"
    alias clear "command clear && _conditional_fetch"
    alias ls "eza --icons --group-directories-first"
    alias la "ls -lha"
    alias lt "eza --tree --level=2 --icons --git"
    alias lta "lt --long -a"
    alias lg lazygit # lazy ahh mf

    # Abbreviations

    #PATH variables
    #Most of these are done in my zshrc because its my system shell
    export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
    fish_add_path ~/scripts/
    fish_add_path ~/.dotfiles/scripts/

    # Miscellanious configuration

    # General fzf color scheme
    set -l fzf_fg "#d8dee9"
    set -l fzf_bg "#2e2e2e"
    set -l fzf_header "#5e81ac"

    set -gx FZF_DEFAULT_OPTS \
        "--color=fg:$fzf_fg,hl:$main,fg+:$fzf_fg,bg+:$fzf_bg,hl+:$main" \
        "--color=info:$main,prompt:$main,pointer:$main,spinner:$main,header:$fzf_header"

    zoxide init fish | source
    starship init fish | source
    _conditional_fetch
end
