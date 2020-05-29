#!/usr/bin/env bash

cleanInstall=$HOME/.fuelingzsh/CleanInstall
source $cleanInstall/src/variables.sh

runStepIf 'one' 'Proceed with step one (Chrome, Dropbox, SSH)?'
runStepIf 'two' 'Proceed with step two (FuelingZsh)?'
runStepIf 'three' 'Proceed with step three (Mac Apps, Alfred, Sublime, Atom, Mackup)?'
runStepIf 'four' 'Proceed with step four (Xdebug)?'
runStepIf 'five' 'Proceed with step five (Node, Laravel, Valet)?'
runStepIf 'six' 'Proceed with step six (Pianobar)?'
runStepIf 'seven' 'Proceed with step seven (Files, Warp Points, Valet, Chrome, Misc)?'
runStepIf 'eight' 'Proceed with step eight (Navicat, Docker, Rails)?'

success 'All done!'
