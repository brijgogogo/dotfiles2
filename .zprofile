# read .zshrc
# [[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -f "$HOME/.commonrc" ]; then
  source "$HOME/.commonrc"
fi


# Start graphical server on tty1 if not already running.
# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1


