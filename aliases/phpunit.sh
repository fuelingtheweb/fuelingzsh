# Xdebug
alias xdebug:disable='echo "" > $(php --ini | grep xdebug)'
alias xdebug:enable='command cat $(php --ini | grep xdebug).back > $(php --ini | grep xdebug)'
alias xdd='xdebug:disable'
alias xde='xdebug:enable'

# Testing
t() {
    clear
    if [ -f artisan ]; then
        php artisan test --parallel --exclude-group NeedsInternet --stop-on-failure "$@"
    elif [ -f vendor/bin/phpunit ]; then
        vendor/bin/phpunit --exclude-group NeedsInternet --stop-on-failure "$@"
    else
        phpunit --exclude-group NeedsInternet --stop-on-failure "$@"
    fi
}

ta() {
    clear
    if [ -f artisan ]; then
        php artisan test --parallel --exclude-group NeedsInternet "$@"
    elif [ -f vendor/bin/phpunit ]; then
        vendor/bin/phpunit --exclude-group NeedsInternet "$@"
    else
        phpunit --exclude-group NeedsInternet "$@"
    fi
}

taa() {
    clear
    if [ -f artisan ]; then
        php artisan test --parallel --group LocalOnly,NeedsInternet,NeedsRedis,default --stop-on-failure "$@"
    elif [ -f vendor/bin/phpunit ]; then
        vendor/bin/phpunit --group LocalOnly,NeedsInternet,NeedsRedis,default --stop-on-failure "$@"
    else
        phpunit --group LocalOnly,NeedsInternet,NeedsRedis,default --stop-on-failure "$@"
    fi
}

alias tv='vendor/bin/phpunit --exclude-group NeedsInternet --stop-on-failure'

alias tp='t --printer=Codedungeon\\PHPUnitPrettyResultPrinter\\Printer'
alias td='tv --testdox'

alias tf='t --filter'
alias tpf='tp --filter'
alias tdf='td --filter'

alias tge='t --exclude-group'
alias tg='t --group'
alias tpg='tp --group'
alias tdg='td --group'
alias tgi='tg Integration'
alias tpgi='tpg Integration'
alias tdgi='tdg Integration'

# Code Coverage
tc() {
    xdebug:enable
    t --coverage-html ./tests/coverage "$@"
    xdebug:disable
}

tpc() {
    xdebug:enable
    tp --coverage-html ./tests/coverage "$@"
    xdebug:disable
}

tdc() {
    xdebug:enable
    td --coverage-html ./tests/coverage "$@"
    xdebug:disable
}

alias tco='br ./tests/coverage/index.html'
