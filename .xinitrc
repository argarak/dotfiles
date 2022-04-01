#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export DESKTOP_SESSION=gnome
xrdb -merge ~/.Xresources

monitorsetup &
#xscreensaver -no-splash &  
xsetroot -cursor_name left_ptr    
setxkbmap -layout dvorak
mpd .mpd &
#/usr/bin/emacs --daemon &
#redshift -l geoclue &
nitrogen --restore

xset +fp /home/kzer-za/.fonts &
xset fp rehash &

sxhkd &
#exec awesome
picom --config ~/.picom.conf &
ckb-next -b &
#exec qtile
#exec wmaker
exec bspwm
#gnome-session
#exec fluxbox
#exec startplasma-x11
