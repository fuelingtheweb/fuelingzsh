success 'Installing FuelingZsh.'

source $src/brew.sh

# Init and Update submodules
cd $FUELINGZSH
git submodule update --init --recursive

dotfiles=(
    .gitignore
    .zshrc
    .my.cnf
    .myclirc
    .npmrc
    .phpmd.xml
    .php_cs
    .bash_profile
    .hammerspoon
    .lambo
    .ctags
    .mackup
    .mackup.cfg
)

for file in "${dotfiles[@]}"; do
    trash "$HOME/$file"
    ln -s "$FUELINGZSH/dotfiles/$file" "$HOME/$file"
done

trash $FUELINGZSH/custom
trash $FUELINGZSH/aliases/custom
trash $FUELINGZSH/dotfiles/.hammerspoon/Spoons/Custom.spoon
ln -s $HOME/Dropbox/Ftw/fuelingzsh-custom/custom $FUELINGZSH/custom
ln -s $HOME/Dropbox/Ftw/fuelingzsh-custom/aliases/custom $FUELINGZSH/aliases/custom
ln -s $HOME/Dropbox/Ftw/fuelingzsh-custom/dotfiles/.hammerspoon/Spoons/Custom.spoon $FUELINGZSH/dotfiles/.hammerspoon/Spoons/Custom.spoon
trash $HOME/.config/karabiner.edn
mkdir $HOME/.config
ln -s $FUELINGZSH/karabiner/karabiner.edn $HOME/.config/karabiner.edn
trash $HOME/.warprc
ln -s $FUELINGZSH/custom/dotfiles/.warprc $HOME/.warprc
ln -s $FUELINGZSH/custom/espanso $HOME/Library/Preferences/espanso
ln -s $FUELINGZSH/options/oh-my-zsh/themes/powerlevel10k $FUELINGZSH/oh-my-zsh/custom/themes/powerlevel10k
cp $FUELINGZSH/options/fonts/Droid+Sans+Mono+Awesome.ttf $HOME/Library/Fonts/Droid+Sans+Mono+Awesome.ttf
cp $FUELINGZSH/options/fonts/FiraCode/distr/ttf/* $HOME/Library/Fonts/
ln -s $FUELINGZSH/options/oh-my-zsh/plugins/zsh-autosuggestions $FUELINGZSH/oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s $FUELINGZSH/options/oh-my-zsh/plugins/zsh-syntax-highlighting $FUELINGZSH/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -s $FUELINGZSH/options/oh-my-zsh/plugins/fast-syntax-highlighting $FUELINGZSH/oh-my-zsh/custom/plugins/fast-syntax-highlighting
touch $HOME/.hushlogin

ln -s $HOME/Dropbox/Ftw/Mackup/Library/Preferences/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist

espanso register
espanso start

goku

info 'Open Karabiner.'
open -a 'Karabiner-Elements.app'
info 'Confirm profile is named Default.'
pause

info 'Open Hammerspoon.'
open -a 'Hammerspoon.app'
pause

info 'Confirm Karabiner and Hammerspoon are working.'
pause

source $src/osx.sh

success 'Changing default shell to zsh. Restart computer, open iTerm, and run cleaninstall.'
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
chsh -s `which zsh`
