#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 --title | --arturl | --artist | --length | --album | --source | --status"
	exit 1
fi

# Function to get the current player with priority to Spotify
get_active_player() {
    players=$(playerctl -l 2>/dev/null)
    for player in $players; do
        if [[ "$player" == *"spotify"* ]]; then
            status=$(playerctl -p "$player" status 2>/dev/null)
            if [[ "$status" == "Playing" ]]; then
                echo "$player"
                return
            fi
        fi
    done

    for player in $players; do
        status=$(playerctl -p "$player" status 2>/dev/null)
        if [[ "$status" == "Playing" ]]; then
            echo "$player"
            return
        fi
    done
}

# Set the active player to query
active_player=$(get_active_player)

# If no active player is found, exit early
if [ -z "$active_player" ]; then
    echo ""
    exit 0
fi

# Function to get metadata from the active player
get_metadata() {
    key=$1
    playerctl -p "$active_player" metadata --format "{{ $key }}" 2>/dev/null
}

# Parse the argument
case "$1" in
--title)
    title=$(get_metadata "xesam:title")
    echo "${title:0:28}"
    ;;
--arturl)
    url=$(get_metadata "mpris:artUrl")
    if [[ "$url" == file://* ]]; then
        # Si es local, quita el prefijo 'file://'
        url=${url#file://}
        echo "$url"
    elif [[ "$url" == http* ]]; then
        # Si es remoto, descarga temporalmente la imagen
        temp_image="/tmp/spotify_cover.jpg"
        curl -s "$url" -o "$temp_image"
        echo "$temp_image"
    else
        echo "" # Si no hay URL, devuelve vacío
    fi
    ;;
--artist)
    artist=$(get_metadata "xesam:artist")
    echo "${artist:0:30}"
    ;;
--length)
    length=$(get_metadata "mpris:length") # Obtiene la duración en microsegundos
    if [[ -n "$length" && "$length" -gt 0 ]]; then
        seconds=$((length / 1000000))       # Convierte microsegundos a segundos
        minutes=$((seconds / 60))           # Extrae los minutos
        remaining_seconds=$((seconds % 60)) # Calcula los segundos restantes
        printf "%dm:%02ds\n" "$minutes" "$remaining_seconds" # Formato amigable
    else
        echo "0m:00s"
    fi
    ;;

--status)
    status=$(playerctl -p "$active_player" status 2>/dev/null)
    if [[ $status == "Playing" ]]; then
        echo "󰎆"
    elif [[ $status == "Paused" ]]; then
        echo "󱑽"
    else
        echo ""
    fi
    ;;
--album)
    album=$(get_metadata "xesam:album")
    if [ -n "$album" ]; then
        echo "${album:0:20}"
    else
        echo "Not album"
    fi
    ;;
--source)
    if [[ "$active_player" == *"spotify"* ]]; then
        echo "Spotify "
    elif [[ "$active_player" == *"firefox"* ]]; then
        echo "Firefox 󰈹"
    elif [[ "$active_player" == *"chromium"* ]]; then
        echo "Chrome "
    else
        echo ""
    fi
    ;;
*)
    echo "Invalid option: $1"
    echo "Usage: $0 --title | --arturl | --artist | --length | --album | --source | --status"
    exit 1
    ;;
esac
