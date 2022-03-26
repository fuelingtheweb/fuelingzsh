local Terminal = {}
Terminal.__index = Terminal

Terminal.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = 'home',
    j = 'autocompleteNextWord',
    k = nil,
    l = 'list',
    semicolon = nil,
    quote = nil,
    return_or_enter = 'serveCurrentProject',
    n = nil,
    m = 'clear',
    comma = nil,
    period = nil,
    slash = 'navigate',
    right_shift = nil,
    spacebar = nil
}

function Terminal.home() ks.type('hc').enter() end

function Terminal.list() ks.type('ll').enter() end

function Terminal.navigate() ks.type('cd ') end

function Terminal.clear() ks.type('clear').enter() end

function Terminal.autocompleteNextWord() fastSuperks.slow().key('j') end

function Terminal.serveCurrentProject() ProjectManager.serveCurrent() end

return Terminal
