function yarnOrNpm:get() {
    if [[ -f "package-lock.json" ]]; then
        echo 'np'
    else
        echo 'yy'
    fi
}

yarnOrNpm:run() {
    command="$(yarnOrNpm:get)$1"
    shift
    $command "$@"
}

# Yarn
y() {
    ${$(yarnOrNpm:get)} "$@"
}
alias yv='yarn --version'
alias yh='yarn help'
alias yi='yarnOrNpm:run i'
alias ya='yarnOrNpm:run a'
alias yad='yarnOrNpm:run ad'
alias yl='yarnOrNpm:run l'
alias yu='yarnOrNpm:run u'
alias yrm='yarnOrNpm:run rm'
alias yf='yarnOrNpm:run f'
alias yod='yarnOrNpm:run od'

yy() {
    yarn
}
yyi() {
    yarn install
}
yya() {
    yarn add "$@"
}
yyad() {
    yarn add --dev "$@"
}
yyl() {
    yarn list
}
yyu() {
    yarn upgrade "$@"
}
yyrm() {
    yarn remove "$@"
}
yyf() {
    yarn search "$@"
}
yyod() {
    yarn outdated
}

alias yga='yarn global add'
alias ygu='yarn global upgrade'
alias ygrm='yarn global remove'

alias yui='yarn upgrade-interactive'
alias yuil='yui --latest'

alias yr='yarn run'
alias yp='yarn run prod'
alias yd='yarn run dev'
alias yw='yarn run watch'
alias yt='yarn run test'
alias ytw='yarn run test:watch'
alias ys='yarn serve'
alias yb='yarn build'

# NPM
np() {
    if [ "$1" ]; then
        npm "$1"
    else
        npm install
    fi
}
alias npv='npm --version'
alias nph='npm -l'
npi() {
    npm install
}
npa() {
    npm install --save "$@"
}
npad() {
    npm install --save-dev "$@"
}
npl() {
    npm list
}
npu() {
    npm update "$@"
}
nprm() {
    npm uninstall "$@"
}
npf() {
    npm search "$@"
}
npod() {
    npm outdated
}

alias npga='npm install -g'
alias npgu='npm update -g'
alias npgrm='npm uninstall -g'

# NVM
alias nv='nvm'
alias nvv='nvm --version'
alias nvh='nvm --help'
alias nva='nvm install'
alias nvl='nvm ls'
alias nvrm='nvm uninstall'

alias nvc='nvm current'
alias nval='nvm alias'
alias nvu='nvm use'

# Gulp
alias gp='gulp'
alias gpw='gulp watch'
alias gpp='gulp --production'
