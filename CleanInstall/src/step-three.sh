info 'Install Mac Apps: Fantastical, Marked 2, Moom, Amphetamine, Gemini 2, White Noise.'
info 'Sign into the app store to attempt automatic install.'
open -a 'App Store.app'
pause

info 'Attempting to install apps from the Mac App Store.'
source $src/mas.sh
mas list

copyLicense 'alfred'
info 'Register Alfred and sync settings. License copied.'
pause

copyLicense 'sublime-text'
open https://packagecontrol.io/installation
info 'Open Sublime Text, register, and install Package Control. License copied.'
info 'Quit Sublime Text when finished.'
pause

source $custom/step-three.sh

success 'Cloning custom Atom packages: PHPUnit and Autocomplete PHP.'
mkdir -p $HOME/Development/Atom
git clone git@github.com:fuelingtheweb/atom-phpunit.git $HOME/Development/Atom/phpunit
cd $HOME/Development/Atom/phpunit
git checkout develop
git clone git@github.com:fuelingtheweb/atom-autocomplete-php.git $HOME/Development/Atom/autocomplete-php
cd $HOME/Development/Atom/autocomplete-php
git checkout develop
npm install

success 'Running Mackup Restore.'
mackup restore

success 'Linking custom dotfiles.'
ln -s $FUELINGZSH/custom/gitconfig $HOME/.gitconfig

info 'Open Atom.'
pause

info 'Open Sublime.'
pause

info 'Update Preferences: System.'
pause

copyLicense 'sublime-merge'
info 'Register Sublime Merge. License copied.'
pause

copyLicense 'tableplus'
info 'Register TablePlus. License copied.'
pause

copyLicense 'choosy'
info 'Register Choosy. License copied.'
pause

info 'Add other licenses: Dash.'
pause
