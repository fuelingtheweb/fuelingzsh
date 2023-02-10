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

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
else
    ZSH_THEME="ftw-agnoster"
fi

plugins=(
    fast-syntax-highlighting
    history-substring-search
    urltools
    vi-mode
    wd
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# https://volta.sh/
export VOLTA_HOME=$HOME/.volta
export KEYTIMEOUT=1
export VISUAL=subl
export EDITOR=subl
export FPP_EDITOR=subl
export NNN_DE_FILE_MANAGER=open
export CLICOLOR_FORCE='yes'
export PATH=$VOLTA_HOME/bin:$FUELINGZSH/bin:$HOME/.composer/vendor/bin:$HOME/.yarn/bin:$HOME/bin:/usr/local/sbin:$PATH
source $OPTIONS/misc.sh
source $ALIASES/index.sh

if [[ -a $CUSTOM/localrc.sh ]]; then
    source $CUSTOM/localrc.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# export NODE_OPTIONS=--openssl-legacy-provider

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
    # To customize prompt, run `p10k configure` or edit $OPTIONS/p10k.zsh.
    source $OPTIONS/p10k.zsh

    source ~/.iterm2_shell_integration.zsh
fi
