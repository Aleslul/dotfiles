#!/bin/bash

# Detecta si el WiFi está activado
if rfkill list wifi | grep -q "Soft blocked: no"; then
    # Si está activado, desactiva el WiFi
    rfkill block wifi
else
    # Si está desactivado, activa el WiFi
    rfkill unblock wifi
fi