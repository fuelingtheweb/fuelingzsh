success 'Installing Pianobar.'
brew install pianobar
mkdir $HOME/.config/pianobar
ln -s $ANVIL/pianobar/pianobar-notify.rb $HOME/.config/pianobar/pianobar-notify.rb
ln -s $ANVIL/custom/pianobarconfig $HOME/.config/pianobar/config
mkfifo $HOME/.config/pianobar/ctl
# git clone https://github.com/shayne/PianoKeys.git $HOME/.config/pianokeys
# cd $HOME/.config/pianokeys
# sudo xcodebuild -license
# xcodebuild -configuration Release install
ln -s $ANVIL/pianobar/pianokeys /usr/local/bin/pianokeys
