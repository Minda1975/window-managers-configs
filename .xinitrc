#Start up progs

xrdb ~/.Xresources

setxkbmap -layout "us,lt,ru" -option "grp:menu_toggle"

feh --bg-fill Pictures/Wall/black.jpg

dunst &


udiskie -AnT &


exec xmonad
