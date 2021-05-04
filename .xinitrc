#!/bin/sh
# xinitrc runs automatically when you run startx.

xprofile_file=$HOME/.xprofile
[ -f $xprofile_file ] && . $xprofile_file

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Set DISPLAY environment variable
# https://wiki.archlinux.org/index.php/Dunst#Dunst_fails_to_start_via_systemd
systemctl --user import-environment DISPLAY


# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# keyboard key remapping
remaps &

# Run eye care
redshift &

picom &

# Set wallpaper
setbg &

# Notification daemon
dunst &

# Hide cursor/mouse when idle
unclutter &

# lock system if idle
run_xidlehook &

# Mute mic
mute-mic

#

# sleep .5 && chromium &
# sleep .5 && "$TERMINAL" &

# connect-2-monitors-h # 10-monitor.conf is not working. This will show extra flicker on startup
# connect-one-monitor

# start dwm in tty1 and i3 in tty2
#if [[ $XDG_VTNR -eq 1 ]]; then
  # exec dwm
  # exec startdwm
  # exec spectrwm
  exec xmonad
notify-send "Welcome!!"
#elif [[ $XDG_VTNR -eq 2 ]]; then
#  export DESKTOP_SESSION=plasma
#  exec startplasma-x11
  # exec i3
#elif [[ $XDG_VTNR -eq 3 ]]; then
  # exec startxfce4
#fi

# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login
