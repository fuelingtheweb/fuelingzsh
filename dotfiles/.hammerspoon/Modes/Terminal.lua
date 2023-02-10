local Terminal = {}
Terminal.__index = Terminal

Terminal.lookup = {
    y = nil,
    u = nil,
    i = 'allTests',
    o = 'jumpToFolder',
    p = nil,
    open_bracket = 'buildFresh',
    close_bracket = nil,
    h = 'home',
    j = 'autocompleteNextWord',
    k = nil,
    l = 'list',
    semicolon = nil,
    quote = 'build',
    return_or_enter = ProjectManager.serveCurrent,
    n = nil,
    m = 'clear',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Terminal.home()
    ks.typeAndEnter('hc')
end

function Terminal.list()
    ks.typeAndEnter('ll')
end

function Terminal.clear()
    if is.In(warp) then
        ks.cmd('k')
    else
        ks.typeAndEnter('clear')
    end
end

function Terminal.autocompleteNextWord()
    ks.super('j')
end

function Terminal.allTests()
    ks.typeAndEnter('t')
end

function Terminal.build()
    ks.typeAndEnter('ci && yi && yd')
end

function Terminal.buildFresh()
    ks.typeAndEnter('ci && yi && yd && amgfs')
end

return Terminal
