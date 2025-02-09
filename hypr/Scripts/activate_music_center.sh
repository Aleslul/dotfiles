#!/bin/bash

WIDGET_NAME="musiccenter"
TIMER_FILE="/tmp/eww_widget_timer"

# Función para verificar si el widget está abierto
is_widget_open() {
    eww windows | grep -q "$WIDGET_NAME"
}

# Función para abrir el widget solo si no está abierto
toggle_widget() {
    if ! is_widget_open; then
        eww open "$WIDGET_NAME" &
    fi

    # Actualizar el temporizador
    reset_timer
}

# Función para cerrar el widget después de 4 segundos de inactividad
reset_timer() {
    # Si hay un temporizador activo, cancélalo
    if [ -f "$TIMER_FILE" ]; then
        kill "$(cat $TIMER_FILE)" 2>/dev/null
        rm "$TIMER_FILE"
    fi

    # Iniciar un nuevo temporizador para cerrar el widget después de 4 segundos
    (sleep 4 && eww close "$WIDGET_NAME") &
    echo $! > "$TIMER_FILE"
}

# Funciones de control de música
next() {
    playerctl next
    toggle_widget
}

prev() {
    playerctl previous
    toggle_widget
}

play() {
    playerctl play-pause
    toggle_widget
}

# Manejador de argumentos
case "$1" in
    --next) next ;;
    --prev) prev ;;
    --play) play ;;
    *) echo "Invalid argument" ;;
esac
