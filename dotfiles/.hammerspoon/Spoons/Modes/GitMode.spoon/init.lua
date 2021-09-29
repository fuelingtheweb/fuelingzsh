local GitMode = {}
GitMode.__index = GitMode

GitMode.lookup = {
    y = 'copyBranch',
    u = 'discardChanges',
    i = 'stageAll',
    o = 'checkout',
    p = 'diff',
    open_bracket = 'deleteBranch',
    close_bracket = nil,
    h = 'status',
    j = 'autocompleteNextWord',
    k = 'commit',
    l = 'log',
    semicolon = 'stash',
    quote = 'stashApply',
    return_or_enter = 'serveCurrentProject',
    n = 'newBranch',
    m = 'merge',
    comma = 'pull',
    period = 'push',
    slash = 'checkoutMaster',
    right_shift = nil,
    spacebar = nil,
}

function GitMode.copyBranch()
    typeAndEnter('gbc')
end

function GitMode.discardChanges()
    Pending.run({
        function()
            typeAndEnter('grs')
        end,
        function()
            insertText('nah')
        end,
    })
end

function GitMode.checkout()
    Pending.run({
        function()
            typeAndEnter('git:checkout')
        end,
        function()
            typeAndEnter('git:checkout.include-all')
        end,
    })
end

function GitMode.push()
    typeAndEnter('git push')
end

function GitMode.status()
    typeAndEnter('git:status')
end

function GitMode.autocompleteNextWord()
    fastSuperKeyStroke('j')
end

function GitMode.pull()
    typeAndEnter('git pull')
end

function GitMode.serveCurrentProject()
    ProjectManager.serveCurrent()
end

function GitMode.merge()
    Pending.run({
        function()
            typeAndEnter('git:merge')
        end,
        function()
            typeAndEnter('gmm')
        end,
    })
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
    Pending.run({
        function()
            typeAndEnter('gum')
        end,
        function()
            typeAndEnter('goml')
        end,
        function()
            typeAndEnter('gom')
        end,
    })
end

function GitMode.deleteBranch()
    typeAndEnter('git:branch.delete')
end

function GitMode.stash()
    Pending.run({
        function()
            typeAndEnter('gstu')
        end,
        function()
            typeAndEnter('gst')
        end,
    })
end

function GitMode.stashApply()
    Pending.run({
        function()
            typeAndEnter('gstp')
        end,
        function()
            typeAndEnter('gsta')
        end,
    })
end

return GitMode
