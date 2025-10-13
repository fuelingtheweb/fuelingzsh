open https://vivaldi.com
info 'Install Vivaldi.'
pause

# Install Vivaldi
# Set up ssh key and add to GitHub
# Download .fuelingzsh
# Install Homebrew
# Install goku
# Install Karabiner Elements and Hammerspoon

info 'Setup Vivaldi.'
open -a 'Vivaldi.app'
pause

info 'Move Backups to Documents.'
pause

open https://www.dropbox.com/install
info 'Install and setup Dropbox. Continue while waiting for sync to finish. Sync only Ftw folder for now.'
info 'Disable launch on startup.'
pause

success 'Restoring .ssh folder.'
cp -r $backups/.ssh $HOME/.ssh

success 'Updating git remote url.'
cd $FUELINGZSH
git remote set-url origin git@github.com:fuelingtheweb/fuelingzsh.git

success 'Creating Dev folder.'
mkdir $HOME/Dev

info 'Wait for Dropbox to sync Ftw folder.'
info 'Update Dropbox preferences to sync remaining folders.'
info 'Quit Dropbox until all settings have synced and symlinked.'
info 'Transfer backed up folders while installing FuelingZsh then remove Backups folder.'
open $HOME/Dev
open $backups
pause
