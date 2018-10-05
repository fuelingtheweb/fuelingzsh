alias ctags="`brew --prefix`/bin/ctags"
alias tb='titanium build --platform ios'
alias pjs='phantomjs --webdriver=4444 --ignore-ssl-errors=true'
alias ses='java -jar /usr/local/bin/selenium-server-standalone-2.47.1.jar'
alias svr='sudo /usr/sbin/apachectl restart'
function mdb () { mysql -uroot -e "create database $1" }
function dropDatabase () { mysql -uroot -e "drop database $1" }
function dumpDatabase () { mysqldump -u root $1 > ~/Downloads/$1.sql }
function importDatabase () { mysql -u root $1 < ~/Downloads/$1.sql }
