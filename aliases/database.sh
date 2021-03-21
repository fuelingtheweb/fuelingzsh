function db:create () { mysql -uroot -e "create database $1" }
function pg:create () { createdb $1 }
function db:drop () { mysql -uroot -e "drop database $1" }
function db:export () { mysqldump -u root $1 > ~/Downloads/$1.sql }
function db:import () { mysql -u root $1 < ~/Downloads/$1.sql }
function db:import:dump () { mysql -u root $1 < ~/Downloads/$1.dump }
function pg:import () { psql -f ~/Downloads/$1.sql $1 -U nathan -h localhost -W }
function db:dump-all () {
    cd ~/Downloads
    for DB in $(mysql -e 'show databases' -s --skip-column-names); do
        echo $DB
        if [ $DB != 'information_schema' ] && [ $DB != 'performance_schema' ]; then
            mysqldump $DB > "$DB.sql";
        fi
    done
}
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
