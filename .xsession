setxkbmap -model dell -layout pl &
#xsetroot -solid midnightblue
feh --bg-seamless ~/.themes/Since1975.png &
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 5 --transparent true --tint 0 --height 12 --margin 1280 &
gnome-screensaver &
### my stuff ###
urxvt &
pidgin &
/home/bc5042/opt/thunderbird/thunderbird &
/home/bc5042/opt/firefox/firefox &
################
exec /home/bc5042/bin/xmonad
#exec /usr/bin/openbox-session
