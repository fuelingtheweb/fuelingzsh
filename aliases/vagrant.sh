alias vu="vagrant up"
alias vr="vagrant resume"
alias vd="vagrant destroy"
alias vh="vagrant halt"
alias vs="vagrant suspend"
alias vdu="vagrant destroy -f && vagrant up"
alias vssh="vagrant ssh"
alias vpsa="MODULE=source-aliases vagrant provision"
alias vm='ssh vagrant@127.0.0.1 -p 2222'

function homestead() {
    ( cd $HOME/Homestead && vagrant $* )
}

alias hu="homestead up"
alias hr="homestead resume"
alias hd="homestead destroy"
alias hh="homestead halt"
alias hs="homestead suspend"
alias hdu="homestead destroy -f && homestead up"
alias hssh="homestead ssh"
alias hrp="homestead reload --provision"
alias hec="st ~/.homestead/Homestead.yaml"

# Virtualbox
alias vbl='vboxmanage list vms'
alias vblr='vboxmanage list runningvms'
