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
    ks.typeAndEnter('gbc')
end

function Git.discardChanges()
    ks.type('nah')
end

function Git.reset()
    ks.typeAndEnter('grs')
end

function Git.checkout()
    ks.typeAndEnter('git:checkout')
end

function Git.checkoutIncludingAll()
    ks.typeAndEnter('git:checkout.include-all')
end

function Git.push()
    ks.typeAndEnter('git push')
end

function Git.status()
    ks.typeAndEnter('git:status')
end

function Git.pull()
    ks.typeAndEnter('git pull')
end

function Git.merge()
    ks.typeAndEnter('gmm')
end

function Git.rebase()
    ks.typeAndEnter('grm')
end

function Git.newBranch()
    ks.type('git:branch.new')

    hs.timer.doAfter(0.1, function()
        md.CaseDialog.handle('i')
    end)
end

function Git.log()
    ks.typeAndEnter('git:log')
end

function Git.diff()
    ks.typeAndEnter('gd')
end

function Git.stageAll()
    ks.typeAndEnter('gaa')
end

function Git.commit()
    ks.type('git:commit ')
    Brackets.start()
end

function Git.checkoutMaster()
    ks.typeAndEnter('goml')
end

function Git.fetchMaster()
    ks.typeAndEnter('gum')
end

function Git.deleteBranch()
    ks.typeAndEnter('git:branch.delete')
end

function Git.stash()
    ks.typeAndEnter('gstu')
end

function Git.stashApply()
    ks.typeAndEnter('gstp')
end

return Git
