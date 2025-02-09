#!/bin/bash

## Datos necesarios
API_KEY="e67af2612f492e5be9f5ea03bfe293e9"
CITY_ID="3693584"
UNIT="metric"  # Cambia a "imperial" si prefieres grados Fahrenheit.

## Obtener datos del clima
weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=${API_KEY}&id=${CITY_ID}&units=${UNIT}")
if [ ! -z "$weather" ]; then
    temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    icon_code=$(echo "$weather" | jq -r ".weather[0].icon")

    # Determinar el ícono y color en HEX
    case $icon_code in
        "01d") icon=" "; color="#FFD700" ;;  # Soleado día (Amarillo dorado)
        "01n") icon=" "; color="#1E90FF" ;;  # Soleado noche (Azul claro)
        "02d" | "02n") icon=" "; color="#87CEEB" ;;  # Parcialmente nublado (Azul cielo)
        "03d" | "03n") icon=" "; color="#B0C4DE" ;;  # Nublado (Azul grisáceo)
        "04d" | "04n") icon=" "; color="#696969" ;;  # Muy nublado (Gris oscuro)
        "09d" | "09n") icon=" "; color="#4682B4" ;;  # Lluvia ligera (Azul acero)
        "10d" | "10n") icon=" "; color="#0000FF" ;;  # Lluvia (Azul)
        "11d" | "11n") icon=" "; color="#FF4500" ;;  # Tormenta (Naranja rojizo)
        "13d" | "13n") icon=" "; color="#FFFFFF" ;;  # Nieve (Blanco)
        "50d" | "50n") icon=" "; color="#D3D3D3" ;;  # Neblina (Gris claro)
        *) icon=" "; color="#808080" ;;              # Desconocido (Gris)
    esac

    # Mostrar según el parámetro
    case $1 in
        --icon)
            echo "${icon}"
            ;;
        --label)
            echo "${temp}°C"
            ;;
        --color)
            echo "${color}"
            ;;
        *)
            echo "Uso: $0 [--icon | --label | --color]"
            exit 1
            ;;
    esac
else
    echo "No se pudo obtener el clima."
fi
