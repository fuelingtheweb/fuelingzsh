local GitMode = {}
GitMode.__index = GitMode

GitMode.lookup = {
    y = nil,
    u = 'discardChanges',
    i = nil,
    o = 'checkout',
    p = 'push',
    open_bracket = nil,
    close_bracket = nil,
    h = 'status',
    j = 'autocompleteNextWord',
    k = nil,
    l = 'pull',
    semicolon = nil,
    quote = nil,
    return_or_enter = 'serveCurrentProject',
    n = nil,
    m = 'merge',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function GitMode.handle(key)
    if GitMode.lookup[key] then
        GitMode[GitMode.lookup[key]]()
    end
end

function GitMode.discardChanges()
    typeAndEnter('nah')
end

function GitMode.checkout()
    typeAndEnter('git:checkout')
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
    typeAndEnter('git:merge')
end

return GitMode
