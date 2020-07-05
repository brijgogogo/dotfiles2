#! /bin/bash
#systemctl start bluetooth.service
#sleep 1
MAC=$(bluetoothctl -- devices | grep "AnnePro2" | awk '{print $2}')
echo -e "power on\ndisconnect $MAC \npower off\nquit" | bluetoothctl

