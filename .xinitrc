# vim: ft=sh

setxkbmap -option caps:escape
setxkbmap -layout br

xrdb ~/.Xresources

urxvtd -q -f -o

exec i3
