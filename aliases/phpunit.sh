# Xdebug
alias xdebug:disable='echo "" > $(php --ini | grep xdebug)'
alias xdebug:enable='command cat $(php --ini | grep xdebug).back > $(php --ini | grep xdebug)'
alias xdd='xdebug:disable'
alias xde='xdebug:enable'

# Testing
t() {
    clear
    if [ -f vendor/bin/phpunit ]; then
        vendor/bin/phpunit --stop-on-failure "$@"
    else
        phpunit --stop-on-failure "$@"
    fi
}

alias tp='t --printer=Codedungeon\\PHPUnitPrettyResultPrinter\\Printer'
alias td='t --testdox'

alias tf='t --filter'
alias tpf='tp --filter'
alias tdf='td --filter'

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
