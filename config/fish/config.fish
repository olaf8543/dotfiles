if status is-interactive
    set -g fish_greeting

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
    alias pf "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"bat\" ."
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

    zoxide init fish | source
    starship init fish | source
    _conditional_fetch
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/oh/.lmstudio/bin
# End of LM Studio CLI section
