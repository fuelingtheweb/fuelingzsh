success 'Installing FuelingZsh.'

xcode-select --install
info 'Proceed when xcode dev tools are installed.'
pause

info 'If unsuccessful, restart Terminal and skip to step two after enabling xcode.'
info 'If successful, restart Terminal and skip to step three.'
pause

source $src/brew.sh

# Init and Update submodules
cd $FUELINGZSH
git submodule update --init --recursive

ln -s $FUELINGZSH/dotfiles/.gitignore $HOME/.gitignore
ln -s $FUELINGZSH/dotfiles/.zshrc $HOME/.zshrc
ln -s $FUELINGZSH/dotfiles/.my.cnf $HOME/.my.cnf
ln -s $FUELINGZSH/dotfiles/.myclirc $HOME/.myclirc
ln -s $FUELINGZSH/dotfiles/.npmrc $HOME/.npmrc
ln -s $FUELINGZSH/dotfiles/.phpmd.xml $HOME/.phpmd.xml
ln -s $FUELINGZSH/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $FUELINGZSH/dotfiles/.hammerspoon $HOME/.hammerspoon
ln -s $FUELINGZSH/dotfiles/.lambo $HOME/.lambo
ln -s $FUELINGZSH/dotfiles/.ctags $HOME/.ctags
ln -s $FUELINGZSH/dotfiles/.mackup $HOME/.mackup
ln -s $FUELINGZSH/dotfiles/.mackup.cfg $HOME/.mackup.cfg

ln -s $FUELINGZSH/karabiner/karabiner.edn $HOME/.config/karabiner.edn
ln -s $FUELINGZSH/options/oh-my-zsh/themes/powerlevel9k $FUELINGZSH/oh-my-zsh/custom/themes/powerlevel9k
cp $FUELINGZSH/options/fonts/Droid+Sans+Mono+Awesome.ttf $HOME/Library/Fonts/Droid+Sans+Mono+Awesome.ttf
cp $FUELINGZSH/options/fonts/FiraCode/distr/ttf/* $HOME/Library/Fonts/
ln -s $FUELINGZSH/options/oh-my-zsh/plugins/zsh-autosuggestions $FUELINGZSH/oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s $FUELINGZSH/options/oh-my-zsh/plugins/zsh-syntax-highlighting $FUELINGZSH/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -s $FUELINGZSH/options/oh-my-zsh/plugins/fast-syntax-highlighting $FUELINGZSH/oh-my-zsh/custom/plugins/fast-syntax-highlighting
touch $HOME/.hushlogin

source $src/osx.sh

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc

brew install zsh
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
echo 'Restart your terminal'
