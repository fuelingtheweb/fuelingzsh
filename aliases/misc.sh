alias cat='bat'
alias ping='prettyping --nolegend'
alias fnd='command fd -c always'
alias du="ncdu --color dark -rr -x --si --exclude .git --exclude node_modules --exclude vendor"
alias nn='nnn'
alias help='tldr'
agif() {
    ag $1 -G $2
}
alias sdi='sed -i ""'
alias cvl='csvlook'
alias _='sudo'
alias w='which'
alias c="clear"
alias h='cd ~/'
alias hc='cd ~/ && clear'
alias bc="bc -l -q" # Run Calculator
alias hi="history | less +G"
alias vf="vifm"
alias pn="pianokeys && pianobar" # Start Pianobar for Pandora
alias q="exit"
alias untar="tar -zxvf"
alias prinfo="lpstat -p -d" # List printers
alias pr="lpr" # Print file
alias psa="ps aux"
alias psg="ps aux | grep "
alias psr='ps aux | grep ruby'
alias less='less -r'
alias tlf='tail -f'
alias l='less'
alias screen='TERM=screen screen'
alias gz='tar -zcvf' # Zippin
alias ka9='killall -9'
alias k9='kill -9'
alias kp='kill -9'
alias pwdc="pwd | tr -d '\n' | pbcopy && echo 'pwd copied to clipboard'"
# alias duc='du -hc -d=1 *'
alias o='open'
alias o.='open .'
alias wdl='wd list'
alias wda="wd add"
alias rm='trash'
alias pls='sudo $(fc -ln -1)'
alias files:hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias files:show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias br='open -a "Google Chrome"'
alias ydl='youtube-dl'
alias ke='st ~/.config/karabiner.edn'
alias kc='goku'
alias kcw='gokuw'
alias cleaninstall="$FUELINGZSH/CleanInstall/start.sh"
alias pdf:combine="/usr/local/bin/gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf"
alias pdf:compress="/usr/local/bin/gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -sOutputFile=small.pdf" # ebook | screen
