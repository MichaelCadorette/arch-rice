picom --inactive-opacity=1 &
feh --bg-fill ~/Pictures/1920-1080.png &
#xrandr --output HDMI-0 --mode 1920x1080 --rate 120 &
#xrandr --output DP-1 --mode 1920x1080 --rate 144 &
lxsession &
xautolock -time 15 -locker slock &
~/.dwm/dwmbar.sh &
