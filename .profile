# Profile file. Runs on login. Environmental variables are set here.

# Paths
export PATH="$HOME/bin:$PATH"

# window manager
export MY_WM="dwm"

# Default programs:
export EDITOR="nvim"
export VISUAL='nvim'
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export FILE="nnn"
export STATUSBAR="${MY_WM}blocks"

# read .bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi


# nnn
export NNN_BMS='d:~/docs/;D:~/Downloads/;c:~/docs/cloud/;s:~/docs/screenshots/;w:~/docs/work/' ## bookmarks
export NNN_USE_EDITOR=1                                 # use the $EDITOR when opening text files
export NNN_PLUG='o:fzopen;p:mocplay;d:diffs;m:nmount;n:notes;v:imgviu;t:imgthumb' # nnn plugins

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

# FZF
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --ignore'
# source /usr/share/fzf/key-bindings.bash
# source /usr/share/fzf/completion.bash

source /usr/share/bash-completion/bash_completion
source ~/bin/buku-completion.bash

export HISTCONTROL=ignoredups # ignore duplicates in bash history
shopt -s autocd # auto cd when entering just a path

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
