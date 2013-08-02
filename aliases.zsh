# Aliases in this file are bash and zsh compatible

# File/Folder Listing
alias ls='ls -GF' # Display listing with colorized output (-G) and folder/file indicators
alias lm='find . -mtime -1' # Display list of files modified within the last 24 hours

# Changing Directories
alias cdb='cd -' # Go back to previous directory
function cl () { cd $1 && ls } # Change to and list out directory
alias cd.="cd .." # Go up one directory
alias cd..="cd ../.." # Go up two directories
alias cd...="cd ../../.." # Go up three directories
alias cd....="cd ../../../.." # Go up four directories
alias cd.....="cd ../../../../.." # Go up five directories
alias cl.="cd .. && ls" # Go up one directory and list out
alias cl..="cd ../.. && ls" # Go up two directories and list out
alias cl...="cd ../../.. && ls" # Go up three directories and list out
alias cl....="cd ../../../.. && ls" # Go up four directories and list out
alias cl.....="cd ../../../../.. && ls" # Go up five directories and list out

# Miscellaneous
alias mkdir="mkdir -p" # Make directory or multiple directories if any don't exist
alias c="clear"
alias bc="bc -l -q" # Run Calculator
alias h="history | less +G"
alias v="vim"
alias rmr="rm -R" # Remove directory and anything within directory
alias vf="vifm"
alias pn="pianokeys && pianobar" # Start Pianobar for Pandora
alias q="exit"
alias untar="tar -zxvf"
function mkdircd () { mkdir $1 && cd $1 } # Make directory and change to that directory

# Printer
alias prinfo="lpstat -p -d" # List printers
alias pr="lpr" # Print file

# Notes
function n() { $EDITOR ~/.notes/"$*".txt } # Open notes file, creating a new one if it doesn't exist
function nls() { ls -c ~/.notes/ | grep "$*" } # List out notes files

# PS
alias psa="ps aux"
alias psg="ps aux | grep "
alias psr='ps aux | grep ruby'

# Show human friendly numbers and colors
alias df='df -h'
alias ll='ls -alGh'
alias ls='ls -GhF'
alias du='du -h -d 2'

# show me files matching "ls grep"
alias lsg='ll | grep'

# Alias Editing
alias ae='vim $fuelingzsh/aliases.zsh' #alias edit
alias ar='source $fuelingzsh/aliases.zsh'  #alias reload

# vimrc editing
alias ve='vim ~/.vimrc'

# zsh profile editing
alias ze='vim ~/.zshrc'
alias zr='source ~/.zshrc'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'

alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vim .gitignore'
#alias gcm='git ci -m'
alias gcim='git ci -m'
alias gci='git ci'
alias gco='git co'
alias gcp='git cp'
#alias ga='git add -A'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias glg='git l'
alias glog='git l'
alias co='git co'
alias gf='git fetch'
alias gfch='git fetch'
alias gd='git diff'
alias gb='git b'
alias gbd='git b -D -w'
alias gdc='git diff --cached -w'
alias gpub='grb publish'
alias gtr='grb track'
alias gplr='git pull --rebase'
alias gnb='git nb' # new branch aka checkout -b
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gt='git t'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gitlog="git log --oneline --all --graph --decorate"

# Common shell functions
alias less='less -r'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias screen='TERM=screen screen'

# Zippin
alias gz='tar -zcvf'

alias ka9='killall -9'
alias k9='kill -9'

