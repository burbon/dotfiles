# terminus font
xset +fp /usr/share/fonts/local
xset fp rehash

# keyboard layout
setxkbmap -layout pl
#setxkbmap -model dell -layout pl &

#xsetroot -solid midnightblue
#feh --bg-seamless ~/.themes/Since1975.png &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0 --height 12 --margin 0 &
#gnome-screensaver &

VBoxClient-all &
exec /usr/bin/xmonad
#exec /usr/bin/startxfce4
