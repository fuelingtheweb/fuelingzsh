open https://chrome.google.com
info 'Install and setup Google Chrome.'
pause

open https://www.dropbox.com/install
info 'Install and setup Dropbox. Continue while waiting for sync to finish. Sync only Ftw folder for now.'
pause

info 'Replace Documents/Backups folder.'
pause

success 'Restoring .ssh folder.'
cp -r $backups/.ssh $HOME/.ssh

success 'Removing Backups folder.'
rm $backups

success 'Updating git remote url.'
git remote set-url origin git@github.com:fuelingtheweb/fuelingzsh.git

success 'Creating Development folder.'
mkdir $HOME/Development

info 'Wait for Dropbox to sync Ftw folder.'
info 'Update Dropbox preferences to sync remaining folders.'
info 'Quit Dropbox until all settings have synced and loaded via Mackup.'
info 'Transfer backed up folders while installing FuelingZsh.'
pause
