#!/bin/bash
xd=(`xrandr | grep -w connected | cut -f1 -d" "`)

echo ${xd[0]} ${#xd[@]}
xrandr --output ${xd[0]} --auto
if [[ ${#xd[@]} -gt 1 ]]
then 
    for i in `seq 1 ${#xd[@]}`
    do
	xrandr --output ${xd[$i]} --right-of ${xd[$i-1]} --auto
    done 
fi

FvwmCommand restart
