if status is-interactive
    set -g fish_greeting

    # Aliases
    function fetch
        paste -d ' ' (cat ~/.config/neofetch/txtfiles/ror2.txt | psub) (neofetch | psub) | lolcat --spread 0.8
    end
    function __fzf_helper
        # Arguments: $argv[1] = fd type (f/d), $argv[2] = preview command, $argv[3] = action command
        set -l type $argv[1]
        set -l preview_cmd $argv[2]
        set -l action $argv[3]

        set -l selected (fd --type $type --hidden --exclude .git . ~ | fzf \
            --height 40% \
            --reverse \
            --preview "$preview_cmd {}")

        if test -n "$selected"
            set -l path (realpath "$selected")
            eval "$action $path"
        end
    end

    alias snf "__fzf_helper f \"bat --color=always --line-range :500 {}\" \"nvim\""
    alias snd "__fzf_helper d \"tree -C\" \"nvim\""
    alias cds "__fzf_helper d \"tree -C\" \"cd\""
    alias hamil "kitty +kitten ssh orl6135@hamilton.se.rit.edu"
    alias clear "clear && fetch"
    alias code "code --enable-features=UseOzonePlatform --ozone-platform=wayland"
    alias nv "nvim ."
    alias cd "z"
    alias gt "lazygit"

    # Abbreviations

    #PATH variables
    #Most of these are done in my zshrc because its my system shell

    #python environment, i keep reusing pypr_env just cuz
    fish_add_path ~/pypr-env/bin

    # Miscellanious configuration
    # General fzf color scheme
    set -gx FZF_DEFAULT_OPTS "--color=fg:#d8dee9,hl:#00ffa7,fg+:#d8dee9,bg+:#2e2e2e,hl+:#00ffa7 \
        --color=info:#00ffa7,prompt:#00ffa7,pointer:#00ffa7,spinner:#00ffa7,header:#5e81ac"
    zoxide init fish | source
    fetch
end
