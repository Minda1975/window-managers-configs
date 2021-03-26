xrdb ~/.Xresources

xsetroot -cursor_name left_ptr

setxkbmap -layout "us,lt,ru" -option "grp:menu_toggle"

xautolock -time 10 -locker 'i3lock' &

compton -b &

feh --randomize --no-fehbg --bg-scale Pictures/Wall/*

udiskie -A &

dunst &

exec xmonad
