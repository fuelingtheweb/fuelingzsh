alias ssh:new='ssh-keygen -t rsa'
alias ssh:add='ssh-add'
ssh:copy() {
    cat $HOME/.ssh/${1:-id_rsa.pub} | pbcopy
}
alias sshc='ssh:copy'
