# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# PATH configuration
$env.PATH = ($env.PATH | split row (char esep) | append "~/lolcat/bin")

# Zoxide integration
source ~/.config/nushell/zoxide.nu

# Aliases
alias hamil = kitty +kitten ssh orl6135@hamilton.se.rit.edu
alias nv = nvim .
alias gt = lazygit
alias cd = z
alias cds = zi
alias lt = eza --icons --tree

# colors that i use in various locations
let main = "#fa694e"
let accent = "#fdf087"

# Custom commands
def __fzf_helper [
    type: string  # "f" or "d"
    preview_cmd: string
    action: string
    dir: string
] {
    let selected = (fd --type $type --hidden --exclude .git . $dir 
        | fzf --height 40% --reverse --preview $preview_cmd)
    
    if not ($selected | is-empty) {
        let path = ($selected | path expand)
        ^$action $path
    }
}

def snF [] { __fzf_helper "f" "bat --color=always --line-range :500 {}" "nvim" $env.HOME }
def snf [] { __fzf_helper "f" "bat --color=always --line-range :500 {}" "nvim" "." }
def snD [] { __fzf_helper "d" "tree -C" "nvim" $env.HOME }
def snd [] { __fzf_helper "d" "tree -C" "nvim" "." }
def la [path?: string] {
    let target = if $path != null { $path } else { "." }
    ls -la ($target) | select name type mode size modified
}

def fetch [] { fastfetch | lolcat --spread 0.8 }

def code [...args] {
    $env.ELECTRON_OZONE_PLATFORM = "wayland"
    /usr/bin/code --force-device-scale-factor=1 ...$args
}

def clear [] {
    ^clear ; 
    if ($env | columns | any {|col| $col == "TERM_PROGRAM"}) and $env.TERM_PROGRAM == "vscode" {
        # do nothing if in vscode
    } else {
        fetch
    }
}



$env.config = {
    show_banner: false
    edit_mode: vi
    buffer_editor: "nvim"
    render_right_prompt_on_last_line: true

    color_config: {
        header: { 
            fg: $main
        }
        row_index: {
            fg: $main
        }
    }
}

# For some reason wouldnt let me change these in the config
$env.config.cursor_shape.vi_insert = "blink_line"
$env.config.cursor_shape.vi_normal = "block"
$env.LS_COLORS = (vivid generate lava)

$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""

# General fzf color scheme
# $env.FZF_DEFAULT_OPTS = "--color=fg:#d8dee9,hl:#fa694e,fg+:#d8dee9,bg+:#2e2e2e,hl+:#fa694e --color=info:#fa694e,prompt:#fa694e,pointer:#fa694e,spinner:#fa694e,header:#5e81ac"
# ~/.config/nushell/modules/fzf.nu
export-env {
    let fzf_config = {
        foreground: "#d8dee9"
        highlight: $main
        background: "#2e2e2e"
        header: "#5e81ac"
    }

    $env.FZF_DEFAULT_OPTS = $"--color=fg:($fzf_config.foreground),hl:($fzf_config.highlight),fg+:($fzf_config.foreground),bg+:($fzf_config.background),hl+:($fzf_config.highlight) --color=info:($fzf_config.highlight),prompt:($fzf_config.highlight),pointer:($fzf_config.highlight),spinner:($fzf_config.highlight),header:($fzf_config.header)"
}
# Initial fetch
if ($env | columns | any {|col| $col == "TERM_PROGRAM"}) and $env.TERM_PROGRAM == "vscode" {
# do nothing if in vscode
} else {
    fetch
}
