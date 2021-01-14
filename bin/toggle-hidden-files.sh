#! /bin/bash

if [ $(defaults read com.apple.finder AppleShowAllFiles) = "YES" ]
then
    defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app
    echo 'Files Hidden'
elif [ $(defaults read com.apple.finder AppleShowAllFiles) = "NO" ]
then
    defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app
    echo 'Files Shown'
fi
