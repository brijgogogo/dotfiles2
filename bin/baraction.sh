#!/bin/bash
# Used by Spectrwm

##############################
#	    DISK
##############################

hdd1() {
	  # hdd="$(df -h /home | grep /dev | awk '{print $3 " / " $5}')"
	  hdd="$(df -h /home | grep /dev | awk '{print $4}')"
	    echo -e "$hdd"
    }
hdd2() {
	  hdd="$(df -h /home/docs | grep /dev | awk '{print $4}')"
	    echo -e "$hdd"
    }
##############################
#	    RAM
##############################

mem() {
used="$(free | grep Mem: | awk '{print $3}')"
total="$(free | grep Mem: | awk '{print $2}')"

totalh="$(free -h | grep Mem: | awk '{print $2}' | sed 's/Gi/G/')"

ram="$(( 200 * $used/$total - 100 * $used/$total ))%/$totalh "

echo $ram
}
##############################
#	    CPU
##############################

cpu() {
	  read cpu a b c previdle rest < /proc/stat
	    prevtotal=$((a+b+c+previdle))
	      sleep 0.5
	        read cpu a b c idle rest < /proc/stat
		  total=$((a+b+c+idle))
		    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
		      echo -e "  $cpu%"
	      }
##############################
#	    VOLUME
##############################

vol() {
  vol="$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")"
  echo -e " $vol"
}
##############################
#	    Packages
##############################

pkgs() {
	pkgs="$(dpkg -l | grep -c ^i)"
	echo -e " $pkgs"
}
##############################
#	    UPGRADES
##############################

upgrades() {
	upgrades="$(aptitude search '~U' | wc -l)"
	echo -e " $upgrades"
}
##############################
#	    VPN
##############################

vpn() {
	state="$(ip a | grep tun0 | grep inet | wc -l)"

if [ $state = 1 ]; then
    echo "on"
else
    echo "off"
fi
}
## WEATHER
weather() {
	wthr="$(sed 20q ~/.config/weather.txt | grep value | awk '{print $2 $3}' | sed 's/"//g')"
	echo " $wthr"
}

## TEMP
temp() {
	tmp="$(grep temp_F ~/.config/weather.txt | awk '{print $2}' | sed 's/"//g' | sed 's/,/ F/g')"
	echo " $tmp"
}

## BATTERY
bat() {
batstat="$(cat /sys/class/power_supply/BAT0/status)"
battery="$(cat /sys/class/power_supply/BAT0/capacity)"
    if [ $batstat = 'Unknown' ]; then
    batstat=""
    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
    batstat=""
    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
    batstat=""
    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
    batstat=""
    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
    batstat=""
    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
    batstat=""
    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
    batstat=""
fi

echo "$batstat $battery%"
}

network() {
wire="$(ip a | grep eth0 | grep inet | wc -l)"
wifi="$(ip a | grep wlan | grep inet | wc -l)"

if [ $wire = 1 ]; then
    echo ""
elif [ $wifi = 1 ]; then
    echo ""
else
    echo "睊 "
fi
}

      SLEEP_SEC=5
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do
    # echo "$(cpu)| $(mem)| $(pkgs)|﯁ $(upgrades)| $(hdd)| $(vpn)| $(vol)|$(bat)|$(weather) $(temp)| $(network)|"
    echo "$(cpu) |  $(mem) |  $(hdd1),$(hdd2) | $(vol) | $(bat) | $(network) |"
		sleep $SLEEP_SEC
		done
