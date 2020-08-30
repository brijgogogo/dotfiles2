#!/bin/bash

sys_files_path="/home/vik/sys_files"

ln -s $sys_files_path/10-monitors.conf /etc/X11/xorg.conf.d/
ln -s $sys_files_path/30-touchpad.conf /etc/X11/xorg.conf.d/

