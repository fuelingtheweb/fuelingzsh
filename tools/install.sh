if [ -d ~/.fuelingzsh ]
then
	echo "\033[0;33mYou already have Fueling Zsh installed.\033[0m You'll need to remove ~/.fuelingzsh if you want to install"
	exit
fi

xcode-select --install

source ./brew.sh

# Clone Fueling Zsh
echo "\033[0;34mCloning Fueling Zsh...\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/fuelingtheweb/fuelingzsh.git ~/.fuelingzsh || {
	echo "git not installed"
	exit
}

# Init and Update submodules
cd ~/.fuelingzsh
git submodule update --init --recursive

mkdir -p ~/.fuelingzsh/custom
cp ~/.fuelingzsh/git/gitconfig ~/.fuelingzsh/custom/gitconfig
ln -s ~/.fuelingzsh/custom/gitconfig ~/.gitconfig
ln -s ~/.fuelingzsh/git/gitignore ~/.gitignore
ln -s ~/.fuelingzsh/zshrc ~/.zshrc
ln -s ~/.fuelingzsh/plugins/zsh-autosuggestions ~/.fuelingzsh/oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s ~/.fuelingzsh/plugins/zsh-syntax-highlighting ~/.fuelingzsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -s ~/.fuelingzsh/themes/powerlevel9k ~/.fuelingzsh/oh-my-zsh/custom/themes/powerlevel9k

source ./app-preferences.sh
source ./osx.sh
source ./mas.sh

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc
