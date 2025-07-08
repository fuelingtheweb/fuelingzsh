alias sshn='ssh:new'
alias ssha='ssh:add'
alias sshc='ssh:copy'
alias sshe='ssh:edit'

alias ssh:add='ssh-add'

ssh:copy() {
    cat $HOME/.ssh/${1:-id_rsa}.pub | pbcopy
}

ssh:edit() {
    code $HOME/.ssh/config
}
