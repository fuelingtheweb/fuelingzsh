source $ALIASES/misc.sh
source $ALIASES/files-folders.sh
source $ALIASES/file-editing.sh

source $ALIASES/misc-dev.sh
source $ALIASES/composer.sh
source $ALIASES/docker.sh
source $ALIASES/ssh.sh
source $ALIASES/editors.sh
source $ALIASES/node.sh
source $ALIASES/phpunit.sh
source $ALIASES/git.sh
source $ALIASES/laravel.sh
source $ALIASES/brew.sh
source $ALIASES/fzf.sh

if [[ -a $ALIASES/custom/index.sh ]]; then
    source $ALIASES/custom/index.sh
fi
