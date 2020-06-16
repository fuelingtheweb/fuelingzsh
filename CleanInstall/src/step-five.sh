info 'Installing Node versions.'
nvm install 12.4.0
info 'If unsuccessful. Quit, run nvm install 12.4.0, and rerun.'
pause

success 'Installing Node packages.'
yarn global add git-open

success 'Installing Laravel installer and Laravel Valet.'
composer global require laravel/installer
composer global require laravel/valet
valet install
