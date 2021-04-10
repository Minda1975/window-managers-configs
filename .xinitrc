# Statusbar loop
#while true; do
 #  xsetroot -name "$( date +"%F %R" )"
  # sleep 1m    # Update time every minute
#done &


#Start up progs
xrdb ~/.Xresources

setxkbmap -layout "us,lt,ru" -option "grp:menu_toggle"

xautolock -time 10 -locker 'i3lock' &

compton -b &

feh --bg-fill Pictures/wallpapers/blade.jpeg

udiskie &

dunst &

exec spectrwm
