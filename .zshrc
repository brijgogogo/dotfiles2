# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTSIZE=100000
HISTFILE=~/.histfile
SAVEHIST=100000
setopt autocd beep extendedglob nomatch notify

# vi key bindings
bindkey -v

# zstyle :compinstall filename '/home/vik/.zshrc'

# autoload -Uz compinit

# basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
# auto complete with case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'left' vi-backward-char
# bindkey -M menuselect 'down' vi-down-line-or-history
# bindkey -M menuselect 'up' vi-up-line-or-history
# bindkey -M menuselect 'right' vi-forward-char
# Fix backspace bug when switching modes in vim editing at prompt
bindkey "^?" backward-delete-char

# hit space in visual/command mode to edit in vim/$EDITOR
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line
# '^X^E' = Ctrl + x , Ctrl + E

# Up/Down arrow keys search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down


if [ -f "$HOME/.commonrc" ]; then
  source "$HOME/.commonrc"
fi

# FZF configuration
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


# find-in-file - usage: fif <SEARCH_TERM>
# usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi

  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}


# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# powerlevel10k prompt/theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Custom ZSH Binds
# Ctrl+space to complete suggestion
bindkey '^ ' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/home/vik/.ghcup/env" ] && source "/home/vik/.ghcup/env" # ghcup-env


# Load Angular CLI autocompletion.
source <(ng completion script)
