#!/usr/bin/env bash

ANVIL=$HOME/Dev/Anvil

if [ ! -d $ANVIL ]
then
    git clone https://github.com/fuelingtheweb/anvil.git $ANVIL
fi

$ANVIL/CleanInstall/start.sh
