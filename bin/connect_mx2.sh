#! /bin/bash
#systemctl start bluetooth.service
#sleep 1
MAC=$(bluetoothctl -- devices | grep "MX Master 2S" | awk '{print $2}')
echo $MAC
bluetoothctl -- power on
sleep 1
echo -e "connect $MAC \nquit" | bluetoothctl

