success 'Installing FuelingZsh.'

xcode-select --install
info 'Proceed when xcode command line tools are installed.'
pause

info 'If unsuccessful, restart Terminal and skip to step two after enabling xcode.'
info 'If successful, restart Terminal and skip to step three.'
pause

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

trash $HOME/.config/karabiner.edn
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

source $src/osx.sh

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mFueling Zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc

sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
echo 'Restart your terminal'
