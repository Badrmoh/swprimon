#!/usr/bin/env bash


echo "select new primary monitor:"
cmd=$(pxrandr --listactivemonitors | sed -E "{/Monitors/d;s/^\s[0-9]:\s*\+(.?[A-Z]*.?)\s*(.*)/- \1/g}")
echo $cmd

count=$(echo $cmd | grep -v '*' | grep -c)

for i in $count


read -p "Enter Monitor name: " NEWPRIMARY
xrandr --output $NEWPRIMARY --primary


