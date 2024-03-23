#!/bin/bash

# Necesito que cuando se ejecute el script me cargue en una lista las imagenes en una carpeta
# y que al elegir la foto me la ponga (xd) como fondo de pantalla usando swww
# y tambien cambiar los colores del waybar, el gtk y las ventanas de hypr

# al final me pase a rofi y termine adaptando parte de un script de los dotfiles de otro chabon

wallFolder="/home/lucho/wallpapers/"

wallList=($(ls "$wallFolder"/*.{png,jpg,jpeg} | xargs -n1 basename))

#selectedWall=$(printf '%s\n' "${wallList[@]}" | rofi -dmenu  -p "Choose a Wallpaper!")

cacheDir="${HOME}/.cache/wallCache"

rofi_override="element-icon{size:100px;border-radius:10px;}"
rofi_command="rofi -dmenu -theme ${HOME}/.config/rofi/WallSelect.rasi -theme-str ${rofi_override}"

# Create cache dir if existn't
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi


# Generete thumbnails
for imagen in "$wallFolder"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		nombre_archivo=$(basename "$imagen")
			if [ ! -f "${cacheDir}/${nombre_archivo}" ] ; then
				convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
			fi
    fi
done

// Launch Rofi
selectedWall=$(find "${wallFolder}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

if [ -n "$selectedWall" ]; then
	fullWall=$(find "$wallFolder" -name "$selectedWall" -type f)
	swww img "$fullWall" --transition-type wipe
	wal -i "$fullWall"
	killall -SIGUSR2 waybar 
fi
