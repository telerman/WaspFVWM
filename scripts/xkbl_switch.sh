#!/bin/bash
# Script should switch keyboard layout any run between English, Russian and Hebrew layouts
if [ `setxkbmap -query | grep layout|cut -f2 -d":"` == "us" ]
then
    setxkbmap -layout il
elif [ `setxkbmap -query | grep layout|cut -f2 -d":"` == "il" ]
then
    setxkbmap -layout ru -variant phonetic
elif [ `setxkbmap -query | grep layout|cut -f2 -d":"` == "ru" ]
then
    setxkbmap -layout us
fi
echo `setxkbmap -query | grep layout|cut -f2 -d":"`
