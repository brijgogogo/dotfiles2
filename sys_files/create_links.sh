#!/bin/bash

sys_files_path="/home/vik/sys_files"

# ln -s $sys_files_path/10-monitor.conf /etc/X11/xorg.conf.d/
# ln -s $sys_files_path/30-touchpad.conf /etc/X11/xorg.conf.d/
# ln -s $sys_files_path/00-keyboard.conf /etc/X11/xorg.conf.d/

cp $sys_files_path/10-monitor.conf /etc/X11/xorg.conf.d/
cp $sys_files_path/30-touchpad.conf /etc/X11/xorg.conf.d/
cp $sys_files_path/00-keyboard.conf /etc/X11/xorg.conf.d/
cp $sys_files_path/10-nvidia-drm-outputclass.conf /usr/share/X11/xorg.conf.d/

# https://wiki.archlinux.org/title/Xmonad
# Problems with finding shared libraries after update
mkdir /etc/pacman.d/hooks
cp $sys_files_path/hooks/* /etc/pacman.d/hooks
