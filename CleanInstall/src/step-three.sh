info 'Install Mac Apps: Fantastical, Marked 2, Moom, Amphetamine, Gemini 2, White Noise.'
info 'Sign into the app store to attempt automatic install.'
open -a 'App Store.app'
pause

info 'Attempting to install apps from the Mac App Store.'
source $src/mas.sh
mas list

copyLicense 'alfred'
info 'Register Alfred and sync settings. License copied.'
info 'Manually set additional settings:'
info '- General -> Alfred Hotkey: Option+Z'
info '- Features -> Default Results -> Search Scope: Uncheck both options and empty folder list.'
info '- Features -> Web Bookmarks: Google Chrome Bookmarks'
info '- Features -> Clipboard History: Keep Plain Text, Images, and File Lists'
info '- Features -> Snippets: Automatically expand snippets by keyword'
info '- Appearance: Select FTW Material Dark'
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

info 'Open Karabiner.'
pause

info 'Open Hammerspoon.'
pause

info 'Open Hyperswitch.'
info 'Run Hyperswitch in the background'
pause

info 'Open Fantastical'
pause

info 'Open Cursorcerer'
pause

info 'Open Hazel'
pause

info 'Enable Witch.'
pause

info 'Open Atom.'
pause

info 'Open Sublime.'
info '- Hide minimap.'
echo '"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",' | pbcopy
info '- Update color scheme (copied):'
info '"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",'
pause

info 'Install Vimac: https://vimacapp.com/'
info 'Open Vimac'
pause

info 'Update Preferences: System.'
info '- Trackpad -> Scroll & Zoom: Disable Scroll direction: Natural'
info '- Trackpad -> Point & Click: Enable Tap to click'
info '- Accessibility -> Pointer Control -> Mouse & Trackpad -> Trackpad Options...: Enable Dragging'
info '- Accessibility -> Display: Reduce transparency'
info '- Keyboard -> Input Sources: Disable show input menu in menu bar'
info '- Displays: Disable show mirroring options in menu bar when available'
info '- Desktop & Screen Saver: Select wallpaper'
info '- Users & Groups -> Login Items: Add Vimac'
info '- Users & Groups -> Login Items: Add EnableMouseKeys'
pause

info 'Open Bartender'
info '- Always show: Wi-Fi, Battery, Clock, Fantastical'
info '- Show: Location Menu'
info '- Always hide: Notification Center, Spotlight'
info '- Hide: Amphetamine, Time Machine, Vimac, Dropbox'
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

info 'Open Chrome.'
info '- Hide extensions in Chrome menu.'
pause
