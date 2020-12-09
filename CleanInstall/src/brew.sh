#!/usr/bin/env bash

if test ! "$( which brew )"; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

formulas=(
    ack
    autojump
    bat
    csvkit
    diff-so-fancy
    exa
    fasd
    fd
    fpp
    fzf
    git
    git-flow
    highlight
    httpie
    hub
    ncdu
    nnn
    prettyping
    terminal-notifier
    tesseract
    tldr
    trash
    vim
    z
    mas
    mycli
    mysql@5.7
    postgresql
    pgcli
    redis
    sqlite --with-json1
    php@7.4 --build-from-source
    php-cs-fixer
    phpmd
    composer
    yarn
    yqrashawn/goku/goku
    mackup
    nvm
    zsh
    # wp-cli
)

for formula in "${formulas[@]}"; do
    formula_name=$( echo "$formula" | awk '{print $1}' )
    if brew list "$formula_name" > /dev/null 2>&1; then
        echo "$formula_name already installed... skipping."
    else
        brew install "$formula"
    fi
done

# After the install, setup fzf
echo -e "\\n\\nRunning fzf install script..."
echo "=============================="
/usr/local/opt/fzf/install --all --no-bash --no-fish

brew services start mysql@5.7
brew link mysql@5.7 --force
brew services start postgresql
createdb `whoami`
brew services start redis
brew link php@7.4 --force

casks=(
    iterm2
    atom
    sublime-text
    sublime-merge
    alfred
    appcleaner
    dash
    tableplus
    betterzip
    qlcolorcode
    qlstephen
    qlmarkdown
    quicklook-json
    quicklook-csv
    qlimagesize
    qlvideo
    cursorcerer
    hammerspoon
    kaleidoscope
    microsoft-teams
    vlc
    bartender
    choosy
    discord
    karabiner-elements
    hazel
    witch
    postman
    notion
)

for cask in "${casks[@]}"; do
    cask_name=$( echo "$cask" | awk '{print $1}' )
    if brew cask list "$cask_name" > /dev/null 2>&1; then
        echo "$cask_name already installed... skipping."
    else
        brew cask install "$cask"
    fi
done
