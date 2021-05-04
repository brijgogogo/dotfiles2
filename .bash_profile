#
# ~/.bash_profile
#

# read .bashrc
# if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
[[ -f ~/.bashrc ]] && . ~/.bashrc

#profile_file=~/.profile
#[[ -f $profile_file ]] && . $profile_file
# source $profile_file
# source /home/vik/.config/broot/launcher/bash/br

# export PATH="$HOME/go/bin:$PATH"

# source "$HOME/.cargo/env"


# Start graphical server on tty1 if not already running.
# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1


