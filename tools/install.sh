if [ -d ~/.fuelingzsh ]
then
	echo "\033[0;33mYou already have Fueling Zsh installed.\033[0m You'll need to remove ~/.fuelingzsh if you want to install"
	exit
fi

# Install Homebrew if it's not installed
# URL: http://brew.sh
# Homebrew is a package manager for OS X
echo "\033[0;34mInstalling Homebrew...\033[0m"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

# Upgrade Homebrew and install Git if it's not installed
echo "\033[0;34mUpgrading Homebrew...\033[0m"
brew upgrade
echo "\033[0;34mInstalling Git...\033[0m"
brew install git

# Clone Fueling Zsh
echo "\033[0;34mCloning Fueling Zsh...\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/fuelingtheweb/fuelingzsh.git ~/.fuelingzsh || {
	echo "git not installed"
	exit
}

# Init and Update submodules
cd ~/.fuelingzsh
git submodule update --init --recursive

# Create a symlink to use fuelingtheweb.zsh-theme
echo "\033[0;34mAdding fuelingtheweb theme to Oh My Zsh...\033[0m"
ln -s ~/.fuelingzsh/fuelingtheweb.zsh-theme ~/.fuelingzsh/oh-my-zsh/custom/fuelingtheweb.zsh-theme

# Install Homebrew Packages
# autojump, cmus, fasd, hub, lftp, mplayer, pianobar, rbenv, ruby-build, task, the_silver_searcher, tmux, vifm
echo "\033[0;34mInstalling Homebrew Packages...\033[0m"
brew install autojump cmus fasd hub lftp mplayer pianobar rbenv ruby-build task the_silver_searcher tmux vifm

# Install updated ruby version in order to install gollum
echo "\033[0;34mInstalling new version of ruby...\033[0m"
rbenv install 1.9.3p194
rbenv rehash
rbenv global 1.9.3p194

# Install Gems
# ghi, terminal-notifier, gollum
echo "\033[0;34mInstalling Gems...\033[0m"
sudo gem install ghi terminal-notifier gollum

# Create .pre-fuelingzsh folder to backup config files
if [ ! -d ~/.pre-fuelingzsh ]
then
	echo "\033[0;34mCreating .pre-fuelingzsh backup folder...\033[0m"
	mkdir ~/.pre-fuelingzsh
fi

echo "\033[0;34mBacking up existing config files and linking to new ones...\033[0m"

# Backup .editrc
if [ -f ~/.editrc ] || [ -h ~/.editrc ]
then
	mv ~/.editrc ~/.pre-fuelingzsh/
fi
# Link to new .editrc
ln -s ~/.fuelingzsh/yadr/vimify/editrc ~/.editrc

# Backup .gitconfig
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]
then
	mv ~/.gitconfig ~/.pre-fuelingzsh/
fi
# Link to new .gitconfig
ln -s ~/.fuelingzsh/git/gitconfig ~/.gitconfig

# Backup .gitignore
if [ -f ~/.gitignore ] || [ -h ~/.gitignore ]
then
	mv ~/.gitignore ~/.pre-fuelingzsh/
fi
# Link to new .gitignore
ln -s ~/.fuelingzsh/git/gitignore ~/.gitignore

# Backup .inputrc
if [ -f ~/.inputrc ] || [ -h ~/.inputrc ]
then
	mv ~/.inputrc ~/.pre-fuelingzsh/
fi
# Link to new .inputrc
ln -s ~/.fuelingzsh/yadr/vimify/inputrc ~/.inputrc

# Backup .tmux.conf
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]
then
	mv ~/.tmux.conf ~/.pre-fuelingzsh/
fi
# Link to new .tmux.conf
ln -s ~/.fuelingzsh/yadr/tmux/tmux.conf ~/.tmux.conf

# Backup .vim
if [ -f ~/.vim ] || [ -h ~/.vim ]
then
	mv ~/.vim ~/.pre-fuelingzsh/
fi
# Link to new .vim
ln -s ~/.fuelingzsh/yadr/vim ~/.vim

# Backup .vimrc
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]
then
	mv ~/.vimrc ~/.pre-fuelingzsh/
fi
# Link to new .vimrc
ln -s ~/.fuelingzsh/yadr/vimrc ~/.vimrc

# Backup .zlogin
if [ -f ~/.zlogin ] || [ -h ~/.zlogin ]
then
	mv ~/.zlogin ~/.pre-fuelingzsh/
fi
# Link to new .zlogin
ln -s ~/.fuelingzsh/yadr/zsh/prezto/runcoms/zlogin ~/.zlogin

# Backup .zprezto
if [ -f ~/.zprezto ] || [ -h ~/.zprezto ]
then
	mv ~/.zprezto ~/.pre-fuelingzsh/
fi
# Link to new .zprezto
ln -s ~/.fuelingzsh/yadr/zsh/prezto ~/.zprezto

# Backup .zpreztorc
if [ -f ~/.zpreztorc ] || [ -h ~/.zpreztorc ]
then
	mv ~/.zpreztorc ~/.pre-fuelingzsh/
fi
# Link to new .zpreztorc
ln -s ~/.fuelingzsh/zpreztorc ~/.zpreztorc

# Backup .zshenv
if [ -f ~/.zshenv ] || [ -h ~/.zshenv ]
then
	mv ~/.zshenv ~/.pre-fuelingzsh/
fi
# Link to new .zshenv
ln -s ~/.fuelingzsh/yadr/zsh/prezto/runcoms/zshenv ~/.zshenv

# Backup .zshrc
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
	mv ~/.zshrc ~/.pre-fuelingzsh/
fi
# Link to new .zshrc
ln -s ~/.fuelingzsh/zshrc ~/.zshrc

# Link to pianbar config file and notifier file
ln -sf ~/.fuelingzsh/custom/pianobarconfig ~/.config/pianobar/config
ln -sf ~/.fuelingzsh/pianobar/pianobar-notify.rb ~/.config/pianobar/pianobar-notify.rb

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc

# Adding vundle installer
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
