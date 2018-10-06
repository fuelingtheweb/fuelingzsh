# First, clone repo: git clone https://github.com/fuelingtheweb/fuelingzsh.git ~/.fuelingzsh

TOOLS=~/.fuelingzsh/tools

xcode-select --install

source $TOOLS/brew.sh

# Init and Update submodules
cd ~/.fuelingzsh
git submodule update --init --recursive

mkdir -p ~/.fuelingzsh/custom
cp ~/.fuelingzsh/git/gitconfig ~/.fuelingzsh/custom/gitconfig
ln -s ~/.fuelingzsh/custom/gitconfig ~/.gitconfig
ln -s ~/.fuelingzsh/git/gitignore ~/.gitignore
rm ~/.zshrc
ln -s ~/.fuelingzsh/zshrc ~/.zshrc
ln -s ~/.fuelingzsh/plugins/zsh-autosuggestions ~/.fuelingzsh/oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s ~/.fuelingzsh/plugins/zsh-syntax-highlighting ~/.fuelingzsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -s ~/.fuelingzsh/themes/powerlevel9k ~/.fuelingzsh/oh-my-zsh/custom/themes/powerlevel9k
cp ~/.fuelingzsh/options/fonts/Droid+Sans+Mono+Awesome.ttf ~/Library/Fonts/Droid+Sans+Mono+Awesome.ttf
cp ~/.fuelingzsh/options/fonts/FiraCode/distr/ttf/* ~/Library/Fonts/

source $TOOLS/app-preferences.sh
source $TOOLS/osx.sh

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc
