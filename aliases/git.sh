alias g='git'

alias ga='git add'
alias gah='git add --help'
alias gaa='git add -A'

alias gb='git:branch.list'
alias gbh='git branch --help'
alias gba='git branch -av'
alias gbc='git:branch.current | pbcopy'
alias gbr='git:branch.rename'
alias gbd='git:branch.delete'
alias gbdf='git:branch.force-delete'

alias gc='git:commit'
alias gch='git commit --help'
alias gcm='git commit --amend --no-edit'
alias gcme='git commit --amend'

alias gcp='git cherry-pick'
alias gcph='git cherry-pick --help'
alias gcpn='git cherry-pick -n'

alias gcl='git clone --recurse-submodules'
alias gci='git check-ignore -v'
alias gcc='git:copy-commits'

alias gd='git diff'
alias gdh='git diff --help'
alias gds='git diff --staged'

alias gf='git fetch'
alias gfp='git fetch --prune'

# Git Flow Commands
alias gfi='git flow init'
alias gfid='git flow init -d'
alias gfhs='git flow hotfix start'
alias gfhf='git flow hotfix finish'
alias gfco='git flow feature checkout'
alias gffs='git flow feature start'
alias gffp='git flow feature publish'
alias gfff='git flow feature finish'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'

alias gin='git init'
alias gig='st .gitignore'

alias gl='git:log'

alias gm='git:merge'
alias gmm='git merge $(git:master-branch)'
alias gmd='git merge develop'
alias gma='git merge --abort'

alias go='git:checkout'
alias goh='git checkout --help'
alias gon='git:branch.new'
alias gop='git checkout -'
alias goa='git:checkout.include-all'
alias gom='git:checkout-master'
alias god='git checkout develop'
alias goml='git:checkout-master && git pull'
alias godl='git checkout develop && git pull'

alias gps='git push'
alias gpsn='git push --no-verify'
alias gpst='git push origin --tags'
alias gpsu='git:push-set-upstream'
alias gpl='git pull'
alias gpr='git:pull-request'

alias gr='git:rebase'
alias grm='git rebase $(git:master-branch)'
alias grd='git rebase develop'
alias grc='git rebase --continue'
alias gra='git rebase --abort'

alias grs='git reset'
alias grsh='git reset --hard'

alias grmv='git remote -v'
alias grmr='git remote rm'
alias grma='git remote add'
alias grmsu='git remote set-url'

alias gs='git:status'
alias gsf='git:status.fuzzy'
alias gsh='git show'

alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'

alias gst='git stash'
alias gstu='git stash -u'
alias gstl='git stash list'
alias gstc='git stash clear'
alias gstsv='git stash save'
alias gstsvu='git stash save -u'
alias gstp='git:stash.pop'
alias gsta='git:stash.apply'
alias gsts='git:stash.show'
alias gstsp='git:stash.show-patch'
alias gstd='git:stash.drop'

alias gt='git tag'
alias gtt='git tag | tail'
alias gtc='echo -n $(git tag | tail -1) | pbcopy'

alias guc='git:uncommit'
alias gus='git:unstage'
alias gum='git:update-master'

alias nah='git reset --hard; git clean -df;'
alias cdu='cd $(git rev-parse --show-toplevel)'
alias tl='lint:tlint'

# ln -s /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge /usr/local/bin/smerge
alias sm='smerge'
alias sm.='smerge .'

function git:is-in-repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function git:checkout() {
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

function git:checkout.include-all() {
  local branches branch
  branches=$(git branch --all --no-color | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

function git:branch.exists() {
    local branch=${1}
    local existed_in_local=$(git branch --list ${branch})

    if [[ -z ${existed_in_local} ]]; then
        echo 0
    else
        echo 1
    fi
}

function git:branch.current() {
    echo -n $(git rev-parse --abbrev-ref HEAD)
}

function git:branch.list() {
    git for-each-ref --sort=committerdate refs/heads/ --format="%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))"
}

function git:branch.new() {
    git checkout -b $1
}

function git:branch.rename() {
    local branchName=$1
    if [[ -z $branchName ]]; then
        branchName="ntm/$(git:branch.current)"
    fi

    git branch -m $branchName
}

function git:branch.delete() {
  local branches branch
  branches=$(git branch -vv --no-color) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -d $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function git:branch.force-delete() {
  local branches branch
  branches=$(git branch -vv --no-color) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function git:checkout-master() {
    git checkout $(git:master-branch)
}

function git:commit() {
    if [ "$1" ]; then
        git commit -m "$1"
    else
        git commit
    fi
}

function git:copy-commits() {
    git log --no-merges --reverse --pretty=format:'- %s' $(git:master-branch).. | pbcopy
}

function git:log() {
    git log --graph --date=short
}

function git:master-branch() {
    if [[ $(git:branch.exists 'main') == 1 && $(git:branch.exists 'master') == 0 ]]; then
        echo 'main'
    else
        echo 'master'
    fi
}

function git:merge() {
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

function git:pull-request() {
    local branchName=$(git:branch.current)
    if [[ $branchName != $'ntm/'* ]]; then
        echo 'Prepend branch name with ntm/ before proceeding.'
        return
    fi

    git:push-set-upstream

    if [ $? -eq 0 ]; then
        git:copy-commits
        githubUrl=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
        prUrl="$githubUrl/compare/$(git:master-branch)...$(git:branch.current)?expand=1"
        open $prUrl;
    else
        echo 'failed to push commits and open a pull request.';
    fi
}

function git:push-set-upstream() {
    git push --set-upstream origin $(git:branch.current)
}

function git:rebase() {
  if [ "$1" ]; then
    git rebase "$1"
  else
    local branches branch
    branches=$(git branch --no-color | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git rebase $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
}

function git:status() {
    git status -sb
}

function git:status.fuzzy() {
    # "Nothing to see here, move along"
    git:is-in-repo || return

    local cmd="${FZF_CTRL_T_COMMAND:-"command git status --porcelain"}"

    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while (read -r item) {
        atom $(printf '%q ' "$item" | cut -d " " -f 2)
    }
}

function git:stash.pop() {
    if [ "$1" ]; then
        git stash pop stash@{"$1"}
    else
        git stash pop
    fi
}

function git:stash.apply() {
    if [ "$1" ]; then
        git stash apply stash@{$1}
    else
        git stash apply
    fi
}

function git:stash.show() {
    if [ "$1" ]; then
        git stash show stash@{$1}
    else
        git stash show
    fi
}

function git:stash.show-patch() {
    if [ "$1" ]; then
        git stash show -p stash@{$1}
    else
        git stash show -p
    fi
}

function git:stash.drop() {
    if [ "$1" ]; then
        git stash drop stash@{$1}
    else
        git stash drop
    fi
}

function git:update-master() {
    local branch=$(git:branch.current)
    git:checkout-master
    git pull
    git checkout $branch
}

function git:uncommit() {
    git reset --soft HEAD^
}

function git:unstage() {
    git reset HEAD
}

function lint:tlint() {
    git status --porcelain | grep '??' | cut -f2 -d' ' | xargs -L1 ~/.fuelingzsh/bin/tlint-run.sh
    git status --porcelain | grep ' M ' | cut -f3 -d' ' | xargs -L1 ~/.fuelingzsh/bin/tlint-run.sh
}
