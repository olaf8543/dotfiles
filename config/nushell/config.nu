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

# Disable welcome banner
$env.config.show_banner = false

# Aliases
alias hamil = kitty +kitten ssh orl6135@hamilton.se.rit.edu
alias nv = nvim .
alias gt = lazygit

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
def cds [] { __fzf_helper "d" "tree -C" "cd" $env.HOME }
def fetch [] { fastfetch | lolcat --spread 0.8 }

def code [...args] {
    $env.ELECTRON_OZONE_PLATFORM = "wayland"
    /usr/bin/code --force-device-scale-factor=1 ...$args
}

def clear [...args] {
    ^clear ; 
    if ($env | columns | any {|col| $col == "TERM_PROGRAM"}) and $env.TERM_PROGRAM == "vscode" {
        # do nothing if in vscode
    } else {
        fetch
    }
}

# Zoxide integration
source ~/.config/nushell/zoxide.nu
alias cd = z

# PATH configuration
$env.PATH = ($env.PATH | split row (char esep) | append "~/pypr-env/bin")
$env.PATH = ($env.PATH | split row (char esep) | append "~/lolcat/bin")

# Miscellanious configuration
# General fzf color scheme
$env.FZF_DEFAULT_OPTS = "--color=fg:#d8dee9,hl:#00ffa7,fg+:#d8dee9,bg+:#2e2e2e,hl+:#00ffa7 --color=info:#00ffa7,prompt:#00ffa7,pointer:#00ffa7,spinner:#00ffa7,header:#5e81ac"

# Initial fetch
if ($env | columns | any {|col| $col == "TERM_PROGRAM"}) and $env.TERM_PROGRAM == "vscode" {
# do nothing if in vscode
} else {
    fetch
}
