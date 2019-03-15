#!/usr/bin/env bash

# First, clone repo: git clone https://github.com/fuelingtheweb/fuelingzsh.git ~/.fuelingzsh

FUELINGZSH=$HOME/.fuelingzsh
TOOLS=$FUELINGZSH/tools

xcode-select --install

source $TOOLS/brew.sh

# Init and Update submodules
cd $FUELINGZSH
git submodule update --init --recursive

mkdir -p $FUELINGZSH/custom
cp $FUELINGZSH/git/gitconfig $FUELINGZSH/custom/gitconfig
ln -s $FUELINGZSH/custom/gitconfig $HOME/.gitconfig
ln -s $FUELINGZSH/git/gitignore $HOME/.gitignore
rm $HOME/.zshrc
ln -s $FUELINGZSH/zshrc $HOME/.zshrc
ln -s $FUELINGZSH/dotfiles/my.cnf $HOME/.my.cnf
ln -s $FUELINGZSH/dotfiles/myclirc $HOME/.myclirc
ln -s $FUELINGZSH/dotfiles/bash_profile $HOME/.bash_profile
ln -s $FUELINGZSH/plugins/zsh-autosuggestions $FUELINGZSH/oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s $FUELINGZSH/plugins/zsh-syntax-highlighting $FUELINGZSH/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -s $FUELINGZSH/plugins/fast-syntax-highlighting $FUELINGZSH/oh-my-zsh/custom/plugins/fast-syntax-highlighting
ln -s $FUELINGZSH/themes/powerlevel9k $FUELINGZSH/oh-my-zsh/custom/themes/powerlevel9k
cp $FUELINGZSH/options/fonts/Droid+Sans+Mono+Awesome.ttf $HOME/Library/Fonts/Droid+Sans+Mono+Awesome.ttf
cp $FUELINGZSH/options/fonts/FiraCode/distr/ttf/* $HOME/Library/Fonts/
touch $HOME/.hushlogin

source $TOOLS/app-preferences.sh
source $TOOLS/osx.sh

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc

brew install zsh
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
echo 'Restart your terminal'
