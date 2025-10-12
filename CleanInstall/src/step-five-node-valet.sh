info 'Installing Node versions.'
volta install node
pause

success 'Installing Laravel installer and Tlint.'
composer global require laravel/installer
composer global require tightenco/tlint

info 'Install Laravel Herd.'
pause
