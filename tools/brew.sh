#!/usr/bin/env bash

if test ! "$( which brew )"; then
    echo "Installing homebrew"
    ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
fi

formulas=(
    ack
    bat
    circleci
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
    mysql
    ncdu
    nnn
    php
    prettyping
    sqlite
    terminal-notifier
    tesseract
    tldr
    trash
    vim
    z
    mas
    composer
    yarn
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

brew services start mysql

casks=(
    iterm2
    atom
    sublime-text
    sublime-merge
    alfred
    appcleaner
    dash
    hyperswitch
)

for cask in "${casks[@]}"; do
    cask_name=$( echo "$cask" | awk '{print $1}' )
    if brew cask list "$cask_name" > /dev/null 2>&1; then
        echo "$cask_name already installed... skipping."
    else
        brew cask install "$cask"
    fi
done
