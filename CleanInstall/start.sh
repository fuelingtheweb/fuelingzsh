#!/usr/bin/env zsh

cleanInstall=$HOME/Dev/Anvil/CleanInstall
source $cleanInstall/src/variables.sh

runStepIf 'one-initial' 'Proceed with step one (Chrome, Dropbox, SSH)?'
runStepIf 'two-anvil' 'Proceed with step two (Anvil)?'
runStepIf 'three-apps' 'Proceed with step three (Mac Apps, Alfred, Sublime, Code, Mackup)?'
runStepIf 'four-xdebug' 'Proceed with step four (Xdebug)?'
runStepIf 'five-node-valet' 'Proceed with step five (Node, Laravel, Valet)?'
runStepIf 'six-pianobar' 'Proceed with step six (Pianobar)?'

success 'All done!'
