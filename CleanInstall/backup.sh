#!/usr/bin/env bash

cleanInstall=$HOME/.fuelingzsh/CleanInstall
source $cleanInstall/src/variables.sh

cp -r $HOME/.ssh $backups/.ssh
mackup backup
