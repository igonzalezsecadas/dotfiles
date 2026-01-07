#!/bin/bash
if pgrep -x "waybar" > /dev/null
then
    # Si existe, matamos el proceso
    pkill waybar
else
    # Si no existe, lo lanzamos en segundo plano
    waybar &
fi
