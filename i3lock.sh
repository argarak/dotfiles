#!/bin/bash

scrot -z /tmp/.i3lock.png
convert -scale 10% -scale 1000% /tmp/.i3lock.png /tmp/.i3lock.png
convert -gravity center /tmp/.i3lock.png ~/dotfiles/keya.png -composite /tmp/.i3lock.png

i3lock -i /tmp/.i3lock.png \
--bar-indicator \
--bar-position h \
--bar-direction 1 \
--bar-max-height 5 \
--bar-base-width 5 \
--bar-color 000000cc \
--keyhlcolor f44336cc \
--bar-periodic-step 50 \
--bar-step 50 \
--bar-width 250 \
--redraw-thread \
--ringvercolor C51162ff \
--ringwrongcolor d50000ff
