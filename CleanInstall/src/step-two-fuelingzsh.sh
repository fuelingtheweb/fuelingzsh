success 'Installing FuelingZsh.'

source $src/brew.sh

git clone git@github.com:ohmyzsh/ohmyzsh.git $OHMYZSH
git clone git@github.com:romkatv/powerlevel10k.git $OHMYZSH/custom/themes/powerlevel10k
git clone git@github.com:zdharma/fast-syntax-highlighting.git $OHMYZSH/custom/plugins/fast-syntax-highlighting
git clone git@github.com:zsh-users/zsh-autosuggestions.git $OHMYZSH/custom/plugins/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git $OHMYZSH/custom/plugins/zsh-syntax-highlighting

git clone git@github.com:tonsky/FiraCode.git $HOME/FiraCode
cp $HOME/FiraCode/distr/ttf/* $HOME/Library/Fonts/
rm -rf $HOME/FiraCode

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
    .prettierrc
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
cp $FUELINGZSH/options/fonts/Droid+Sans+Mono+Awesome.ttf $HOME/Library/Fonts/Droid+Sans+Mono+Awesome.ttf
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
