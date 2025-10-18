success 'Installing and configuring Xdebug.'
pecl install xdebug
php --ini
info 'Delete xdebug module from php.ini. See path above. php --ini.'
pause

info 'What is the path to php conf.d folder? See path above. php --ini.'
read confPath
info 'Saving xdebug.ini files.'
cp $ANVIL/options/php/xdebug.ini $confPath/xdebug.ini.back
echo "" > $confPath/xdebug.ini
pause
