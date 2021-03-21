c() {
    if [ "$1" ]; then
        composer "$1"
    else
        composer install
    fi
}
alias cv='composer --version'
alias csu='composer self-update'
alias ch='composer list'
alias ci='composer install'
alias ca='composer require'
alias cad='composer require --dev'
alias cl='composer show'
alias cu='composer update'
alias crm='composer remove'
alias cf='composer search'
alias cod='composer outdated'

alias cga='composer global require'
alias cgu='composer global update'
alias cgrm='composer global remove'

alias cui='composer update -i'
alias cda='composer dump-autoload -o'
