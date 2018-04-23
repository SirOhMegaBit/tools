#!/bin/sh

# Location from top left
x_val=100
y_val=100

# Time in seconds to delay
# 0 only runs once, then quits
t_val=0

cd -- "$(dirname "$0")"

if [ ! -f "click" ]
then
   cmd="gcc -o click interval_click.m -framework ApplicationServices -framework Foundation";
   echo "$cmd";
   `$cmd`
fi

cmd="./click -x $x_val -y $y_val -t $t_val"
echo "$cmd"
`$cmd`

sleep 10
