# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vik/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


if [ -f "$HOME/.commonrc" ]; then
  source "$HOME/.commonrc"
fi

# FZF configuration
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
