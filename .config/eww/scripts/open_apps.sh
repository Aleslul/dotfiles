#!/bin/bash

WORKSPACE=$1
APP_COMMAND=$2

if [ -z "$WORKSPACE" ] || [ -z "$APP_COMMAND" ]; then
    echo "Uso: $0 <workspace> <comando>"
    exit 1
fi

hyprctl dispatch workspace "$WORKSPACE"

$APP_COMMAND &

sleep 0.5
WINDOW_PID=$!
hyprctl dispatch movetoworkspace "$WORKSPACE" address:"pid:$WINDOW_PID"
