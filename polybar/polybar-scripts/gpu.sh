#!/bin/sh

high_temp="󱃂" # #FF4500
med_temp="󰔏" # #FFD700
low_temp="󱃃" # #50C878
# std_color - #39FF14

temp=$(/usr/bin/nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits) 
gpu_utilization=$(/usr/bin/nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
dir="/home/oedada/.config/polybar/polybar-scripts/flag_gpu"
state=$(cat "$dir" || echo 0)

if [ "$state" -eq 0 ]; then
    echo "$temp" | awk -v gpu="$gpu_utilization" '{ 
    if (cpu < 40) 
        print "%{F#39FF14}GPU%{T2} %{T-}%{F-}%{F#50C878} " gpu "%%{F-}"
    else if (cpu < 70) 
        print "%{F#39FF14}GPU%{T2} %{T-}%{F-}%{F#FFD700} " gpu "%%{F-}"
    else 
        print "%{F#39FF14}GPU%{T2} %{T-}%{F-}%{F#FF4500} " gpu "%%{F-}"
    }'

else
    echo "$temp" | awk -v high="$high_temp" -v med="$med_temp" -v low="$low_temp" '{
    if ($1 < 61) 
        print "%{F#39FF14}GPU%{T2}%{F-}%{F#50C878} " low "%{T-} " $1 "°C%{F-}"
    else if ($1 < 76) 
        print "%{F#39FF14}GPU%{T2}%{F-}%{F#FFD700} " med "%{T-} " $1 "°C%{F-}"
    else 
        print "%{F#39FF14}GPU%{T2}%{F-}%{F#FF4500} " high "%{T-} " $1 "°C%{F-}"
    }'
fi
#8AFFB7
