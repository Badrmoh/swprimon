#!/usr/bin/env bash

set -ue

STATE_FILE=~/.swprimon_state
. $STATE_FILE

_init() {
	CMD=$(xrandr --listactivemonitors | sed -E "{/Monitors/d;s/^\s[0-9]:\s*\+(.?[A-Z]*.?)\s*(.*)/\1/g}")
	NEW_PRI_MON=$(echo $CMD | tr ' ' '\n' | grep "\*" | sed -E "s/\*(.*)/\1/g")
	arr=$(echo $CMD | sed -E "s/\*(.*)/\1/g")
        sed -i "s/\(NEW_PRI_MON\=\).*/\1\"${NEW_PRI_MON}\"/g" $STATE_FILE
	sed -i "s/\(MON_ARR\=\).*/\1\"${arr}\"/g" $STATE_FILE
        sed -i "s/\(INIT_STATE\=\).*/\10/g" $STATE_FILE
	. $STATE_FILE
}

_updateState() {
	arr=($MON_ARR)
	arr=(${arr[@]:1} ${arr[0]})
	NEW_PRI_MON="${arr}"
	arr="${arr[@]}"
	sed -i "s/\(NEW_PRI_MON\=\).*/\1\"${NEW_PRI_MON}\"/g" "$STATE_FILE"
        sed -i "s/\(MON_ARR\=\).*/\1\"${arr}\"/g" "$STATE_FILE"
	. $STATE_FILE
}

if [ ! -z $SWPRIMON_INT ];then
	echo "select new primary monitor:"
 	xrandr --listactivemonitors | sed -E "{/Monitors/d;s/^\s[0-9]:\s*\+(.?[A-Z]*.?)\s*(.*)/- \1/g}"
	read -p "Enter Monitor name: " NEWPRIMARY
	xrandr --output $NEWPRIMARY --primary
	exit 0
fi

if [ ! -f "$STATE_FILE" ];then
	echo "NEW_PRI_MON=" > $STATE_FILE
	echo "MON_ARR=" >> $STATE_FILE
	echo "INIT_STATE=1" >> $STATE_FILE
fi

if [ "$INIT_STATE" == 1 ];then
	_init
fi

_updateState
xrandr --output $NEW_PRI_MON --primary
notify-send "Switched primary monitor to $NEW_PRI_MON"
