alias ctags="`brew --prefix`/bin/ctags"
alias tb='titanium build --platform ios'
alias pjs='phantomjs --webdriver=4444 --ignore-ssl-errors=true'
alias ses='java -jar /usr/local/bin/selenium-server-standalone-2.47.1.jar'
alias svr='sudo /usr/sbin/apachectl restart'
# Thumbnail for Typerocket page builder
alias rthumb='sips -Z 200 thumbnail.png'
function db:create () { mysql -uroot -e "create database $1" }
function pg:create () { createdb $1 }
function db:drop () { mysql -uroot -e "drop database $1" }
function db:export () { mysqldump -u root $1 > ~/Downloads/$1.sql }
function db:import () { mysql -u root $1 < ~/Downloads/$1.sql }
function db:import:dump () { mysql -u root $1 < ~/Downloads/$1.dump }
function pg:import () { psql -f ~/Downloads/$1.sql $1 -U nathan -h localhost -W }
alias db='mycli'
alias dbc='db:create'
alias dbi='db:import'
alias dbe='db:export'
function ipgdb () {
    # $1 = path/to/file, $2 = db name
    psql -f $1 $2 -U nathan -h localhost -W
}
function rpgdb () {
    # $1 = path/to/file, $2 = db name
    # psql -f $1 $2 -U nathan -h localhost -W
    # pg_restore -h host -p port -d db_name archive_file.dump
    pg_restore -d $2 $1
}
function pg:export () {
    # $1 = db name
    pg_dump -U nathan -W -F t $1 > $HOME/Downloads/$1.tar
}


phpmd:run() {
    source=app
    if [ -f "$1" ]; then
        source=$1
    fi

    phpmd "$source" html ~/.phpmd.xml > phpmd.html
}
alias pmd='phpmd:run'
alias pmdo='br ./phpmd.html'

alias va='valet'
alias val='valet link'
alias vals='valet links'
