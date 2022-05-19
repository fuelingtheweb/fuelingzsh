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
    spacebar = 'addPrComment',
}

function Git.copyBranch()
    ks.typeAndEnter('gbc')
end

function Git.discardChanges()
    ks.type('nah')
end

function Git.reset()
    if is.vscode() then
        Git.nextGitConflict()
    else
        ks.typeAndEnter('grs')
    end
end

function Git.nextGitConflict()
    ks.slow().shiftAltCmd('g').slow().shiftAltCmd('j')
end

function Git.previousGitConflict()
    ks.slow().shiftAltCmd('g').slow().shiftAltCmd('k')
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
    if is.vscode() then
        ks.type('```suggestion').enter().enter().type('```').up()
    else
        ks.type('git:branch.new ')

        hs.timer.doAfter(0.1, function()
            md.CaseDialog.handle('i')
        end)
    end
end

function Git.log()
    if is.vscode() then
        ks.shiftAltCmd('g').shiftAltCmd('h')
    else
        ks.typeAndEnter('git:log')
    end
end

function Git.diff()
    if is.vscode() then
        ks.super('g').super('p')
    else
        ks.typeAndEnter('gd')
    end
end

function Git.stageAll()
    ks.typeAndEnter('gaa')
end

function Git.commit()
    if is.vscode() then
        Git.nextGitConflict()
    else
        ks.type('git:commit ')
        Brackets.start()
    end
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

function Git.addPrComment()
    ks.shiftAltCmd('g').shiftAltCmd('space')
end

return Git
