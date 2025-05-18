# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/oh/.zshrc'

# Path Variable 
export PATH="$PATH:$HOME/Downloads/SonarScanner/bin" #because of 261
export JAVA_HOME=/usr/lib64/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Aliases

alias fetch="paste -d ' ' <(cat ~/.config/neofetch/txtfiles/ror2.txt) <(neofetch) | lolcat --spread 0.8"
alias hamil='kitty +kitten ssh orl6135@hamilton.se.rit.edu'
alias clearf="clear && fetch"
alias lg="lazygit"

# Keybinds

bindkey '^[[H' beginning-of-line     # Home key
bindkey '^[[F' end-of-line           # End key

# Current Directory

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Load Angular CLI autocompletion.
source <(ng completion script)
