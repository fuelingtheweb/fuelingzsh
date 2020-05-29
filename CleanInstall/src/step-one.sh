open https://chrome.google.com
info 'Install and setup Google Chrome.'
pause

open https://www.dropbox.com/install
info 'Install and setup Dropbox. Continue while waiting for sync to finish.'
pause

info 'Replace Documents/Backups folder.'
pause

success 'Restoring .ssh folder.'
cp -r $backups/.ssh $HOME/.ssh

success 'Updating git remote url'
git remote set-url origin git@github.com:fuelingtheweb/fuelingzsh.git

info 'Wait for Dropbox sync to finish'
info 'Quit Dropbox until all settings have synced and loaded via Mackup'
pause
