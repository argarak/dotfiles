#!/bin/bash

declare -a dotfiles=(".config/alacritty" ".zshrc" ".xinitrc" ".config/bspwm" ".config/sxhkd" ".conkyrc" "new_panel.py" "start_new_panel.py" "setup_panel.py" ".Xresources" ".config/rofi" ".doom.d")

for i in "${dotfiles[@]}"
do
    cp -r "$HOME/$i" .
done

