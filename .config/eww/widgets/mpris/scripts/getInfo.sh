#!/bin/sh

select_player () {
	currentPlayer = ""
	coverPlayer= ""
	totalPlayer= ""
	playerctl -l 2> /dev/null | while read -r player;
	do
		art=`playerctl --player="$player" metadata mpris:artUrl 2> /dev/null`
		status=`playerctl --player="$player" status 2> /dev/null`

		[[ $status == "Playing" ]] && currentPlayer="$player"
		[[ $art != ""]] && coverPlayer="$player"
		[[ $status == "Playing" && $art != "" ]] && totalPlayer="$player"
		[[ ! -z $coverPlayer ]] && player="$coverPlayer"
		[[ ! -z $playingPlayer ]] && player="$currentPlayer"
		[[ ! -z $totalPlayer ]] && player="$totalPlayer"
		echo "$player"
	done;
}

# Get general info
eww="eww -c $HOME/.config/eww/widgets/mpris"
player=`select_player | tail -1`
status=`playerctl --player="$player" status 2> /dev/null`
[[ $status == "" ]] && exit
