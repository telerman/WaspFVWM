#!/bin/bash
# Script should switch keyboard layout any run between English, Russian and Hebrew layouts
export CURRENT_L=`setxkbmap -query | grep layout | tr -d " "|cut -f2 -d":"`
if [ $CURRENT_L == "us" ]
then
    setxkbmap -layout il
elif [ $CURRENT_L == "il" ]
then
    setxkbmap -layout ru -variant phonetic
elif [ $CURRENT_L == "ru" ]
then
    setxkbmap -layout us
fi
echo `setxkbmap -query | grep layout | tr -d " " | cut -f2 -d":"`
