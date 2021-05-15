# ~/.bashrc

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

if [ -f "$HOME/.commonrc" ]; then
  source "$HOME/.commonrc"
fi


# vi mode in bash
set -o vi

RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
PURPLE="\[$(tput setaf 4)\]"
PINK="\[$(tput setaf 5)\]"
BLUE="\[$(tput setaf 6)\]"
GRAY="\[$(tput setaf 7)\]"
RESET="\[$(tput sgr0)\]"

# prompt
# export PS1="${BLUE}\u${GRAY}@${YELLOW}\h${GREEN}:${PURPLE}\W${RESET}$ "
# export PS1="┌──\u@\h[\w]\n└─╼ "
export PS1="┌──${BLUE}\u${GRAY}@${YELLOW}\h${GREEN}:${PURPLE}\W\n└─╼ ${RESET}$ "

# export PS1="\[\e[38;2;224;108;117m\]\h \[\e[38;2;97;175;239m\]\w \[\e[m\]\$ "

# cd on quit of nnn
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# search buku using fzf
# https://github.com/junegunn/fzf/wiki/examples
fb() {
    # save newline separated string into an array
    mapfile -t website <<< "$(buku -p -f 5 | column -ts$'\t' | fzf --multi)"

    # open each website
    for i in "${website[@]}"; do
        index="$(echo "$i" | awk '{print $1}')"
        buku -p "$index"
        buku -o "$index"
    done
}

# fd - cd to selected directory
# fd() {
#   local dir
#   dir=$(find ${1:-.} -path '*/\.*' -prune \
#                   -o -type d -print 2> /dev/null | fzf +m) &&
#   cd "$dir"
# }


# get to scripts quickly
# se() { find ~/bin -type f | fzf | xargs -r $EDITOR; }

# search history
# use C-R
# h() { history | fzf --tac --no-sort | awk 'BEGIN { ORS=" "}; { for(n = 4; n <= NF; n++) print $n;}' | xclip -sel clip ; }

export HISTCONTROL=ignoreboth:erasedups
# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
# number of lines in the history file
export HISTFILESIZE=
# number of entries in history file
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


# source /home/vik/.config/broot/launcher/bash/br
# export PATH="$HOME/.cargo/bin:$PATH"

# source /home/vik/.config/broot/launcher/bash/br
#source "$HOME/.cargo/env"


# nnn
export NNN_BMS='d:~/docs/;D:~/Downloads/;c:~/docs/cloud/;s:~/docs/screenshots/;w:~/docs/work/' ## bookmarks
export NNN_USE_EDITOR=1                                 # use the $EDITOR when opening text files
export NNN_PLUG='o:fzopen;p:mocplay;d:diffs;m:nmount;n:notes;v:imgviu;t:imgthumb' # nnn plugins
# export NNN_COLORS="2136"
# BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
# export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"


# FZF configuration
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# bash history completion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

source ~/bin/buku-completion.bash

# export HISTCONTROL=ignoredups # ignore duplicates in bash history
# shopt -s autocd # auto cd when entering just a path


# source "$HOME/.cargo/env"

