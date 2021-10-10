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
    spacebar = nil,
}

function Git.copyBranch()
    typeAndEnter('gbc')
end

function Git.discardChanges()
    insertText('nah')
end

function Git.reset()
    typeAndEnter('grs')
end

function Git.checkout()
    typeAndEnter('git:checkout')
end

function Git.checkoutIncludingAll()
    typeAndEnter('git:checkout.include-all')
end

function Git.push()
    typeAndEnter('git push')
end

function Git.status()
    typeAndEnter('git:status')
end

function Git.pull()
    typeAndEnter('git pull')
end

function Git.merge()
    typeAndEnter('gmm')
end

function Git.rebase()
    typeAndEnter('grm')
end

function Git.newBranch()
    insertText('git:branch.new ')
    md.CaseDialog.handle('i')
end

function Git.log()
    typeAndEnter('git:log')
end

function Git.diff()
    typeAndEnter('gd')
end

function Git.stageAll()
    typeAndEnter('gaa')
end

function Git.commit()
    insertText('git:commit ')
    BracketMatching.start()
end

function Git.checkoutMaster()
    typeAndEnter('goml')
end

function Git.fetchMaster()
    typeAndEnter('gum')
end

function Git.deleteBranch()
    typeAndEnter('git:branch.delete')
end

function Git.stash()
    typeAndEnter('gstu')
end

function Git.stashApply()
    typeAndEnter('gstp')
end

return Git
