# fetch
# paste -d ' ' <(cat ~/.config/neofetch/txtfiles/ror2.txt) <(neofetch) | lolcat --spread

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin" # because of custom lolcat
export JAVA_HOME=/usr/lib64/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Aliases

alias fetch="paste -d ' ' <(cat ~/.config/neofetch/txtfiles/ror2.txt) <(neofetch) | lolcat --spread 0.8"
alias hamil='kitty +kitten ssh orl6135@hamilton.se.rit.edu'
alias clearf="clear && fetch"
alias code="code --enable-features=UseOzonePlatform --ozone-platform=wayland"

# Keybinds

bindkey '^[[H' beginning-of-line     # Home key
bindkey '^[[F' end-of-line           # End key

# Current Directory

# Theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#autoload -U promptinit; promptinit
#prompt pure
#source ~/.zsh/pure-prompts.zsh

# Run on startup
# fetch

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Zsh Syntax Highlighting 
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.zsh/syntax-highlighting.zsh


# Load Angular CLI autocompletion.
source <(ng completion script)
