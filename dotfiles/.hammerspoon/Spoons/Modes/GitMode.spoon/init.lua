local GitMode = {}
GitMode.__index = GitMode

GitMode.lookup = {
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
    spacebar = nil,
}

function GitMode.copyBranch()
    typeAndEnter('gbc')
end

function GitMode.discardChanges()
    insertText('nah')
end

function GitMode.reset()
    typeAndEnter('grs')
end

function GitMode.checkout()
    typeAndEnter('git:checkout')
end

function GitMode.checkoutIncludingAll()
    typeAndEnter('git:checkout.include-all')
end

function GitMode.push()
    typeAndEnter('git push')
end

function GitMode.status()
    typeAndEnter('git:status')
end

function GitMode.pull()
    typeAndEnter('git pull')
end

function GitMode.merge()
    typeAndEnter('gmm')
end

function GitMode.rebase()
    typeAndEnter('grm')
end

function GitMode.newBranch()
    insertText('git:branch.new ')
    spoon.CaseDialog.handle('i')
end

function GitMode.log()
    typeAndEnter('git:log')
end

function GitMode.diff()
    typeAndEnter('gd')
end

function GitMode.stageAll()
    typeAndEnter('gaa')
end

function GitMode.commit()
    insertText('git:commit ')
    BracketMatching.start()
end

function GitMode.checkoutMaster()
    typeAndEnter('goml')
end

function GitMode.fetchMaster()
    typeAndEnter('gum')
end

function GitMode.deleteBranch()
    typeAndEnter('git:branch.delete')
end

function GitMode.stash()
    typeAndEnter('gstu')
end

function GitMode.stashApply()
    typeAndEnter('gstp')
end

return GitMode
