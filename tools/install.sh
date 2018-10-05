if [ -d ~/.fuelingzsh ]
then
	echo "\033[0;33mYou already have Fueling Zsh installed.\033[0m You'll need to remove ~/.fuelingzsh if you want to install"
	exit
fi

xcode-select --install

# Install Homebrew if it's not installed
# URL: http://brew.sh
# Homebrew is a package manager for OS X
echo "\033[0;34mInstalling Homebrew...\033[0m"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew upgrade
brew install ack bat circleci csvkit diff-so-fancy exa fasd fd fpp fzf git git-flow highlight httpie hub mysql ncdu nnn php prettyping sqlite terminal-notifier tesseract tldr vim z mas

# Clone Fueling Zsh
echo "\033[0;34mCloning Fueling Zsh...\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/fuelingtheweb/fuelingzsh.git ~/.fuelingzsh || {
	echo "git not installed"
	exit
}

# Init and Update submodules
cd ~/.fuelingzsh
git submodule update --init --recursive

ln -s ~/.fuelingzsh/git/gitconfig ~/.gitconfig
ln -s ~/.fuelingzsh/git/gitignore ~/.gitignore
ln -s ~/.fuelingzsh/zshrc ~/.zshrc

source ./osx.sh
source ./mas.sh

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc
