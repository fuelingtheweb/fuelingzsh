info 'Install Mac Apps: Fantastical, Marked 2, Amphetamine, Gemini 2, White Noise.'
info 'Sign into the app store to attempt automatic install.'
open -a 'App Store.app'
pause

info 'Attempting to install apps from the Mac App Store.'
source $src/mas.sh
mas list

copyLicense 'alfred'
open -a 'Alfred 4.app'
info 'Register Alfred and sync settings. License copied.'
info 'Manually set additional settings if required:'
info '- General -> Alfred Hotkey: Option+Z'
info '- Features -> Default Results -> Search Scope: Uncheck both options and empty folder list.'
info '- Features -> Web Bookmarks: Google Chrome Bookmarks'
info '- Features -> Clipboard History: Keep Plain Text, Images, and File Lists'
info '- Features -> Snippets: Automatically expand snippets by keyword'
info '- Appearance: Select FTW Material Dark'
pause

copyLicense 'sublime-text'
open https://packagecontrol.io/installation
open -a 'Sublime Text.app'
info 'Open Sublime Text, register, and install Package Control. License copied.'
info 'Quit Sublime Text when finished.'
pause

source $custom/step-three-apps.sh

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
open -a 'Karabiner-Elements.app'
pause

info 'Open Hammerspoon.'
open -a 'Hammerspoon.app'
pause

info 'Open Fantastical'
open -a 'Fantastical.app'
pause

info 'Open Cursorcerer'
open '/Users/nathan/Library/PreferencePanes/Cursorcerer.prefPane'
pause

info 'Enable Witch.'
open '/Users/nathan/Library/PreferencePanes/Witch.prefPane'
pause

info 'Open Atom.'
open -a 'Atom.app'
pause

info 'Open Sublime.'
open -a 'Sublime Text.app'
info '- Hide minimap.'
echo '"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",' | pbcopy
info '- Update color scheme (copied):'
info '"color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",'
pause

info 'Install Vimac: https://vimacapp.com/'
open https://vimacapp.com/
pause

info 'Open Vimac'
open -a 'Vimac.app'
pause

info 'Update Preferences: System.'
open -a 'System Preferences.app'
info '- Trackpad -> Scroll & Zoom: Disable Scroll direction: Natural'
info '- Trackpad -> Point & Click: Enable Tap to click'
info '- Trackpad -> Point & Click: Increase Tracking speed to 70%'
info '- Accessibility -> Pointer Control -> Mouse & Trackpad -> Trackpad Options...: Enable Dragging'
info '- Accessibility -> Display: Reduce transparency'
info '- Keyboard -> Input Sources: Disable show input menu in menu bar'
info '- Keyboard -> Touch Bar shows: Expanded Control Strip'
info '- Displays: Disable show mirroring options in menu bar when available'
info '- Desktop & Screen Saver: Select wallpaper'
info '- Users & Groups -> Login Items: Add Vimac'
info '- Users & Groups -> Login Items: Add EnableMouseKeys'
info '- Add Google Internet account.'
info '- Remove iCloud syncing.'
info '- Dock & Menu Bar -> Battery: Show Percentage'
info '- Dock & Menu Bar -> Clock: Disable Show the day of the week'
info '- Dock & Menu Bar -> Clock: Disable Show date'
info '- Remove widgets.'
pause

info 'Open Bartender'
open -a 'Bartender 4.app'
info '- Always show: Wi-Fi, Battery, Clock, Fantastical'
info '- Show: Location Menu'
info '- Always hide: Notification Center, Spotlight'
info '- Hide: Amphetamine, Time Machine, Vimac, Dropbox'
pause

copyLicense 'sublime-merge'
open -a 'Sublime Merge.app'
info 'Register Sublime Merge. License copied.'
pause

copyLicense 'tableplus'
open -a 'TablePlus.app'
info 'Register TablePlus. License copied.'
pause

copyLicense 'choosy'
open -a 'Choosy.app'
info 'Register Choosy. License copied.'
pause

info 'Add other licenses: Dash.'
pause

info 'Open Chrome.'
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "https://google.com" --profile-directory="Default"
info '- Hide extensions in Chrome menu.'
pause
