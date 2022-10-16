alias ctags="`brew --prefix`/bin/ctags"
alias tb='titanium build --platform ios'
alias pjs='phantomjs --webdriver=4444 --ignore-ssl-errors=true'
alias ses='java -jar /usr/local/bin/selenium-server-standalone-2.47.1.jar'
alias svr='sudo /usr/sbin/apachectl restart'
# Thumbnail for Typerocket page builder
alias rthumb='sips -Z 200 thumbnail.png'

phpmd:run() {
    source=app
    if [ -f "$1" ]; then
        source=$1
    fi

    phpmd "$source" html ~/.phpmd.xml > phpmd.html
}
alias pmd='phpmd:run'
alias pmdo='br ./phpmd.html'

alias csf='php-cs-fixer fix --verbose --diff'
alias csfi='php-cs-fixer fix --verbose'
alias csd='php-cs-fixer fix --verbose --diff --dry-run'
alias csdi='php-cs-fixer fix --verbose --dry-run'
alias cssu='php-cs-fixer self-update'
