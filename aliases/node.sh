function yarnOrNpm:get() {
    if [[ -f "package-lock.json" ]]; then
        echo 'n'
    else
        echo 'y'
    fi
}

yarnOrNpm:run() {
    command="$(yarnOrNpm:get)$1"
    shift
    echo "Running $command $@"
    $command "$@"
}

# Yarn or NPM
alias yn='yarnOrNpm:run'
alias ynv='yarnOrNpm:run v'
alias ynh='yarnOrNpm:run h'
alias yni='yarnOrNpm:run i'
alias yna='yarnOrNpm:run a'
alias ynad='yarnOrNpm:run ad'
alias ynl='yarnOrNpm:run l'
alias ynu='yarnOrNpm:run u'
alias ynrm='yarnOrNpm:run rm'
alias ynf='yarnOrNpm:run f'
alias ynod='yarnOrNpm:run od'
alias ynr='yarnOrNpm:run r'
alias ynw='yarnOrNpm:run w'
alias ynp='yarnOrNpm:run p'
alias ynd='yarnOrNpm:run d'

# Yarn
y() {yarn "$@"}
yv() {yarn --version "$@"}
yi() {yarn install "$@"}
ya() {yarn add "$@"}
yad() {yarn add --dev "$@"}
yl() {yarn list "$@"}
yu() {yarn upgrade "$@"}
yrm() {yarn remove "$@"}
yf() {yarn search "$@"}
yod() {yarn outdated "$@"}

alias yga='yarn global add'
alias ygu='yarn global upgrade'
alias ygrm='yarn global remove'

alias yui='yarn upgrade-interactive'
alias yuil='yui --latest'

yr() {yarn run "$@"}
yp() {yarn run prod "$@"}
yd() {yarn run dev "$@"}
yw() {yarn run watch "$@"}
alias yt='yarn run test'
alias ytw='yarn run test:watch'
alias ys='yarn serve'
alias yb='yarn build'
# alias ysu='brew upgrade yarn'

# NPM
n() {npm --openssl-legacy-provider "$@"}
nv() {npm --version "$@"}
nh() {npm -l "$@"}
ni() {npm --openssl-legacy-provider install "$@"}
na() {npm --openssl-legacy-provider install --save "$@"}
nad() {npm --openssl-legacy-provider install --save-dev "$@"}
nl() {npm list "$@"}
nu() {npm --openssl-legacy-provider update "$@"}
nrm() {npm --openssl-legacy-provider uninstall "$@"}
nf() {npm search "$@"}
nod() {npm outdated "$@"}

alias nga='npm --openssl-legacy-provider install -g'
alias ngu='npm --openssl-legacy-provider update -g'
alias ngrm='npm --openssl-legacy-provider uninstall -g'

nr() {npm run "$@"}
np() {npm run prod "$@"}
nd() {npm run dev "$@"}
nw() {npm run watch "$@"}
alias nt='npm run test'
alias ntw='npm run test:watch'
alias ns='npm serve'
alias nb='npm build'
# alias nsu='brew upgrade yarn'

# Volta
alias vt='volta'
alias vtv='volta --version'
alias vth='volta --help'
alias vta='volta install'
alias vtl='volta list'
alias vtlc='volta list --current'
alias vtld='volta list --default'
alias vtrm='volta uninstall'
alias vtp='volta pin'

# Gulp
alias gp='gulp'
alias gpw='gulp watch'
alias gpp='gulp --production'
