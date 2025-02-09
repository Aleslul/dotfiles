#!/bin/bash

cpu() {
    awk -v FS=" " '/^cpu / {usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f%%\n", usage}' /proc/stat
}

cpu_raw() {
    awk -v FS=" " '/^cpu / {usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f\n", usage}' /proc/stat
}

ram() {
    free -h | awk '/^Mem:/ {printf "%s", $3, $2}'
}

disk() {
    df -h | awk '/^\/dev\/sda1/ {printf "%s", $3, $2}'
}

temp-icon() {
    temp=$(sensors | grep -A 0 'temp1' | cut -c16-17)

    if [ "$temp" -lt 50 ]; then
        echo ""  # Temperatura baja
    elif [ "$temp" -ge 50 ] && [ "$temp" -lt 70 ]; then
        echo ""  # Temperatura media
    else
        echo ""  # Temperatura alta
    fi
}

if [ "$1" = "--cpu" ]; then
    cpu
elif [ "$1" = "--cpu-raw" ]; then
    cpu_raw
elif [ "$1" = "--ram" ]; then
    ram
elif [ "$1" = "--disk" ]; then
    disk
elif [ "$1" = "--temp-icon" ]; then
    temp-icon
else
    echo "Usage: $0 {--cpu|--cpu-raw|--ram|--disk|--temp-icon}"
    exit 1
fi
