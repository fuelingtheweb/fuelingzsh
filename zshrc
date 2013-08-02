# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Path to fuelingzsh
fuelingzsh=$HOME/.fuelingzsh

#for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fuelingtheweb"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(sublime osx last-working-dir web-search vi-mode autojump)

source $ZSH/oh-my-zsh.sh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH=$PATH:~/Library/Ruby/Gems/1.8/bin:~/.rbenv/versions/1.9.3-p194/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin
source $fuelingzsh/options.zsh
source $fuelingzsh/aliases.zsh  #alias reload
source $fuelingzsh/yadr/zsh/colors.zsh
source $fuelingzsh/yadr/zsh/fasd.zsh
source $fuelingzsh/yadr/zsh/git.zsh
source $fuelingzsh/yadr/zsh/key-bindings.zsh
source $fuelingzsh/yadr/zsh/last-command.zsh
source $fuelingzsh/yadr/zsh/noglob.zsh
source $fuelingzsh/yadr/zsh/rm.zsh
source $fuelingzsh/yadr/zsh/vi-mode.zsh
source $fuelingzsh/yadr/zsh/zmv.zsh
unsetopt auto_pushd

# Initialize rbenv
eval "$(rbenv init - --no-rehash)"
