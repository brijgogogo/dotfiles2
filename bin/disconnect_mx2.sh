#! /bin/bash
#systemctl start bluetooth.service
#sleep 1
MAC=$(bluetoothctl -- devices | grep "MX Master 2S" | awk '{print $2}')
echo -e "power on\ndisconnect $MAC \npower off\nquit" | bluetoothctl

