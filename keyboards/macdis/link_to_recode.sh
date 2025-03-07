#!/usr/bin/env bash

githome="$HOME/Documents/Docs/GitHub"
recode="$githome/recode-qmk/keyboards"
qmk="$githome/qmk_firmware/keyboards"
source_keyboard="$recode/cbiffle/recode_revc"
source_keymap="$source_keyboard/keymaps/fullsize_ansi"
export destination_keyboard="$qmk/macdis"
destination_keymap="$qmk/macdis/keymaps/default"

if [[ ! -d "$source_keyboard" ]]; then
    echo "Recode keyboard and keymaps are not available in $source_keyboard"
    exit 1
fi

find "$destination_keyboard" -maxdepth 1 -type l -delete

find "$source_keyboard" -maxdepth 1 -type f -exec bash -c 'ln -s "$1" "$destination_keyboard/${1##*/}"' bash {} \;

if [[ -d "$destination_keymap" && -z "$(ls -A "$destination_keymap")" ]]; then
    cp "$source_keymap"/* "$destination_keymap"
else
    echo "Not empty, aborting keymap copy: $destination_keymap"
fi
