#!/bin/bash
intern=DP-4
extern1=DP-2
extern2=HDMI-0

ext1_on=$(xrandr | grep "$extern1 connected")
ext2_on=$(xrandr | grep "$extern2 connected")

if [ ! -z "$ext1_on" ] && [ ! -z "$ext2_on" ]
then
  xrandr --output "$extern1" --mode 1920x1080 --pos 0x0 --rotate normal --output "$extern2" --mode 2560x1440 --pos 1920x0 --rotate normal --output "$intern" --off
elif [ ! -z "$ext2_on" ]
then
	xrandr --output "$extern2" --auto --output "$intern" --off
elif [ ! -z "$ext1_on" ]
then
	xrandr --output "$extern1" --auto --output "$intern" --off
else
	xrandr --output "$intern" --auto
fi

setbg
