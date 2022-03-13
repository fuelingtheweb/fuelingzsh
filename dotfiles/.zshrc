ZSH=$HOME/.ohmyzsh
FUELINGZSH=$HOME/.fuelingzsh
OPTIONS=$FUELINGZSH/options
ALIASES=$FUELINGZSH/aliases
CUSTOM=$FUELINGZSH/custom
ZSH_DISABLE_COMPFIX="true"

source $OPTIONS/iterm.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(copypath copyfile history urltools autojump sublime vi-mode git-flow wd web-search macos laravel5 history-substring-search npm zsh-autosuggestions z fast-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1
export VISUAL=subl
export EDITOR=subl
export FPP_EDITOR=subl
export NNN_DE_FILE_MANAGER=open
export CLICOLOR_FORCE='yes'
export PATH=$FUELINGZSH/bin:$HOME/.composer/vendor/bin:$HOME/.yarn/bin:$HOME/bin:$PATH
source $OPTIONS/misc.sh
source $ALIASES/index.sh

if [[ -a $CUSTOM/localrc.sh ]]; then
    source $CUSTOM/localrc.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# To customize prompt, run `p10k configure` or edit $OPTIONS/p10k.zsh.
source $OPTIONS/p10k.zsh
