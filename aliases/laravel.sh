artisan() {
    if [ -f bin/artisan ]; then
        php bin/artisan "$@"
    else
        php artisan "$@"
    fi
}

alias log:empty="echo '' > storage/logs/laravel.log"
alias elf='log:empty'

alias lv='laravel'
alias lz='laravel-zero'
alias a='artisan'
alias art='artisan'

alias ah='artisan help'
alias av='artisan --version'
alias lds='artisan dump-server'
alias dsk='artisan dusk'
alias tnk='artisan tinker'
alias as='artisan serve'

# General
alias acc='artisan cache:clear'
alias akg='artisan key:generate'
alias aqw='artisan queue:work'
alias arl='artisan route:list'
alias avp='artisan vendor:publish'
alias aeg='artisan event:generate'

# Database
alias amg='artisan migrate'
alias amgfr='artisan migrate:fresh'
alias amgrf='artisan migrate:refresh'
alias amgrb='artisan migrate:rollback'
alias amgfs='artisan migrate:fresh --seed'
alias adbs='artisan db:seed'

# Make
alias amcmd='artisan make:command'
alias amc='artisan make:controller'
alias amen='artisan make:enum'
alias ame='artisan make:event'
alias amexc='artisan make:exception'
alias amexp='artisan make:export'
amf() {
    NAME="${1}Factory"
    artisan make:factory --model="$1" $NAME
}
alias amj='artisan make:job'
alias aml='artisan make:listener'
alias amma='artisan make:mail'
ammam() {
    artisan make:mail "$1" --markdown "$2"
}
alias ammi='artisan make:middleware'
alias ammg='artisan make:migration'
alias ammd='artisan make:model'
alias amn='artisan make:notification'
alias amo='artisan make:observer'
alias ampo='artisan make:policy'
alias ampr='artisan make:provider'
alias amrq='artisan make:request'
alias amrs='artisan make:resource'
alias amrl='artisan make:rule'
alias ams='artisan make:seeder'
alias amt='artisan make:test'
alias amtu='artisan make:test --unit'

alias amv='artisan make:view'

# From Packages
alias adbbc='artisan debugbar:clear'
alias asv='artisan scrap:view'

# Custom
alias aac='artisan assets:compile'
alias aar='artisan assets:release'
alias arcc='artisan responsecache:clear'

# Dusk
alias ad='artisan dusk'
alias adm='artisan dusk:make'
