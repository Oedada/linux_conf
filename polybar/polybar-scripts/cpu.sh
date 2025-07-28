#!/bin/sh

high_temp="󱃂"
med_temp="󰔏"
low_temp="󱃃"

cpu_temp=$(sensors | awk 'NR > 61{print substr($2, 2, 2)}')
cpu_utilization=$(mpstat -u | awk 'NR > 3{print 100 - substr($13, 1, 2)}')
dir="/home/oedada/.config/polybar/polybar-scripts/flag_cpu"
state=$(cat "$dir" || echo 0)

if [ "$state" -eq 0 ]; then
    echo "$temp" | awk -v cpu="$cpu_utilization" '{ 
    if (cpu < 40) 
        print "%{F#39FF14}CPU%{T2} %{T-}%{F-}%{F#50C878} " cpu "%%{F-}"
    else if (cpu < 70) 
        print "%{F#39FF14}CPU%{T2} %{T-}%{F-}%{F#FFD700} " cpu "%%{F-}"
    else 
        print "%{F#39FF14}CPU%{T2} %{T-}%{F-}%{F#FF4500} " cpu "%%{F-}"
    }'

else
    echo "$cpu_temp" | awk -v high="$high_temp" -v med="$med_temp" -v low="$low_temp" '{
    if ($1 < 61) 
        print "%{F#39FF14}CPU%{T2}%{F-}%{F#50C878} " low " %{T-}" $1 "°C%{F-}"
    else if ($1 < 76) 
        print "%{F#39FF14}CPU%{T2}%{F-}%{F#FFD700} " med " %{T-} " $1 "°C%{F-}"
    else 
        print "%{F#39FF14}CPU%{T2}%{F-}%{F#FF4500} " high " %{T-} " $1 "°C%{F-}"
    }'
fi
