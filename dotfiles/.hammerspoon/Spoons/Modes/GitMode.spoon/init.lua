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
    semicolon = nil,
    quote = nil,
    return_or_enter = 'serveCurrentProject',
    n = 'newBranch',
    m = 'merge',
    comma = 'pull',
    period = 'push',
    slash = 'checkoutMaster',
    right_shift = nil,
    spacebar = nil,
}

function GitMode.handle(key)
    if GitMode.lookup[key] then
        GitMode[GitMode.lookup[key]]()
    end
end

function GitMode.copyBranch()
    typeAndEnter('gbc')
end

function GitMode.discardChanges()
    Pending.run({
        function()
            typeAndEnter('grs')
        end,
        function()
            typeAndEnter('nah')
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
    fastKeyStroke({'shift', 'alt', 'cmd'}, 'j')
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
    Pending.run({
        function()
            insertText("git:commit ''")
            fastKeyStroke('left')
        end,
        function()
            typeAndEnter('git:commit')
        end,
    })
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

return GitMode
