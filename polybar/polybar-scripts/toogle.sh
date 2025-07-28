#!/bin/sh

if [ $1 = cpu ]; then
    state=$(cat "/home/oedada/.config/polybar/polybar-scripts/flag_cpu"|| echo 0)
    echo $((1-"$state")) > "/home/oedada/.config/polybar/polybar-scripts/flag_cpu"
elif [ $1 = gpu ]; then
    state=$(cat "/home/oedada/.config/polybar/polybar-scripts/flag_gpu"|| echo 0)
    echo "$state"
    echo $((1-"$state")) > "/home/oedada/.config/polybar/polybar-scripts/flag_gpu"
fi
