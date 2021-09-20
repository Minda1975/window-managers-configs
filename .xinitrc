xrdb ~/.Xresources

xset +fp /home/azg256/.local/share/fonts

xset fp rehash

setxkbmap -layout "us,lt,ru" -option "grp:menu_toggle"

feh --bg-fill Pictures/Wall/black.jpg

dunst &

udiskie -AnT &

sxhkd &

exec bspwm
