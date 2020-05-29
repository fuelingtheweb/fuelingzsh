#!/usr/bin/env bash

FUELINGZSH=$HOME/.fuelingzsh

if [ ! -d $FUELINGZSH ]
then
    git clone https://github.com/fuelingtheweb/fuelingzsh.git $FUELINGZSH
fi

$FUELINGZSH/CleanInstall/start.sh
