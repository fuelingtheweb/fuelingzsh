ZSH=$HOME/.fuelingzsh/oh-my-zsh
FUELINGZSH=$HOME/.fuelingzsh
OPTIONS=$FUELINGZSH/options
ALIASES=$FUELINGZSH/aliases

source $OPTIONS/iterm.sh
source $OPTIONS/powerline.sh
ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(copydir copyfile history urltools autojump sublime vi-mode git-flow wd web-search vagrant osx laravel5 history-substring-search git npm zsh-autosuggestions z)
source $ZSH/oh-my-zsh.sh

export VISUAL=subl
export EDITOR=subl
export FPP_EDITOR=subl
export NNN_DE_FILE_MANAGER=open
export CLICOLOR_FORCE='yes'
export PATH=$HOME/.composer/vendor/bin:$HOME/.yarn/bin:$HOME/bin:$PATH
source $OPTIONS/misc.sh
source $ALIASES/index.sh

