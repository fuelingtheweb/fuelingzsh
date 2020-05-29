success 'Installing Node versions.'
nvm install 12.4.0

success 'Installing Node packages.'
yarn global add git-open

success 'Installing Laravel installer and Laravel Valet.'
composer global require laravel/installer
composer global require laravel/valet
valet install
