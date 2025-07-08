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
alias yrn='export NODE_OPTIONS= && yarn'
y() {yrn "$@"}
yv() {yrn --version "$@"}
yi() {yrn install "$@"}
ya() {yrn add "$@"}
yad() {yrn add --dev "$@"}
yl() {yrn list "$@"}
yu() {yrn upgrade "$@"}
yrm() {yrn remove "$@"}
yf() {yrn search "$@"}
yod() {yrn outdated "$@"}

alias yga='yrn global add'
alias ygu='yrn global upgrade'
alias ygrm='yrn global remove'

alias yui='yrn upgrade-interactive'
alias yuil='yui --latest'

yr() {yrn run "$@"}
yp() {yrn run prod "$@"}
yd() {yrn run dev "$@"}
yw() {yrn run watch "$@"}
alias yt='yrn run test'
alias ytw='yrn run test:watch'
alias ys='yrn serve'
alias yb='yrn build'
# alias ysu='brew upgrade yarn'

# NPM
# --openssl-legacy-provider
n() {npm "$@"}
nv() {npm --version "$@"}
nh() {npm -l "$@"}
ni() {npm install "$@"}
na() {npm install --save "$@"}
nad() {npm install --save-dev "$@"}
nl() {npm list "$@"}
nu() {npm update "$@"}
nrm() {npm uninstall "$@"}
nf() {npm search "$@"}
nod() {npm outdated "$@"}

alias nga='npm install -g'
alias ngu='npm update -g'
alias ngrm='npm uninstall -g'

nr() {npm run "$@"}
np() {npm run prod "$@"}
nd() {npm run dev "$@"}
nw() {npm run watch "$@"}
alias nt='npm run test'
alias ntw='npm run test:watch'
alias ns='npm serve'
alias nb='npm run build'
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
