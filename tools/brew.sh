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
