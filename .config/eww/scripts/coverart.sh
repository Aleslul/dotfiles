#!/bin/bash

# Configuración de rutas
CONFIG_DIR="$HOME/.config/eww"
COVER_ART_FILE="$CONFIG_DIR/coverart.png"
INFO_FILE="$CONFIG_DIR/info.txt"

# Obtener la información de la canción
current_title=$(playerctl metadata --format "{{ title }}" 2>/dev/null)
url=$(playerctl metadata --format "{{ mpris:artUrl }}" 2>/dev/null | sed 's/b273/1e02/')

# Si no hay canción o URL, salir
if [[ -z "$current_title" || -z "$url" ]]; then
    echo ""
    exit 0
fi

# Leer el título de la última canción (si existe)
if [[ -f "$INFO_FILE" ]]; then
    last_title=$(cat "$INFO_FILE")
else
    last_title=""
fi

# Si la URL es local (file://), eliminar el prefijo 'file://'
if [[ "$url" == file://* ]]; then
    url=${url#file://}
    echo "$url"
    exit 0
fi

# Si la URL es remota (http/https), descargar la imagen temporalmente
if [[ "$url" == http* ]]; then
    temp_image="/tmp/spotify_cover.jpg"
    curl -s "$url" -o "$temp_image"
    echo "$temp_image"
    exit 0
fi

# Si no es ninguna de las opciones anteriores, salir
echo ""
exit 0
