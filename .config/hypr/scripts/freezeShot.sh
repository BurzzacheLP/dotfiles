#!/bin/sh
#
# rudimentary script to take screen shots like in windows, freezing the current state of the entire screen, then allowing you to select what is neccesary

### Variables ###

cacheDir="${HOME}/.cache/freezeCache"


## Check if cacheDir exists

if [ ! -d "${cacheDir}" ] ; then
	mkdir -p "${cacheDir}"
fi

## Save a temp screenshot of the whole screen
grim  "$cacheDir"/"$(date +%Y%m%d-%H%M%S)".png

## set it to fullscreen and allow the selection
feh -F "$cacheDir" & slurp | grim -g - - | wl-copy ; killall feh

rm -r "$cacheDir"

