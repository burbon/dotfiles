# terminus font
xset +fp /usr/share/fonts/local
xset fp rehash

# keyboard layout
setxkbmap -layout pl
#setxkbmap -model dell -layout pl &

# set default cursor
xsetroot -cursor_name left_ptr

# set background
#xsetroot -solid midnightblue

# set cursor
xsetroot -cursor_name left_ptr

# load key bind mods
xmodmap $HOME/.Xmodmap

#feh --bg-seamless ~/.themes/Since1975.png &
#feh /usr/share/archlinux/wallpaper/archlinux-simplyblack.png &

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0 --height 12 --margin 0 &
batti &
#gnome-screensaver &
#xscreensaver -no-splash &

VBoxClient-all &
exec /usr/bin/xmonad
#exec /usr/bin/startxfce4
