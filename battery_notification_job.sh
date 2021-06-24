#!/bin/bash

bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'

# This gets the integer percentage of current battery capacity
p=$(eval $bat | grep 'percentage' | awk '{print $2}' | awk -F '.' '{print $1}')

battery_low='herbe "Unplug me Please," " " "I am too FULL"'
battery_full='herbe "Charge me Please," " " "I am gonna SHUTDOWN"'

if upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state"=="charging"; then 
	# if bat > 99% -> notify
	if [ "$p" -gt 99 ] ; then
		eval $battery_full
	fi

else
	# if bat < 15% -> notify
	if [ "$p" -le 15 ] ; then
		eval $battery_low
	fi

fi
