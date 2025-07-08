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

alias dust='vendor/bin/duster fix'
alias dusty='vendor/bin/duster lint'
alias dustd='vendor/bin/duster fix --dirty'

dep:upgrade() {
    git branch -D ntm/upgrade-dependencies
    git checkout -b ntm/upgrade-dependencies
    composer upgrade
    git add composer.*
    git commit -m 'Upgrade composer dependencies'
    npm upgrade
    git commit -am 'Upgrade npm dependencies'
    git push --set-upstream origin ntm/upgrade-dependencies
    gh pr view --title "Upgrade dependencies" --web
}

benchmark() {
    iterations=$1
    url=$2

    echo "✨ Preloading to warm cache"
    curl -s -o /dev/null $url

    echo "⏳ Benchmarking $url ($iterations iterations)"

    totaltime=0.0
    for run in $(seq 1 $iterations)
    do
    time=$(curl $url -s -o /dev/null -w "%{time_total}")
    totaltime=$(echo "$totaltime" + "$time" | bc)
    done

    avgtimeMs=$(echo "scale=1; 1000*$totaltime/$iterations" | bc)

    echo "✅ $avgtimeMs ms"
}
