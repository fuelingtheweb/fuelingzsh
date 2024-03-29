source $ALIASES/misc.sh
source $ALIASES/files-folders.sh
source $ALIASES/file-editing.sh
source $ALIASES/cd.sh

source $ALIASES/misc-dev.sh
source $ALIASES/composer.sh
source $ALIASES/valet.sh
source $ALIASES/database.sh
if type "$docker" > /dev/null; then
    source $ALIASES/docker.sh
fi
source $ALIASES/ssh.sh
source $ALIASES/editors.sh
source $ALIASES/node.sh
source $ALIASES/phpunit.sh
source $ALIASES/git.sh
source $ALIASES/laravel.sh
source $ALIASES/brew.sh
source $ALIASES/fzf.sh
source $ALIASES/rails.sh
source $ALIASES/wordpress.sh

if [[ -a $ALIASES/custom/index.sh ]]; then
    source $ALIASES/custom/index.sh
fi
