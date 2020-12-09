info 'Installing Node versions.'
nvm install 12.4.0
info 'If unsuccessful. Quit, run nvm install 12.4.0, and rerun.'
pause

success 'Installing Node packages.'
yarn global add git-open
# yarn global add git://github.com/fuelingtheweb/plugin-php.git eslint eslint-config-airbnb eslint-config-prettier eslint-import-resolver-webpack eslint-plugin-html eslint-plugin-import eslint-plugin-jest eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-react eslint-plugin-vue git://github.com/fuelingtheweb/prettier.git

success 'Installing Laravel installer and Laravel Valet.'
composer global require laravel/installer
composer global require laravel/valet
valet install
