ZSH=$HOME/.fuelingzsh/oh-my-zsh
FUELINGZSH=$HOME/.fuelingzsh
OPTIONS=$FUELINGZSH/options
ALIASES=$FUELINGZSH/aliases
CUSTOM=$FUELINGZSH/custom

source $OPTIONS/iterm.sh
source $OPTIONS/powerline.sh
ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(copydir copyfile history urltools autojump sublime vi-mode git-flow wd web-search vagrant osx laravel5 history-substring-search git npm zsh-autosuggestions z fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

unset zle_bracketed_paste

export VISUAL=subl
export EDITOR=subl
export FPP_EDITOR=subl
export NNN_DE_FILE_MANAGER=open
export CLICOLOR_FORCE='yes'
export PATH=$HOME/.composer/vendor/bin:$HOME/.yarn/bin:$HOME/bin:$PATH
source $OPTIONS/misc.sh
source $ALIASES/index.sh

if [[ -a $CUSTOM/localrc.sh ]]; then
    source $CUSTOM/localrc.sh
fi
