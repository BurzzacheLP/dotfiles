#!/bin/bash

# Necesito que cuando se ejecute el script me cargue en una lista las imagenes en una carpeta
# y que al elegir la foto me la ponga (xd) como fondo de pantalla usando swww
# y tambien cambiar los colores del waybar, el gtk y las ventanas de hypr

# Script segun ChatGPT
# Poner el fondo con swww

wallFolder="/home/lucho/Imágenes/Wallpapers"

wallList=($(ls "$wallFolder"/*.{png,jpg,jpeg} | xargs -n1 basename))

selectedWall=$(printf '%s\n' "${wallList[@]}" | rofi -dmenu  -p "Choose a Wallpaper!")

echo $selectedWall > currentWall.conf 

if [ -n "$selectedWall" ]; then
	fullWall=$(find "$wallFolder" -name "$selectedWall" -type f)
	swww img "$fullWall" --transition-type wipe --transition-fps 60
	wal -i "$fullWall"
	killall -SIGUSR2 waybar 
fi


