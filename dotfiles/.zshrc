ZSH=$HOME/.ohmyzsh
FUELINGZSH=$HOME/.fuelingzsh
OPTIONS=$FUELINGZSH/options
ALIASES=$FUELINGZSH/aliases
CUSTOM=$FUELINGZSH/custom
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_UPDATE="true"

ZSH_THEME="ftw-agnoster"

plugins=(
    history-substring-search
    urltools
)
source $ZSH/oh-my-zsh.sh

# https://volta.sh/
export VOLTA_HOME=$HOME/.volta
export KEYTIMEOUT=1
export VISUAL=code
export EDITOR=code
export FPP_EDITOR=code
export NNN_DE_FILE_MANAGER=open
export CLICOLOR_FORCE='yes'
export PATH=/Applications/Docker.app/Contents/Resources/bin:$VOLTA_HOME/bin:$FUELINGZSH/bin:$HOME/.composer/vendor/bin:/usr/local/sbin:$PATH
# export PATH=$VOLTA_HOME/bin:$FUELINGZSH/bin:$HOME/.composer/vendor/bin:$HOME/.yarn/bin:$HOME/bin:/usr/local/sbin:$PATH
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

# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
#     # To customize prompt, run `p10k configure` or edit $OPTIONS/p10k.zsh.
#     source $OPTIONS/p10k.zsh

#     source ~/.iterm2_shell_integration.zsh
# fi

PROMPT="${PROMPT}"$'\n'

# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/82/"

# Herd injected PHP binary.
export PATH="$HOME/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/81/"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/83/"

# Added by Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"
