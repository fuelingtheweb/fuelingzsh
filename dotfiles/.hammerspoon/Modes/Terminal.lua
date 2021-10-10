local TerminalMode = {}
TerminalMode.__index = TerminalMode

TerminalMode.lookup = {
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
    spacebar = nil,
}

function TerminalMode.home()
    typeAndEnter('hc')
end

function TerminalMode.list()
    typeAndEnter('ll')
end

function TerminalMode.navigate()
    insertText('cd ')
end

function TerminalMode.clear()
    typeAndEnter('clear')
end

function TerminalMode.autocompleteNextWord()
    fastSuperKeyStroke('j')
end

function TerminalMode.serveCurrentProject()
    ProjectManager.serveCurrent()
end

return TerminalMode
