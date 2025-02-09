#!/bin/bash

dev() {
    thunar ~/dev &
}
documents() {
    thunar ~/Documentos &
}
donwloads() {
    thunar ~/Descargas &
}
uni() {
    thunar ~/UNI &
}
images() {
    thunar ~/Imágenes &
}
configFolder() {
    thunar ~/.config &
}
localFolder() {
    thunar ~/.local &
}

if [[ "$1" == "--dev" ]]; then
    dev
elif [[ "$1" == "--docs" ]]; then
    documents
elif [[ "$1" == "--down" ]]; then
    donwloads
elif [[ "$1" == "--uni" ]]; then
    uni
elif [[ "$1" == "--img" ]]; then
    images
elif [[ "$1" == "--config" ]]; then
    configFolder
elif [[ "$1" == "--local" ]]; then
    localFolder
else
    echo "Invalid option"
fi