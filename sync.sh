#!/bin/bash

declare -a dotfiles=(".spacemacs" ".config/awesome" ".config/termite" ".zshrc" ".xinitrc")

for i in "${dotfiles[@]}"
do
    cp -r "$HOME/$i" .
done

