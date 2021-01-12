#!/usr/bin/env bash

cleanInstall=$HOME/.fuelingzsh/CleanInstall
source $cleanInstall/src/variables.sh

mkdir -p $backups
cp -r $HOME/.ssh $backups/.ssh
mackup backup
