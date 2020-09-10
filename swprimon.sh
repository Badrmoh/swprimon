#!/usr/bin/env bash

set -e

echo "select new primary monitor:"
xrandr --listactivemonitors | sed -E "{/Monitors/d;s/^\s[0-9]:\s*\+(.?[A-Z]*.?)\s*(.*)/- \1/g}"
read -p "Enter Monitor name: " NEWPRIMARY
xrandr --output $NEWPRIMARY --primary


