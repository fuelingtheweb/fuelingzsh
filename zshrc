ZSH=$HOME/.fuelingzsh/oh-my-zsh
FUELINGZSH=$HOME/.fuelingzsh
OPTIONS=$FUELINGZSH/options
ALIASES=$FUELINGZSH/aliases
CUSTOM=$FUELINGZSH/custom
ZSH_DISABLE_COMPFIX="true"

source $OPTIONS/iterm.sh
source $OPTIONS/powerline.sh
ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(copydir copyfile history urltools autojump sublime vi-mode git-flow wd web-search vagrant osx laravel5 history-substring-search npm zsh-autosuggestions z fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
