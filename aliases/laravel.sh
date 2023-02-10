alias log:empty="echo '' > storage/logs/laravel.log"
alias elf='log:empty'
alias cpe='cp .env.example .env'
alias er='envoy run'
alias edy='envoy run deploy'
alias ers='envoy run reseed'

alias lsu='ci && cpe && akg && yi && yd'

alias lv='laravel'
alias lz='laravel-zero'
alias artisan='php artisan'
alias a='php artisan'

alias ah='artisan help'
alias av='artisan --version'
alias lds='artisan dump-server'
alias dsk='artisan dusk'
alias tnk='artisan tinker'
alias as='artisan serve'

# General
alias acc='artisan cache:clear'
alias avc='artisan view:clear'
alias akg='artisan key:generate'
alias aqw='artisan queue:work'
alias arla='artisan route:list'
alias arl='artisan route:list --columns=method,uri,name,action'
alias avp='artisan vendor:publish'
alias aeg='artisan event:generate'

# Database
alias amg='artisan migrate'
alias amgfr='artisan migrate:fresh'
alias amgrb='artisan migrate:rollback'
alias amgfs='artisan migrate:fresh --seed'
alias adbs='artisan db:seed'

# Make
alias am='artisan make'
alias amcmd='artisan make:command'
alias amcom='artisan make:component'
alias amc='artisan make:controller'
alias amca='artisan make:cast'
alias amen='artisan make:enum'
alias ame='artisan make:event'
alias amexc='artisan make:exception'
alias amexp='artisan make:export'
amf() {
    NAME="${1}Factory"
    artisan make:factory --model="$1" $NAME
}
alias ami='artisan make:import'
alias amj='artisan make:job'
alias aml='artisan make:listener'
alias amma='artisan make:mail'
ammam() {
    artisan make:mail "$1" --markdown "$2"
}
alias ammi='artisan make:middleware'
alias ammg='artisan make:migration --fullpath'
ammgc() {
    ammg "create_$1_table" --create "$1"
}
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
alias amw='artisan make:livewire'

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

alias atp='artisan test --parallel --stop-on-failure'
