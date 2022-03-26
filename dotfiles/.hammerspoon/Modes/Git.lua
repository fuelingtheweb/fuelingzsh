local Git = {}
Git.__index = Git

Git.lookup = {
    y = 'copyBranch',
    u = 'discardChanges',
    i = 'checkoutIncludingAll',
    o = 'checkout',
    p = 'diff',
    open_bracket = 'merge',
    close_bracket = 'rebase',
    h = 'status',
    j = 'reset',
    k = 'commit',
    l = 'log',
    semicolon = 'fetchMaster',
    quote = 'checkoutMaster',
    return_or_enter = 'stageAll',
    n = 'newBranch',
    m = 'deleteBranch',
    comma = 'pull',
    period = 'push',
    slash = 'stash',
    right_shift = 'stashApply',
    spacebar = nil
}

function Git.copyBranch() ks.type('gbc').enter() end

function Git.discardChanges() ks.type('nah') end

function Git.reset() ks.type('grs').enter() end

function Git.checkout() ks.type('git:checkout').enter() end

function Git.checkoutIncludingAll() ks.type('git:checkout.include-all').enter() end

function Git.push() ks.type('git push').enter() end

function Git.status() ks.type('git:status').enter() end

function Git.pull() ks.type('git pull').enter() end

function Git.merge() ks.type('gmm').enter() end

function Git.rebase() ks.type('grm').enter() end

function Git.newBranch()
    ks.type('git:branch.new ')
    md.CaseDialog.handle('i')
end

function Git.log() ks.type('git:log').enter() end

function Git.diff() ks.type('gd').enter() end

function Git.stageAll() ks.type('gaa').enter() end

function Git.commit()
    ks.type('git:commit ')
    BracketMatching.start()
end

function Git.checkoutMaster() ks.type('goml').enter() end

function Git.fetchMaster() ks.type('gum').enter() end

function Git.deleteBranch() ks.type('git:branch.delete').enter() end

function Git.stash() ks.type('gstu').enter() end

function Git.stashApply() ks.type('gstp').enter() end

return Git
