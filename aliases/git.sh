# alias git='hub'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbl='git branch --list'
function gbdg () { git branch --list $1 | xargs git branch -d }
alias gcnf='git config'
alias gcnfg='git config --global'
alias nah='git reset --hard; git clean -df;'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gpl='git pull'
alias gps='git push'
alias gpsnv='git push --no-verify'
alias gcf='git checkout -f'
alias gmd='git merge develop'
alias gmm='git merge master'
alias grm='git rebase master'
alias grd='git rebase develop'
alias grc='git rebase --continue'
alias gin='git init'
alias cdu='cd $(git rev-parse --show-toplevel)'

# Commit
git:commit() {
    if [ "$1" ]; then
        git commit -m "$1"
    else
        git commit
    fi
}
alias gc='git:commit'
alias gca='git commit -a -m'
alias gcam='git commit --amend'
alias gcamn='git commit --amend --no-edit'
alias gunc='git uncommit'

alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='st .gitignore'
alias gci='git check-ignore -v'
alias gcp='git cp'
alias gcpn='git cherry-pick -n'
alias guns='git unstage'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias grsu='git remote set-url'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gma='git merge --abort'
# alias gl='git l'
alias glg='git l'
alias glog='git l'
alias gf='git fetch'
alias gfch='git fetch'
alias gd='git diff'
alias gdt='git difftool'
alias gds='git diff --staged'
#alias gbd='git b -D -w'
alias gdc='git diff --cached -w'
alias gpub='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gtr='grb track'
alias gplr='git pull --rebase'
alias gnb='git nb' # new branch aka checkout -b
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
#alias gt='git t'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gitlog="git log --oneline --all --graph --decorate"
alias gl="git log --date=short --decorate"

alias deploy="git checkout master && git pull && git merge develop && git push && git checkout develop"

alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gcop='git checkout -'
alias gb='git branch -v'
alias gba='git branch -av'
alias gt='git tag'
alias gtt='git tag | tail'
alias gpst='git push origin --tags'
alias gtc='echo -n $(git tag | tail -1) | pbcopy'
alias gbc='echo -n $(git rev-parse --abbrev-ref HEAD) | pbcopy'
alias gau='git add -u'

alias gcob='git checkout -b'
alias gcompl='gcom && gpl'
alias gcodpl='gcod && gpl'

# Git Flow Commands
alias gfhs='git flow hotfix start'
alias gfhf='git flow hotfix finish'
alias gcof='git flow feature checkout'
alias gffs='git flow feature start'
alias gffp='git flow feature publish'
alias gfff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'
alias gfi='git flow init'
alias gfid='git flow init -d'

alias gbsa='git for-each-ref --sort=committerdate refs/heads/ --format="%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))"'
alias gbsd='git for-each-ref --sort=-committerdate refs/heads/ --format="%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))"'

alias go='git open'

# Stash
alias gst='git stash'
alias gstu='git stash -u'
alias gstl='git stash list'
alias gstc='git stash clear'
alias gstsv='git stash save'
alias gstsvu='git stash save -u'
stash:pop() {
    if [ "$1" ]; then
        git stash pop stash@{"$1"}
    else
        git stash pop
    fi
}
stash:apply() {
    if [ "$1" ]; then
        git stash apply stash@{$1}
    else
        git stash apply
    fi
}
stash:show() {
    if [ "$1" ]; then
        git stash show stash@{$1}
    else
        git stash show
    fi
}
stash:show-patch() {
    if [ "$1" ]; then
        git stash show -p stash@{$1}
    else
        git stash show -p
    fi
}
stash:drop() {
    if [ "$1" ]; then
        git stash drop stash@{$1}
    else
        git stash drop
    fi
}
alias gstp='stash:pop'
alias gsta='stash:apply'
alias gsts='stash:show'
alias gstsp='stash:show-patch'
alias gstd='stash:drop'

# gco - checkout git branch
gco() {
  if [ "$1" ]; then
    git checkout "$1"
  else
    local branches branch
    branches=$(git branch --no-color | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
}

# fcoa - checkout git branch (including remote branches)
gcoa() {
  local branches branch
  branches=$(git branch --all --no-color | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fbd - delete git branch
fbd() {
  local branches branch
  branches=$(git branch -vv --no-color) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -d $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fgst - pick files from `git status -s`
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fgs() {
    # "Nothing to see here, move along"
    is_in_git_repo || return

    local cmd="${FZF_CTRL_T_COMMAND:-"command git status --porcelain"}"

    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while (read -r item) {
        atom $(printf '%q ' "$item" | cut -d " " -f 2)
    }
}

# gm - merge git branch
gm() {
  if [ "$1" ]; then
    git merge "$1"
  else
    local branches branch
    branches=$(git branch --no-color | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git merge $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
}

gpso() {
    branch=$(echo -n $(git rev-parse --abbrev-ref HEAD))
    git push --set-upstream origin "$branch"
}

gpsonv() {
    branch=$(echo -n $(git rev-parse --abbrev-ref HEAD))
    git push --set-upstream --no-verify origin "$branch"
}

# ln -s /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge /usr/local/bin/smerge
alias sm='smerge'
alias sm.='smerge .'

# From git plugin
alias gcl='git clone --recurse-submodules'
