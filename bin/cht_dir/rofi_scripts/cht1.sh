#!/bin/bash

list_cheatsheets()
{
    # Initialise and read config
    sheets_dir=""
    conf=$HOME/.config/cht.conf

    if [ -f $conf ]; then
        . $conf
    fi

    if [ -z "$sheets_dir" ]; then
        sheets_dir="$HOME/Documents/wiki/cheatsheets"
    fi

    cd "$sheets_dir"
    # Find interesting files, remove the leading "./" and exclude _files
    # directories that contain image files, CSS, etc that are created by
    # web browsers when saving a web page.
    find -regex '.*\.\(txt\|png\|jpg\|pdf\|html\|md\)' | sed 's@^\./@@' | egrep -v '_files\/' | sort
}

cheatsheet=$( (list_cheatsheets) | rofi -dmenu -i -hide-scrollbar -p "Select cheatsheet")

if [ -n "${cheatsheet}" ]
then
    cht --spawn "${cheatsheet}"
fi
