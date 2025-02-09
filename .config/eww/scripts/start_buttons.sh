#!/bin/bash

whatsapp() {
    /home/aleslul/.webcatalog/WhatsApp/WhatsApp &
}

discord() {
    discord &
}

spotify() {
    spotify &
}

zen-browser() {
    zen-browser &
}

canva() {
    /home/aleslul/.webcatalog/Canva/Canva &
}

notion() {
    /home/aleslul/.webcatalog/Notion/Notion &
}

libreoffice() {
    libreoffice --writer &
}

steam() {
    steam &
}

heroic() {
    heroic &
}

thunar() {
    thunar &
}

android-studio() {
    android-studio &
}

alacrity() {
    alacrity &
}

if [ "$1" = "--whatsapp" ]; then
    whatsapp
elif [ "$1" = "--discord" ]; then
    discord
elif [ "$1" = "--spotify" ]; then
    spotify
elif [ "$1" = "--zen-browser" ]; then
    zen-browser
elif [ "$1" = "--canva" ]; then
    canva
elif [ "$1" = "--notion" ]; then
    notion
elif [ "$1" = "--libreoffice" ]; then
    libreoffice
elif [ "$1" = "--steam" ]; then
    steam
elif [ "$1" = "--heroic" ]; then
    heroic
elif [ "$1" = "--thunar" ]; then
    thunar
elif [ "$1" = "--android-studio" ]; then
    android-studio
elif [ "$1" = "--alacrity" ]; then
    alacrity
else
    echo "Usage: $0 {whatsapp|discord|spotify|zen-browser|canva|notion|libreoffice|steam|heroic|thunar|android-studio|alacrity}"
    exit 1
fi