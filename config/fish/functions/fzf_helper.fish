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
