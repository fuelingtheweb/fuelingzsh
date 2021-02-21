info 'Installing Node versions.'
nvm install 12.4.0
echo 'nvm install 12.4.0' | pbcopy
info 'If unsuccessful. Quit, run nvm install 12.4.0 (copied) in a new tab, and continue.'
pause

success 'Installing Node packages.'
yarn global add git-open
# yarn global add git://github.com/fuelingtheweb/plugin-php.git eslint eslint-config-airbnb eslint-config-prettier eslint-import-resolver-webpack eslint-plugin-html eslint-plugin-import eslint-plugin-jest eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-react eslint-plugin-vue git://github.com/fuelingtheweb/prettier.git
yarn global add prettier git://github.com/fuelingtheweb/plugin-php.git
cd $FUELINGZSH/bin/change-case
yarn
cd $FUELINGZSH

success 'Installing Laravel installer and Laravel Valet.'
composer global require laravel/installer
composer global require laravel/valet
composer global require laravel/envoy
composer global require tightenco/tlint
valet install
valet trust

# https://dev.to/albarin/how-to-easily-add-co-authors-to-you-commits-2ch6#option2
# https://github.com/findmypast-oss/git-mob
 # npm i -g git-mob
 # st .git-coauthors
 # git config --global init.templatedir '~/.git-templates'
 # chmod +x ~/.git-templates/hooks/prepare-commit-msg
 # cd ~/Development/Tighten/TBH/www
 # git init
 # git mob --installTemplate && touch .git/.gitmessage
