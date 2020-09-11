#!/usr/bin/env bash

set -e

arr=($(xrandr --listactivemonitors | sed -E "{/Monitors/d;s/^\s[0-9]:\s*\+(.?[A-Z]*.?)\s*(.*)/\1/g;s/\*(.*)/\1/g}" | tr ' ' '\n'))
for n in "${arr[@]}";do
	if [ -z $STARTED ];then
		tmp=("TRUE $n")
		STARTED=1
	else
		tmp=("${tmp[@]} FALSE $n")
	fi
done
NEWPRIMARY=$(zenity --list --radiolist --title 'Primary Screen' --text 'Select primary screen:' --column 'Select' --column 'Scan Type' ${tmp[@]}) 
xrandr --output $NEWPRIMARY --primary


