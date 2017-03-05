#!/bin/bash

declare -a dotfiles=(".spacemacs" ".config/termite" ".zshrc" ".xinitrc" ".config/bspwm" ".config/sxhkd")

for i in "${dotfiles[@]}"
do
    cp -r "$HOME/$i" .
done

