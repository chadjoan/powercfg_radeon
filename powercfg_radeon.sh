#!/usr/bin/env bash

_done="false"

echo "This is a script for setting the power settings for Radeon graphics cards."
echo "There are three power states: battery, balanced, performance"
echo "Each power state has several performance levels: auto, low, high"

while [ "$_done" == "false" ]; do
	#echo "you can change between these states by echoing to the following parameter"
	echo ""
	echo "Current power state..."
	echo "power_dpm_state:                   $(cat /sys/class/drm/card1/device/power_dpm_state)"

	#you can also change between them by echoing to the following:
	echo ""
	echo "Current performance level..."
	echo "power_dpm_force_performance_level: $(cat /sys/class/drm/card1/device/power_dpm_force_performance_level)"

	echo ""
	echo "What power setting do you want?"
	echo "Type one of the below keywords and hit enter."
	echo "exit"
	echo "quit or q"
	echo "battery     - Sets power state to 'battery'"
	echo "balanced    - Sets power state to 'balanced'"
	echo "performance - Sets power state to 'performance'"
	echo "low         - Sets performance level to 'low'"
	echo "auto        - Sets performance level to 'auto'"
	echo "high        - Sets performance level to 'high'"
	echo "l           - Sets power state to 'battery' and performance level to 'low'"
	echo "m           - Sets power state to 'balanced' and performance level to 'auto'"
	echo "h           - Sets power state to 'performance' and performance level to 'high'"
	echo "You may also type nothing and hit enter to exit while leaving everything unchanged."
	read level

	if [ "$level" == "exit" ] || [ "$level" == "quit" ] || [ "$level" == "q" ] || [[ ! $level ]]; then
		_done="true"
		echo "Exiting."
	elif [ "$level" == "battery" ]; then
		echo "battery" > /sys/class/drm/card1/device/power_dpm_state
	elif [ "$level" == "balanced" ]; then
		echo "balanced" > /sys/class/drm/card1/device/power_dpm_state
	elif [ "$level" == "performance" ]; then
		echo "performance" > /sys/class/drm/card1/device/power_dpm_state
	elif [ "$level" == "low" ]; then
		echo "low" > /sys/class/drm/card1/device/power_dpm_force_performance_level
	elif [ "$level" == "auto" ]; then
		echo "auto" > /sys/class/drm/card1/device/power_dpm_force_performance_level
	elif [ "$level" == "high" ]; then
		echo "high" > /sys/class/drm/card1/device/power_dpm_force_performance_level
	elif [ "$level" == "l" ]; then
		echo "battery" > /sys/class/drm/card1/device/power_dpm_state
		echo "low" > /sys/class/drm/card1/device/power_dpm_force_performance_level
	elif [ "$level" == "m" ]; then
		echo "balanced" > /sys/class/drm/card1/device/power_dpm_state
		echo "auto" > /sys/class/drm/card1/device/power_dpm_force_performance_level
	elif [ "$level" == "h" ]; then
		echo "performance" > /sys/class/drm/card1/device/power_dpm_state
		echo "high" > /sys/class/drm/card1/device/power_dpm_force_performance_level
	elif [[ $level ]]; then
		echo "'$level' is not a valid input."
		echo "Valid options are 'battery', 'balanced', and 'performance'."
		echo "The input is case-sensitive. (Sorry.)"
	fi
done

exit
