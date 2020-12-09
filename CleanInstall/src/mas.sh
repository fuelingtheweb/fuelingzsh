#!/usr/bin/env bash

# Automatically install purchased apps from the Mac App Store

# Mac App Store apps to install
apps=(
    "Fantastical:975937182"
    "Marked 2:890031187"
    "Amphetamine:937984704"
    "White Noise:415139197"
)

for app in "${apps[@]}"; do
    name=${app%%:*}
    id=${app#*:}

    echo -e "Attempting to install $name"
    mas install "$id"
done
