#!/bin/bash
intern=DP-4
extern1=DP-0
extern2=HDMI-0
 
ext1_on=$(xrandr | grep "$extern1 connected")
ext2_on=$(xrandr | grep "$extern2 connected")

if [ ! -z "$ext1_on" ]
	xrandr --output "$extern1" --auto --output "$extern2" --off --output "$intern" --auto --right-of "$extern1"
then
	echo "1"
elif [ ! -z "$ext2_on" ]
then
	xrandr --output "$extern2" --auto --output "$extern1" --off --output "$intern" --auto --right-of "$extern2"
else
	xrandr --output "$extern2" --off --output "$extern1" --off --output "$intern" --auto
fi

setbg
