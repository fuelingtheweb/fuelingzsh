#!/usr/bin/env zsh

cleanInstall=$HOME/.fuelingzsh/CleanInstall
source $cleanInstall/src/variables.sh

runStepIf 'one-initial' 'Proceed with step one (Chrome, Dropbox, SSH)?'
runStepIf 'two-fuelingzsh' 'Proceed with step two (FuelingZsh)?'
runStepIf 'three-apps' 'Proceed with step three (Mac Apps, Alfred, Sublime, Code, Mackup)?'
runStepIf 'four-xdebug' 'Proceed with step four (Xdebug)?'
runStepIf 'five-node-valet' 'Proceed with step five (Node, Laravel, Valet)?'
runStepIf 'six-pianobar' 'Proceed with step six (Pianobar)?'
runStepIf 'seven-misc' 'Proceed with step seven (Files, Warp Points, Valet, Chrome, Misc)?'
runStepIf 'eight' 'Proceed with step eight (Navicat, Docker, Rails)?'

success 'All done!'
