# Xdebug
alias xdebug:disable='echo "" > $(php --ini | grep xdebug)'
alias xdebug:enable='command cat $(php --ini | grep xdebug).back > $(php --ini | grep xdebug)'
alias xdd='xdebug:disable'
alias xde='xdebug:enable'

alias t='ts'

alias ts='td --stop-on-failure'
alias ta='td'
alias tf='td --filter --stop-on-failure'
alias tfa='td --filter'

alias td='phpunit:run --testdox'
alias ti='phpunit:run --stop-on-failure'
alias tia='phpunit:run'

alias tcc='rm .phpunit.result.cache'

tfm() {
    for i in {1..50}; do
        tf "$@"
    done
}

alias tge='t --exclude-group'
alias tg='t --group'
alias tpg='tp --group'
alias tdg='td --group'

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

phpunit:run() {
    suffix=(--cache-result --order-by=defects $@)

    clear

    if [ -f vendor/bin/phpunit ]; then
        vendor/bin/phpunit ${suffix[@]}
    else
        phpunit ${suffix[@]}
    fi
}
