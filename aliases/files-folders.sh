# Show human friendly numbers and colors
# alias ls='ls -GhFp'
# alias ll='ls -FGlAhp'
alias ls='exa -1F'
alias lsa='exa -a1F'
alias ll='exa -alF --time-style iso --color=always'
alias lll='exa -alghHF --git --time-style long-iso --color=always'
alias lm='ll --sort modified --reverse --git-ignore'
alias lmh='lm | head'
alias lsg='ll | grep -i'

alias cpr='cp -r'

# Changing Directories
alias cdp='cd -' # Go back to previous directory
function cl () { cd $1 && ls } # Change to and list out directory
alias rmr="rm -R" # Remove directory and anything within directory
mkcd() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}
alias mdc='mkcd'
alias tch='touch'
alias cdc='cd $_'

cdr() {
    control=$(find-up node_modules)

    if [ -d "$control" ]; then
        cd "${control%node_modules}"
    else
        echo 'Root project not found.'
    fi
}

alias organize='ll | fpp -ko -ai'
alias mvf='mv $F'
