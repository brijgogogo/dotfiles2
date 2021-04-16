#!/bin/bash

sys_files_path="/home/vik/sys_files"

# ln -s $sys_files_path/10-monitor.conf /etc/X11/xorg.conf.d/
# ln -s $sys_files_path/30-touchpad.conf /etc/X11/xorg.conf.d/
# ln -s $sys_files_path/00-keyboard.conf /etc/X11/xorg.conf.d/

cp $sys_files_path/10-monitor.conf /etc/X11/xorg.conf.d/
cp $sys_files_path/30-touchpad.conf /etc/X11/xorg.conf.d/
cp $sys_files_path/00-keyboard.conf /etc/X11/xorg.conf.d/
cp $sys_files_path/10-nvidia-drm-outputclass.conf /usr/share/X11/xorg.conf.d/
